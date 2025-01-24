import 'dart:io';
import 'dart:typed_data';

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
import '../viewModel/chat_viewmodel.dart';
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
  late bool _isOnline = false;

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
    _isOnline = SocketService.isUserOnline(otherUser.id);

    _chatController = ChatController(
      initialMessageList: [],
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
    SocketService.onSeenResponse(handleSeenResponse);
    SocketService.joinRoom(conversation.id!);
  }

  void handleSeenResponse(dynamic response) {
    String userId = response['userId'];
    int modifiedCount = response['modifiedCount'];
    if (modifiedCount != 0) {
      Message lastMsg = _chatController.initialMessageList.last;
      if (lastMsg.sentBy != userId) {
        lastMsg.setStatus = MessageStatus.read;
      }
    }
  }

  void loadNewMessage(dynamic message) async{
    if (!mounted) return;
    if (!_chatController.initialMessageList.any((msg) => msg.id == message['_id'])) {
      _chatController.addMessage(
        Message(
          id: message['_id'] as String,
          message: message['content'] as String,
          createdAt: DateTime.parse(message['createdAt']),
          sentBy: message['from'] as String,
          messageType: Utils.getMessageType(message['messageType'] as String),
          status: Utils.getMessageStatus(message['status'] as String),
        ),
      );
      SocketService.seen(widget.conversation.id!);
    }
    if (!mounted) return;

    final chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
    await chatViewModel.updateConversation(widget.conversation.id!, context);
    await chatViewModel.getConversationsByUserId(currentUser.id, context);
  }

  void loadHistory(dynamic data) {
    data.forEach((message) {
      final messageId = message['_id'] as String;

      if (!_chatController.initialMessageList.any((msg) => msg.id == messageId)) {
        _chatController.addMessage(Message(
          id: messageId,
          message: message['content'] as String,
          createdAt: DateTime.parse(message['createdAt']),
          sentBy: message['from'] as String,
          messageType: Utils.getMessageType(message['messageType'] as String),
          status: Utils.getMessageStatus(message['status'] as String),
        ));
      }
    });
  }

  void _onSendTap(String message, _, MessageType messageType) async {
    if (messageType.isImage) {
      final chatViewModel = context.read<ChatViewModel>();
      message = await chatViewModel.uploadImage(message);
    }

    SocketService.sendMessage({
      'from': currentUser.id,
      'to': otherUser.id,
      'content': message,
      'messageType': messageType.name,
    });
  }

  void _onViewImage(Message message) async{
    showAdaptiveDialog(
      context: context,
      builder: (context)  =>
          Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: message.message.startsWith("http")
                  ? NetworkImage(message.message)
                  : AssetImage(message.message),
              wantKeepAlive: true,
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              enableRotation: false,
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
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
              _isOnline ? "Online" : "Offline",
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
          enableTextField: true,
          enablePagination: true,
          enableChatSeparator: true,
          enableSwipeToSeeTime: true,
          enableCurrentUserProfileAvatar: true,
          enableOtherUserName: true,
          enableOtherUserProfileAvatar: true,
          enableReplySnackBar: false,
          enableReactionPopup: false,
          enableSwipeToReply: false,
          enableDoubleTapToLike: false,
        ),
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
            enabled: true,
          ),
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
