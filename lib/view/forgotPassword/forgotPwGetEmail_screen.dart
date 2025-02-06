import 'package:doctor_appointment/utils/regex.dart';
import 'package:doctor_appointment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../res/texts/app_text.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../viewModel/forgorPassword_viewmodel.dart';
import '../../viewModel/user_viewmodel.dart';

class GetEmail extends StatefulWidget {
  const GetEmail({super.key});

  @override
  State<GetEmail> createState() => _GetEmailState();
}

class _GetEmailState extends State<GetEmail> {
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
        title: Text("Forgot Password"),
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
                  'assets/illustrations/mega-creator.svg',
                  height: height * 0.4,
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please enter your registered email",
                    style:
                        AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "We will send you a verification code to your registered email"),
                ),
                SizedBox(height: height * 0.03),
                Align(
                    alignment: Alignment.centerLeft, child: Text("Your Email")),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocusNode,
                  onTap: _scrollToFocusedWidget,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(height: height * 0.03),
                PrimaryButton(
                  text: "Next",
                  loading: context.watch<ForgotPasswordViewModel>().loading,
                  onPressed: () {

                    if (AppRegex.isValidEmail(_emailController.text) == false) {
                      Utils.flushBarErrorMessage("Email is not valid", context);
                      return;
                    }
                    Map<String,dynamic> data = {
                      "email": _emailController.text,
                    };
                    context.read<ForgotPasswordViewModel>().apiSendOTP(data,context);

                  },
                  context: context,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
