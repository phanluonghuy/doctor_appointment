import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatview/chatview.dart';
import 'package:doctor_appointment/models/chatModel.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:doctor_appointment/utils/socketio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../models/userModel.dart';
import '../res/widgets/buttons/backButton.dart';
import '../utils/utils.dart';
import '../viewModel/user_viewmodel.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen({super.key, required this.conversation});
  Conversation conversation;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late ChatController _chatController;
  late User currentUser;
  late User otherUser;
  late List<Message> initialMessageList = [];

  @override
  void dispose() {
    SocketService.leaveRoom(widget.conversation.id!);
    super.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final Conversation conversation = widget.conversation;
    final userViewModel = context.read<UserViewModel>();
    currentUser = userViewModel.user!;
    otherUser = conversation.participants!
        .where((user) => user.id != userViewModel.user!.id)
        .first;

    _chatController = ChatController(
      initialMessageList: initialMessageList,
      scrollController: ScrollController(),
      currentUser: ChatUser(
        id: currentUser.id,
        name: currentUser.name,
        profilePhoto: currentUser.avatar!.url,
        imageType: ImageType.network,
      ),
      otherUsers: [
        ChatUser(
          id: otherUser.id,
          name: otherUser.name,
          profilePhoto: otherUser.avatar!.url,
          imageType: ImageType.network,
        )
      ],
    );

    SocketService.onShowHistory(loadHistory);
    SocketService.onNewMessage(loadNewMessage);
    SocketService.joinRoom(conversation.id!);
  }

  void loadNewMessage(dynamic message) {
    _chatController.addMessage(
      Message(
          id: message['_id'] as String,
          message: message['content'] as String,
          createdAt: DateTime.parse(message['createdAt']),
          sentBy: message['from'] as String,
          messageType: Utils.getMessageType(message['messageType'] as String),
          status: Utils.getMessageStatus(message['status'] as String)
      ),
    );
  }

  void loadHistory(dynamic data) {
    data.forEach((message) => _chatController.addMessage(Message(
        id: message['_id'] as String,
        message: message['content'] as String,
        createdAt: DateTime.parse(message['createdAt']),
        sentBy: message['from'] as String,
        messageType: Utils.getMessageType(message['messageType'] as String),
        status: Utils.getMessageStatus(message['status'] as String))));
  }

  void receiveMessage() async {
    _chatController.addMessage(
      Message(
        id: DateTime.now().toString(),
        message: 'I will schedule the meeting.',
        createdAt: DateTime.now(),
        sentBy: '2',
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    _chatController.addReplySuggestions([
      const SuggestionItemData(text: 'Thanks.'),
      const SuggestionItemData(text: 'Thank you very much.'),
      const SuggestionItemData(text: 'Great.')
    ]);
  }

  void _onSendTap(
      String message, ReplyMessage replyMessage, MessageType messageType) async{
    _chatController.addMessage(
      Message(
        id: DateTime.now().toString(),
        createdAt: DateTime.now(),
        message: message,
        sentBy: _chatController.currentUser.id,
        messageType: messageType,
      ),
    );

    SocketService.sendMessage({
      'from': currentUser.id,
      'to': otherUser.id,
      'content': message,
      'messageType': messageType.name,
    });


    // Future.delayed(const Duration(milliseconds: 300), () {
    //   _chatController.initialMessageList.last.setStatus =
    //       MessageStatus.undelivered;
    // });
    // Future.delayed(const Duration(seconds: 1), () {
    //   _chatController.initialMessageList.last.setStatus = MessageStatus.read;
    // });
  }

  void _onViewImage(Message message) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => PhotoView(
        imageProvider: message.message.startsWith("http")
            ? NetworkImage(message.message)
            : AssetImage(message.message),
        wantKeepAlive: true,
        backgroundDecoration: BoxDecoration(color: Colors.transparent),
        enableRotation: true,
        onTapDown: (_, __, ___) => context.pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ChatView(
        appBar: AppBar(
          title: ListTile(
            leading: CachedNetworkImage(
              imageUrl: otherUser.avatar?.url ?? "",
              imageBuilder: (context, imageProvider) => Container(
                width: height * 0.04,
                height: height * 0.04,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            title: Text(
              otherUser.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "Online",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.primaryColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: CustomBackButton(
              color: Colors.white,
              icon: Icons.arrow_back,
              onPressed: () {
                context.pop();
              },
            ),
          ),
          actions: [
            CustomBackButton(
              color: Colors.white,
              icon: Icons.more_vert,
              onPressed: () {
                print(_chatController.initialMessageList);
              },
            ),
          ],
        ),
        chatController: _chatController,
        onSendTap: _onSendTap,
        chatViewState: ChatViewState.hasMessages,
        featureActiveConfig: const FeatureActiveConfig(
            lastSeenAgoBuilderVisibility: true,
            receiptsBuilderVisibility: true,
            enableScrollToBottomButton: true,
            enableDoubleTapToLike: false,
            enableSwipeToReply: false,
            enableTextField: true,
            enablePagination: true,
            enableChatSeparator: true,
            enableSwipeToSeeTime: true,
            enableCurrentUserProfileAvatar: true,
            enableOtherUserName: true,
            enableOtherUserProfileAvatar: true,
            enableReplySnackBar: false,
            enableReactionPopup: false),
        scrollToBottomButtonConfig: ScrollToBottomButtonConfig(
          backgroundColor: AppColors.primaryColor,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            weight: 10,
            size: 30,
          ),
        ),
        chatViewStateConfig: ChatViewStateConfiguration(
            loadingWidgetConfig: ChatViewStateWidgetConfiguration(
              loadingIndicatorColor: AppColors.primaryColor,
            ),
            noMessageWidgetConfig: ChatViewStateWidgetConfiguration(
                title: "Chat with your doctor now!",
                showDefaultReloadButton: false),
            errorWidgetConfig: ChatViewStateWidgetConfiguration(
                showDefaultReloadButton: false)),
        chatBackgroundConfig: ChatBackgroundConfiguration(
          backgroundColor: AppColors.lightPrimaryColor,
        ),
        sendMessageConfig: SendMessageConfiguration(
          enableCameraImagePicker: true,
          enableGalleryImagePicker: true,
          allowRecordingVoice: false,
          imagePickerIconsConfig: ImagePickerIconsConfiguration(
            cameraIconColor: AppColors.primaryColor,
            galleryIconColor: AppColors.primaryColor,
          ),
          defaultSendButtonColor: AppColors.primaryColor,
          textFieldBackgroundColor: Colors.white,
          closeIconColor: AppColors.primaryColor,
          textFieldConfig: TextFieldConfiguration(
              textStyle: TextStyle(color: Colors.black),
              margin: EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(10),
              hintText: "Type a message here...",
              enabled: true),
        ),
        chatBubbleConfig: ChatBubbleConfiguration(
          receiptsWidgetConfig:
              ReceiptsWidgetConfig(showReceiptsIn: ShowReceiptsIn.all),
          outgoingChatBubbleConfig: ChatBubble(
            borderRadius: BorderRadius.circular(8),
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white),
              backgroundColor: AppColors.greyColor,
              bodyStyle: const TextStyle(color: Colors.grey),
              titleStyle: const TextStyle(color: Colors.black),
            ),
            color: AppColors.primaryColor,
            senderNameTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          inComingChatBubbleConfig: ChatBubble(
            borderRadius: BorderRadius.circular(8),
            linkPreviewConfig: LinkPreviewConfiguration(
              linkStyle: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black),
              backgroundColor: AppColors.greyColor,
              bodyStyle: const TextStyle(color: Colors.grey),
              titleStyle: const TextStyle(color: Colors.black),
            ),
            textStyle: TextStyle(color: Colors.black),
            onMessageRead: (message) {
              /// send your message reciepts to the other client
              debugPrint('Message Read');
            },
            senderNameTextStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            color: Colors.white,
          ),
        ),
        messageConfig: MessageConfiguration(
          imageMessageConfig: ImageMessageConfiguration(
            hideShareIcon: true,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            onTap: _onViewImage,
          ),
        ),
        profileCircleConfig: ProfileCircleConfiguration(
          profileImageUrl: otherUser.avatar!.url,
          imageType: ImageType.network,
        ),
      ),
    );
  }
}

