import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatedFirstScreen extends StatefulWidget {
  const StatedFirstScreen({super.key});

  @override
  State<StatedFirstScreen> createState() => _StatedFirstScreenState();
}

class _StatedFirstScreenState extends State<StatedFirstScreen> {
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
                      'assets/illustrations/IDoctor2.png'
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: height*0.1),
                    Text.rich(
                      TextSpan(
                        text: "Discovery ", // Default style
                        style: AppTextStyle.title,
                        children: [
                          TextSpan(
                            text: "Experienced Doctors", // Green styled text
                            style: AppTextStyle.title.copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height*0.02),
                    Text(
                      "Find the best doctors in your area and book an appointment",
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
