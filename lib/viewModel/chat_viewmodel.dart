import 'dart:convert';

import 'package:doctor_appointment/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import '../models/chatModel.dart';
import '../res/widgets/app_urls.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;



class ChatViewModel with ChangeNotifier {
  final _chatRepo = ChatRepository();

  List<Conversation> conversations = [];

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> getConversationsByUserId(String id, BuildContext context) async {
    try {
      setLoading(true);
      final value = await _chatRepo.getConversationsByUserId(id);

      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(value.description ?? "An error occurred.", context);
        return;
      }

      conversations.clear();
      conversations.addAll(
        (value.data as List).map((conversation) => Conversation.fromJson(conversation)).toList(),
      );
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateConversation(String id, BuildContext context) async {
    final value = await _chatRepo.updateConversationById(id);
    // if (value.acknowledgement == false) {
    //   Utils.flushBarErrorMessage(value.description ?? "An error occurred.", context);
    //   return;
    // }
  }

  Future<String> uploadImage(String filePath) async {
    final uri = Uri.parse(AppUrls.uploadFileImage);

    final request = http.MultipartRequest('POST', uri);

    final file = await http.MultipartFile.fromPath(
      'image-file',
      filePath,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final responseJson = json.decode(responseData);
    return responseJson['data'];
  }

}