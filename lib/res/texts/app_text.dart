import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static final TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static  final TextStyle body = TextStyle(
    fontSize: 16,
  );

  static final TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );

  static final TextStyle linkButton = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
    decorationColor: Colors.blue, // Set the underline color to blue
    decorationStyle: TextDecorationStyle.solid, // Optional: Makes the underline solid
  );

}