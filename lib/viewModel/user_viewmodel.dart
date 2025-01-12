import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userModel.dart'; // Make sure you have this User model
import '../repository/user_repository.dart';
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

  Future<void> apiUpdateProfile(dynamic data,dynamic image, BuildContext context) async {
    setLoading(true);
    _userRepository.updateProfile(data,image).then((value) async {
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

  Future<void> changePassword(dynamic data,BuildContext context) async {
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

  // Fetch the user profile (example with your UserRepository)
  Future<void> getUserProfile() async {
    try {
      var token = await getUserToken();
      if (token != null) {
        _userRepository.getProfile().then((value) {
          _user = User.fromJson(value.data);
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
