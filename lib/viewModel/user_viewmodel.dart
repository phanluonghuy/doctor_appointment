import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:doctor_appointment/models/dosageModel.dart';
import 'package:doctor_appointment/repository/schedule_repository.dart';
import 'package:doctor_appointment/utils/scheduleMedicineNotifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/medicineNotificationModel.dart';
import '../models/userModel.dart'; // Make sure you have this User model
import '../repository/user_repository.dart';
import '../utils/socketio.dart';
import '../utils/utils.dart';

class UserViewModel with ChangeNotifier {
  final _userRepository = UserRepository();
  User? _user;
  bool _isLoading = false;
  User? get user => _user;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> apiUpdateProfile(
      dynamic data, dynamic image, BuildContext context) async {
    setLoading(true);
    _userRepository.updateProfile(data, image).then((value) async {
      // print(value);
      if (value.acknowledgement ?? false) {
        Utils.flushBarSuccessMessage(value.description ?? "", context);
        await getUserProfile();
      } else {
        Utils.flushBarErrorMessage(value.description ?? "", context);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoading(false);
    });
  }

  Future<void> changePassword(dynamic data, BuildContext context) async {
    setLoading(true);
    _userRepository.changePassword(data).then((value) {
      if (value.acknowledgement ?? false) {
        Utils.flushBarSuccessMessage(value.description ?? "", context);
      } else {
        Utils.flushBarErrorMessage(value.description ?? "", context);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoading(false);
    });
  }

  // Save the user token
  Future<bool> saveUser(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", token);
    notifyListeners(); // Notify listeners after saving the user
    return true;
  }

  // Remove the user token
  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("token");
    try {
      SocketService.disconnect();
    } catch (e) {
      print('Error disconnecting socket: $e');
    }
    _user = null; // Clear user data
    notifyListeners(); // Notify listeners after removing the user
    return true;
  }

  // Get the user token from SharedPreferences
  Future<String?> getUserToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString("token");
    return token;
  }

  String generateHash(String input) {
    var bytes = utf8.encode(input); // Convert input to bytes
    var hash = sha256.convert(bytes); // Generate SHA256 hash
    return hash.toString(); // Convert hash to string
  }

  // Fetch the user profile (example with your UserRepository)
  Future<void> getUserProfile() async {
    try {
      var token = await getUserToken();
      if (token != null) {
        _userRepository.getProfile().then((value) {
          if (value.acknowledgement == false) {
            removeUser();
          }
          _user = User.fromJson(value.data);
          // print(_user?.id);
          if (_user != null) {
            SocketService.connect(_user!.id);

            ScheduleRepository()
                .getScheduleMedicines(_user!.id)
                .then((value) async {
              if (value.acknowledgement == true) {
                List<MedicineNotification> medicineNotificationList = [];
                value.data.forEach((element) {
                  MedicineNotification dosage =
                      MedicineNotification.fromJson(element);
                  medicineNotificationList.add(dosage);
                });

                final SharedPreferences sp =
                    await SharedPreferences.getInstance();
                final String? medicineNotification =
                    sp.getString("medicineNotification");

                if (medicineNotification == null ||
                    medicineNotification == "") {
                  sp.setString("medicineNotification",
                      generateHash(medicineNotificationList.toString()));
                  scheduleMedicineNotifications(medicineNotificationList);
                }
                {
                  if (generateHash(medicineNotificationList.toString()) !=
                      medicineNotification) {
                    sp.setString("medicineNotification",
                        generateHash(medicineNotificationList.toString()));
                    scheduleMedicineNotifications(medicineNotificationList);
                  }
                }
              }
            });
          }
          // print(_user?.name ?? "No name");
          notifyListeners();
        });
      }
    } catch (e) {
      print('Error getting profile: $e');
      rethrow;
    }
  }
}
