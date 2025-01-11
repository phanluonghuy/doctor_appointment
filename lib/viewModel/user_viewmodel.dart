import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/userModel.dart'; // Make sure you have this User model
import '../repository/user_repository.dart';

class UserViewModel with ChangeNotifier {
  final _userRepository = UserRepository();
  User? _user;
  User? get user => _user;

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
          print(_user?.name ?? "No name");
          notifyListeners();
        });
      }
    } catch (e) {
      print('Error getting profile: $e');
      rethrow;
    }
  }
}
