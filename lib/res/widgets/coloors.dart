import 'package:flutter/material.dart';

class AppColors {
  static final buttonColor = Colors.greenAccent.shade700;
  static const primaryColor = Color(0xFF0165FC);
  static const Color greyColor = Color(0xFFEAECF0);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF0165FC,
    <int, Color>{
      50: Color(0xFFE3F2FD),  // Lightest shade
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),  // Default shade (base color)
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),  // Darkest shade
    },
  );
}
