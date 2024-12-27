import 'package:flutter/material.dart';
import 'package:doctor_appointment/models/user_model.dart';
import 'package:doctor_appointment/repository/auth_repository.dart';
import 'package:doctor_appointment/utils/routes/routes_names.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loginLoading = false;
  bool _signupLoading = false;
  bool _termsAccepted = false;

  get loading => _loginLoading;
  get signupLoading => _signupLoading;
  get termsAccepted => _termsAccepted;

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setSignUpLoading(bool value) {
    _signupLoading = value;
    notifyListeners();
  }

  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  Future<void> apilogin(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    _auth.apiLogin(data).then((value) {
      setLoginLoading(false);
      print(value.toString());

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(UserModel(token: value['token'].toString()));

      Utils.flushBarErrorMessage("Login Successfully", context);

      context.go('/home');
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setLoginLoading(false);
    });
  }

  Future<void> apiSignUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _auth.signUp(data).then((value) {
      Utils.flushBarErrorMessage("Sign Up Successfully", context);

      // Navigator.pushNamed(context, RouteNames.home);
      context.go('/home');
      setSignUpLoading(false);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      setSignUpLoading(false);
    });
  }
}
