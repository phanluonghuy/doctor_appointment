import 'package:doctor_appointment/utils/regex.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../res/texts/app_text.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../viewModel/forgorPassword_viewmodel.dart';
import '../../viewModel/user_viewmodel.dart';

class ChangePasswordSuccess extends StatefulWidget {
  const ChangePasswordSuccess({super.key});

  @override
  State<ChangePasswordSuccess> createState() => _ChangePasswordSuccessState();
}

class _ChangePasswordSuccessState extends State<ChangePasswordSuccess> {
  final TextEditingController _emailController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocusNode = FocusNode();
  @override
  void dispose() {
    _emailController.dispose();
    _scrollController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _scrollToFocusedWidget() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_emailFocusNode.hasFocus) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/illustrations/password-changeSuccess.svg',
                  height: height * 0.4,
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Success",
                    style:
                    AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "We have successfully changed your password. Please login with your new password",),
                ),
                SizedBox(height: height * 0.03),
                SizedBox(height: height * 0.03),

              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(padding: EdgeInsets.all(20),
      child: PrimaryButton(
        text: "Go to Login",
        loading: context.watch<ForgotPasswordViewModel>().loading,
        onPressed: () {
          context.go('/login');
        },
        context: context,
      ),),
    );
  }
}
