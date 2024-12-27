import "package:flutter/material.dart";
import "package:doctor_appointment/utils/routes/routes_names.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:pin_code_fields/pin_code_fields.dart";
import "package:provider/provider.dart";

import "../res/texts/app_text.dart";
import "../res/widgets/buttons/primaryButton.dart";
import "../res/widgets/buttons/round_button.dart";
import "../utils/regex.dart";
import "../utils/utils.dart";
import "../viewModel/auth_viewmodel.dart";
import "../viewModel/signup_viewmodel.dart";

class SignUpVerifyOTPScreen extends StatefulWidget {
  const SignUpVerifyOTPScreen({super.key});

  @override
  State<SignUpVerifyOTPScreen> createState() => _SignUpVerifyOTPScreenState();
}

class _SignUpVerifyOTPScreenState extends State<SignUpVerifyOTPScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final signupviewmodel = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop(); // Go back to the previous screen
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03),
              Text("Verify Code", style: AppTextStyle.title),
              SizedBox(height: height * 0.03),
              Text("Please enter the code sent to your email address",
                  textAlign: TextAlign.center),
              SizedBox(height: height * 0.01),
              Text(context.read<SignUpViewModel>().email,
                  textAlign: TextAlign.center, style: AppTextStyle.link),
              SizedBox(height: height * 0.05),
              PinCodeTextField(
                appContext: context,
                length: 4,
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  debugPrint("Completed");
                },
              ),
              SizedBox(height: height * 0.02),
              Text("Didn't receive OTP?"),
              InkWell(
                onTap: () {
                  // Resend OTP
                },
                child: Text("Resend OTP",
                    // style: AppTextStyle.linkButton,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          Colors.blue, // Set the underline color to blue
                      decorationStyle: TextDecorationStyle
                          .solid, // Optional: Makes the underline solid
                    )),
              ),
              SizedBox(height: height * 0.02),
              PrimaryButton(
                  text: "Verify",
                  loading: signupviewmodel.loading,
                  onPressed: () {
                    signupviewmodel.apiVerifyOTP("data", context);
                    // if (_emailController.text.isEmpty) {
                    //   Utils.flushBarErrorMessage(
                    //       "Email must be provide", context);
                    //   return;
                    // }
                    // if (AppRegex.isValidEmail(_emailController.text) == false) {
                    //   Utils.flushBarErrorMessage(
                    //       "Email must be valid", context);
                    //   return;
                    // }
                    // if (authviewmodel.termsAccepted == false) {
                    //   Utils.flushBarErrorMessage(
                    //       "You must accept the terms and conditions", context);
                    //   return;
                    // }
                    //
                    // Navigator.pushNamed(context, RouteNames.verityOTPScreen);
                  },
                  context: context),
            ],
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
