import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:go_router/go_router.dart';

class SplashService {
  static Future<void> checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();

    final token = await userViewModel.getToken();

    if (token == "null" || token == "") {
      context.go('/welcome');
    } else {
      context.go('/navigationMenu');
    }
  }
}
