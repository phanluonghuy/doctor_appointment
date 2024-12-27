import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../repository/auth_repository.dart';
import '../utils/routes/routes_names.dart';
import '../utils/utils.dart';

class SignUpViewModel with ChangeNotifier {
  final _auth = AuthRepository();
  bool _isLoading = false;
  bool _signupLoading = false;
  bool _termsAccepted = false;
  String email = "";
  String name = "";

  get loading => _isLoading;
  get signupLoading => _signupLoading;
  get termsAccepted => _termsAccepted;
  get getEmail => email;
  get getName => name;


  void setLoading(bool value) {
    _isLoading = value;
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

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setName(String value) {
    name = value;
    notifyListeners();
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

  Future<void> apiVerifyOTP(dynamic data, BuildContext context) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
    // _auth.verifyOTP(data).then((value) {
    //   Utils.flushBarErrorMessage("OTP Verified Successfully", context);
    //   context.go('/login');
    //   setLoading(false);
    // }).onError((error, stackTrace) {
    //   Utils.flushBarErrorMessage(error.toString(), context);
    //   setLoading(false);
    // });
  }
}