class Data {
  // static const profileImage =
  //     "https://res.cloudinary.com/deynivwng/image/upload/v1736613310/Doctor%20Pill%20Storage/1736613306574_good-doctor.jpg.jpg";
  // static final List<Message> messageList = [
  //   // Message(
  //   //   id: '1',
  //   //   message: "Hi!",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '1', // userId of who sends the message
  //   //   status: MessageStatus.read,
  //   //   messageType: MessageType.text
  //   // ),
  //   // Message(
  //   //   id: '2',
  //   //   message: "Hi!",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '2',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '3',
  //   //   message: "We can meet?I am free",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '1',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '4',
  //   //   message: "Can you write the time and place of the meeting?",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '1',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '5',
  //   //   message: "That's fine",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '2',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '6',
  //   //   message: "When to go ?",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '1',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '7',
  //   //   message: "I guess Simform will reply",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '2',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '8',
  //   //   message: "https://bit.ly/3JHS2Wl",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '2',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '9',
  //   //   message: "Done",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '1',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '10',
  //   //   message: "Thank you!!",
  //   //   status: MessageStatus.read,
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '1',
  //   // ),
  //   // Message(
  //   //   id: '11',
  //   //   message: "https://miro.medium.com/max/1000/0*s7of7kWnf9fDg4XM.jpeg",
  //   //   createdAt: DateTime.now(),
  //   //   messageType: MessageType.image,
  //   //   sentBy: '1',
  //   //   status: MessageStatus.read,
  //   // ),
  //   // Message(
  //   //   id: '12',
  //   //   message: "🤩🤩",
  //   //   createdAt: DateTime.now(),
  //   //   sentBy: '2',
  //   //   status: MessageStatus.read,
  //   // ),
  // ];
}
