import 'package:doctor_appointment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../res/texts/app_text.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../viewModel/forgorPassword_viewmodel.dart';
import '../../viewModel/user_viewmodel.dart';

class GetOTP extends StatefulWidget {
  const GetOTP({super.key});

  @override
  State<GetOTP> createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  final FocusNode _otpFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  String _otp = "";

  @override
  void dispose() {
    _scrollController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _scrollToFocusedWidget() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_otpFocusNode.hasFocus) {
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Provider.of<ForgotPasswordViewModel>(context, listen: false)
                .previousPage();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
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
                  'assets/illustrations/mega-creator (1).svg',
                  height: height * 0.4,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please enter your verification code",
                    style: AppTextStyle.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "We have sent a verification code to your registered email"),
                ),
                SizedBox(height: height * 0.03),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  focusNode: _otpFocusNode,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    activeColor: Colors.grey.shade300,
                    inactiveColor: Colors.grey.shade300,
                    selectedColor: Colors.grey.shade300,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black45,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    _otp = v;
                  },
                  onTap: _scrollToFocusedWidget,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: height * 0.02),
                Text("Didn't receive OTP?"),
                InkWell(
                  onTap: () {
                    // Resend OTP
                  },
                  child: Text("Resend OTP",
                      style: AppTextStyle.link.copyWith(
                        color: Colors.blue,
                      )),
                ),
                SizedBox(height: height * 0.03),
                PrimaryButton(
                  text: "Done",
                  loading: context.watch<UserViewModel>().isLoading,
                  onPressed: () {
                    if (_otp.length != 4) {
                      Utils.flushBarErrorMessage('Please enter OTP', context);
                      return;
                    }
                    final data = {
                      "token" : Provider.of<ForgotPasswordViewModel>(context, listen: false).token,
                      "otp" : _otp
                    };
                    Provider.of<ForgotPasswordViewModel>(context, listen: false).apiVerifyOTP(data, context);
                    // Provider.of<ForgotPasswordViewModel>(context, listen: false)
                    //     .nextPage();
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
