import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/buttons/primaryButton.dart';
import 'package:doctor_appointment/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:doctor_appointment/viewModel/auth_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authviewmodel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.08),
              Text("Sign in", style: AppTextStyle.title),
              SizedBox(height: height * 0.03),
              Text("Hi, Welcome back,you've been missed"),
              SizedBox(height: height * 0.05),
              Align(alignment: Alignment.centerLeft, child: Text("Email")),
              SizedBox(height: height * 0.01),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  Utils.changeNodeFocus(context,
                      current: _emailFocus, next: _passwordFocus);
                },
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Align(alignment: Alignment.centerLeft, child: Text("Password")),
              SizedBox(height: height * 0.01),
              ValueListenableBuilder<bool>(
                valueListenable: _obsecureNotifier,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: value,
                    onFieldSubmitted: (value) {
                      Utils.changeNodeFocus(context,
                          current: _passwordFocus, next: _passwordFocus);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon:
                            Icon(value ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          _obsecureNotifier.value = !_obsecureNotifier.value;
                        },
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, RoutesNames.forgotPassword);
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
              SizedBox(height: height * 0.02),
              PrimaryButton(
                  text: "Sign In",
                  loading: authviewmodel.loading,
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Email must be provide", context);
                      return;
                    }
                    if (_passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Password must be provide", context);
                      return;
                    }
                    // if (_passwordController.text.isEmpty) {
                    //   Utils.flushBarErrorMessage(
                    //       "Password must be provide", context);
                    //   return;
                    // }
                    if (AppRegex.isValidEmail(_emailController.text) == false) {
                      Utils.flushBarErrorMessage(
                          "Email not valid", context);
                      return;
                    }
        
                    Map data = {
                      "email": _emailController.text.toString(),
                      "password": _passwordController.text.toString()
                    };
                    authviewmodel.apilogin(data, context);
                    // debugPrint("hit API");
                  },
                  context: context),
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 2,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Or sign in with"),
                    ),
                    Expanded(
                        child: Divider(
                      height: 2,
                    ))
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/icons8-facebook.svg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/icons8-google.svg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/icons/icons8-apple.svg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                       // Navigator.pushNamed(context, RouteNames.signupScreen);
                      context.push('/signup');
                    },
                    child: Text("Sign up"),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }
}

//! Recalling Providers
// used for state Management (efficicent)
// valueNotifier (for single value)
//  valueListenerBuilder (which listens to this value)
