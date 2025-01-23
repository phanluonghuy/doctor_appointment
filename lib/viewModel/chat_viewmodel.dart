import 'dart:convert';

import 'package:doctor_appointment/repository/chat_repository.dart';
import 'package:flutter/material.dart';

import '../models/chatModel.dart';
import '../utils/utils.dart';

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


}