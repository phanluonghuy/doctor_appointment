import 'package:flutter/material.dart';
import 'package:doctor_appointment/utils/routes/routes_names.dart';
import 'package:doctor_appointment/viewModel/user_view_model.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();

    if (user!.token.toString() == "null" || user.token.toString() == "") {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, RouteNames.login);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushNamed(context, RouteNames.home);
    }
  }
}
