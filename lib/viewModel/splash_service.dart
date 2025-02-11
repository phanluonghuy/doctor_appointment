import 'package:doctor_appointment/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/schedule_repository.dart';

class SplashService {
  static Future<void> checkAuthentication(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.getUserProfile();
    if (userViewModel.user == null) {
      context.go('/welcome');
    } else {
      context.go('/navigationMenu');
    }
  }
}
