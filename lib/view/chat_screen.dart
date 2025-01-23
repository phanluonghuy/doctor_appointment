import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/models/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';
import '../res/widgets/coloors.dart';
import '../utils/utils.dart';
import '../viewModel/chat_viewmodel.dart';
import '../viewModel/user_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController searchController = TextEditingController();

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userViewModel = context.read<UserViewModel>();
      final chatViewModel = context.read<ChatViewModel>();
      chatViewModel.getConversationsByUserId(userViewModel.user!.id, context);
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void _handleEnterConversation(Conversation conversation) {
    context.push('/chat/conversation', extra: conversation,);
  }

  List<Widget> buildDoctorsListRow(double height, double width) {
    return List.generate(
      10,
      (index) => CachedNetworkImage(
        imageUrl:
            "https://res.cloudinary.com/deynivwng/image/upload/v1736613310/Doctor%20Pill%20Storage/1736613306574_good-doctor.jpg.jpg",
        imageBuilder: (context, imageProvider) => Container(
          width: height * 0.06,
          height: height * 0.06,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(30)),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: height * 0.03,
          child: Icon(
            Icons.person,
            color: Colors.grey.shade800,
            size: height * 0.03,
          ),
        ),
      ),
    );
  }

  Widget buildDoctorsListColumn(double height, double width, Conversation conversation) {
    final userViewModel = context.read<UserViewModel>();
    final User otherUser = conversation.participants!.where((user) => user.id != userViewModel.user!.id).first;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: SizedBox(
            width: height * 0.05,
            height: height * 0.05,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: otherUser.avatar!.url,
                  imageBuilder: (context, imageProvider) => Container(
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: height * 0.01,
                    height: height * 0.01,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            otherUser.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            conversation.lastMessageContent ?? "",
            style: TextStyle(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            children: [
              Text(
                Utils.formatTimestamp(conversation.lastMessageTimestamp!),
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          onTap: () => _handleEnterConversation(conversation),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final chatViewModel = context.watch<ChatViewModel>();
    final conversations = chatViewModel.conversations;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        bottom: PreferredSize(
          preferredSize: Size(width * 0.1, height * 0.1),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 24),
            child: SearchBar(
              controller: searchController,
              hintText: 'Search Doctor',
              leading: const Icon(Icons.search, color: AppColors.primaryColor),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              shadowColor: WidgetStatePropertyAll(Colors.transparent),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            spacing: 16,
            children: [
              // Row(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: chatViewModel.loading
                    ? Center(child: CircularProgressIndicator())
                    : (conversations.isEmpty
                    ? Center(
                  child: Text(
                    "No doctors available",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                )
                    : Row(
                  spacing: 16,
                  children: buildDoctorsListRow(height, width),
                )),
              ),
              chatViewModel.loading
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : (conversations.isEmpty
                  ? Expanded(
                    child: Center(
                                    child: Text(
                    "No conversations yet",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                  )
                  : Expanded(
                    child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: conversations.length,
                                    itemBuilder: (context, index) =>
                      buildDoctorsListColumn(height, width, conversations[index]),
                                  ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
