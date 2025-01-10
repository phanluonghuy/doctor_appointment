import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatedSecondScreen extends StatefulWidget {
  const StatedSecondScreen({super.key});

  @override
  State<StatedSecondScreen> createState() => _StatedSecondScreenState();
}

class _StatedSecondScreenState extends State<StatedSecondScreen> {
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
                      'assets/illustrations/iDoctor3.png'
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: height*0.1),
                    Text.rich(
                      TextSpan(
                        text: "Effortless ", // Default style
                        style: AppTextStyle.title,
                        children: [
                          TextSpan(
                            text: "Appointment ", // Green styled text
                            style: AppTextStyle.title.copyWith(color: AppColors.primaryColor),
                          ),
                          TextSpan(
                            text: "Booking", // Green styled text
                            style: AppTextStyle.title,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height*0.02),
                    Text(
                      "Book an appointment with your doctor in just a few clicks",
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
