import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/buttons/primaryButton.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../viewModel/splash_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Container(
              color: AppColors.greyColor,
              height: height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/illustrations/iDoctor_1.png'
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.4,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  SizedBox(height: height*0.05),
                  Text.rich(
                    TextSpan(
                      text: "Your ", // Default style
                      style: AppTextStyle.title,
                      children: [
                        TextSpan(
                          text: "Ultimate Doctor", // Green styled text
                          style: AppTextStyle.title.copyWith(color: AppColors.primaryColor),
                        ),
                        TextSpan(
                          text: " Appointment Booking App", // Default style
                          style: AppTextStyle.title,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height*0.02),
                  Text(
                    "Book your appointment effortlessly and manage your health journey",
                    style: AppTextStyle.body.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height*0.02),
                  PrimaryButton(text: "Let's Get Started", onPressed: (){
                  context.push('/started');
                  }, context: context),
                  SizedBox(height: height*0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?"),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, RouteNames.login);
                          context.push('/login');
                        },
                        child: Text("Sign in",style: AppTextStyle.linkButton),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
