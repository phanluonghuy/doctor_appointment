import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

import "../../res/texts/app_text.dart";
import "../../res/widgets/buttons/primaryButton.dart";
import "../../utils/regex.dart";
import "../../utils/utils.dart";
import "../../viewModel/signup_viewmodel.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final signupviewmodel = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.08),
              Text("Create Account", style: AppTextStyle.title),
              SizedBox(height: height * 0.03),
              Text(
                  "Fill your information below or register \n with your social media",
                  textAlign: TextAlign.center),
              SizedBox(height: height * 0.05),
              Align(alignment: Alignment.centerLeft, child: Text("Name")),
              SizedBox(height: height * 0.01),
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  Utils.changeNodeFocus(context,
                      current: _nameFocus, next: _emailFocus);
                },
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Align(alignment: Alignment.centerLeft, child: Text("Email")),
              SizedBox(height: height * 0.01),
              TextFormField(
                controller: _emailController,
                focusNode: _emailFocus,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  Utils.changeNodeFocus(context,
                      current: _emailFocus, next: null);
                },
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                      value: signupviewmodel.termsAccepted,
                      onChanged: (value) {
                        signupviewmodel.setTermsAccepted(value ?? false);
                      }),
                  Expanded(child: Text("I agree to the terms and conditions"))
                ],
              ),
              SizedBox(height: height * 0.02),
              PrimaryButton(
                  text: "Sign Up",
                  loading: signupviewmodel.loading,
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Email must be provide", context);
                      return;
                    }

                    if (_nameController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Name must be provide", context);
                      return;
                    }

                    if (AppRegex.isValidEmail(_emailController.text) == false) {
                      Utils.flushBarErrorMessage(
                          "Email must be valid", context);
                      return;
                    }

                    if (signupviewmodel.termsAccepted == false) {
                      Utils.flushBarErrorMessage(
                          "You must accept the terms and conditions", context);
                      return;
                    }
                    signupviewmodel.setName(_nameController.text);
                    signupviewmodel.setEmail(_emailController.text);
                    final data = {
                      "email": _emailController.text,
                    };
                    signupviewmodel.apiSendOTP(data, context);
                    // context.go('/otp');
                    // context.push('/otp');

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
                      child: Text("Or sign up with"),
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
                  Text("Already have an account ?"),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, RouteNames.login);
                      context.push('/login');
                    },
                    child: Text("Sign in"),
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
  }
}
