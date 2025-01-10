import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatedThirdScreen extends StatefulWidget {
  const StatedThirdScreen({super.key});

  @override
  State<StatedThirdScreen> createState() => _StatedThirdScreenState();
}

class _StatedThirdScreenState extends State<StatedThirdScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: height*0.1),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: height*0.4,
                  child: Image.asset(
                      'assets/illustrations/iDoctor4.png'
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: height*0.1),
                    Text.rich(
                      TextSpan(
                        text: "Learn About ", // Default style
                        style: AppTextStyle.title.copyWith(color: AppColors.primaryColor),
                        children: [
                          TextSpan(
                            text: "Your Doctor", // Green styled text
                            style: AppTextStyle.title.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height*0.02),
                    Text(
                      "Get to know your doctor before booking an appointment",
                      style: AppTextStyle.body.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
