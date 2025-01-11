import 'package:doctor_appointment/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:doctor_appointment/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  // !SAVE THE USER and set the state!
  Future<bool> saveUser(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("token", token);
    notifyListeners(); // so that the user is saved!
    return true;
  }

// ! REMOVE THE USER and set the state
  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("token");
    notifyListeners(); //so that the user is removed!
    return true;
  }

  // ! get The User

  Future<String?> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString("token");
    return token;
    // return UserModel(token: token.toString());
  }
}
