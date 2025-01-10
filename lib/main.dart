import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:doctor_appointment/viewModel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/utils/routes/routes.dart';
import 'package:doctor_appointment/viewModel/auth_viewmodel.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel(),lazy: true),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        // ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel(),lazy: true),
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
          child: MaterialApp.router(
            title: 'Book Appointment',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              textTheme: GoogleFonts.interTextTheme(),
            ),
            routerConfig: router, // Use the GoRouter instance
          ),
      ),
    );
  }
}
