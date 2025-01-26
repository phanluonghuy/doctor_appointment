import 'dart:convert';

import 'package:chatview/chatview.dart';
import 'package:doctor_appointment/models/doctorModel.dart';
import 'package:doctor_appointment/repository/chat_repository.dart';
import 'package:doctor_appointment/repository/doctor_repository.dart';
import 'package:doctor_appointment/utils/socketio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';

import '../models/chatModel.dart';
import '../res/widgets/app_urls.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

class ChatViewModel with ChangeNotifier {
  final _chatRepo = ChatRepository();
  final _doctorRepository = DoctorRepository();

  List<Conversation> conversations = [];
  List<Doctor> doctors = [];
  List<Doctor> get getDoctors => doctors;

  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ChatViewState _chatViewState = ChatViewState.loading;
  ChatViewState get chatViewState => _chatViewState;
  void setChatViewState(ChatViewState value) {
    _chatViewState = value;
    notifyListeners();
  }

  Future<void> getAllDoctors(BuildContext context) async {
    setLoading(true);
    _doctorRepository.getAllDoctors().then((value) {
      setLoading(false);
      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(value.description ?? "", context);
        return;
      }
      doctors.clear();
      value.data.forEach((doctor) {
        doctors.add(Doctor.fromJson(doctor));
      });
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context, isBottom: false);
      print(error);
      setLoading(false);
    });
  }

  Future<void> getConversationsByUserId(String id, BuildContext context) async {
    try {
      setLoading(true);
      final value = await _chatRepo.getConversationsByUserId(id);

      if (value.acknowledgement == false) {
        Utils.flushBarErrorMessage(
            value.description ?? "An error occurred.", context);
        return;
      }

      conversations.clear();
      conversations.addAll(
        (value.data as List)
            .map((conversation) => Conversation.fromJson(conversation))
            .toList(),
      );
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateConversation(String id, BuildContext context) async {
    await _chatRepo.updateConversationById(id);
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

  Conversation? getConversation(String from, String to) {
    Conversation? existConversation = conversations.firstWhereOrNull(
      (conversation) {
        final participantIds =
            conversation.participants?.map((user) => user.id).toList() ?? [];
        return participantIds.contains(from) && participantIds.contains(to) && from != to;
      },
    );

    return existConversation;
  }

  Future<void> createConversation(String from, String to, BuildContext context) async {
    try {
      setLoading(true);
      Map<String, dynamic> data = {"userId1": from, "userId2": to};
      await _chatRepo.createConversation(data);
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    } finally {
      setLoading(false);
    }
  }
}
