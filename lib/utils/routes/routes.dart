import 'package:doctor_appointment/view/signup_verityOTP_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/utils/routes/routes_names.dart';
import 'package:doctor_appointment/view/home_screen.dart';
import 'package:doctor_appointment/view/login_screen.dart';
import 'package:doctor_appointment/view/signup_screen.dart';
import 'package:doctor_appointment/view/splash_screen.dart';

// class Routes {
//   static Route<dynamic> generateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case (RouteNames.home):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const HomeScreen());
//       case (RouteNames.login):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const LoginScreen());
//       case (RouteNames.signupScreen):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SignUpScreen());
//       case (RouteNames.splashScreen):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SplashScreen());
//       case (RouteNames.verityOTPScreen):
//         return MaterialPageRoute(
//             builder: (BuildContext context) => const SignUpVerifyOTPScreen());
//
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(
//               child: Text("No route is configured"),
//             ),
//           ),
//         );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_appointment/view/home_screen.dart';
import 'package:doctor_appointment/view/login_screen.dart';
import 'package:doctor_appointment/view/signup_screen.dart';
import 'package:doctor_appointment/view/signup_verityOTP_screen.dart';
import 'package:doctor_appointment/view/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      // name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      // name: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      // name: RouteNames.signup,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/otp',
      // name: RouteNames.otpVerification,
      builder: (context, state) => const SignUpVerifyOTPScreen(),
    ),
    GoRoute(
      path: '/home',
      // name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text("No route is configured"),
    ),
  ),
);

