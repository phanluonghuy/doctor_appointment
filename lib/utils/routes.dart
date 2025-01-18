import 'package:doctor_appointment/view/booking_screen.dart';
import 'package:doctor_appointment/view/chat_screen.dart';
import 'package:doctor_appointment/view/doctorBooking/selectBookingTime_screen.dart';
import 'package:doctor_appointment/view/explore_screen.dart';
import 'package:doctor_appointment/view/forgotPassword/forgotPassword_screen.dart';
import 'package:doctor_appointment/view/profile_screen.dart';
import 'package:doctor_appointment/view/signUp/signup_verityOTP_screen.dart';
import 'package:doctor_appointment/view/started/started_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/view/home_screen.dart';
import 'package:doctor_appointment/view/login_screen.dart';
import 'package:doctor_appointment/view/signUp/signup_screen.dart';
import 'package:doctor_appointment/view/splash_screen.dart';
import 'package:go_router/go_router.dart';
import '../res/navigations/navigationMenu.dart';
import '../view/changePassword_screen.dart';
import '../view/doctorBooking/doctorBookingMain_screen.dart';
import '../view/doctorBooking/paymentBooking_screen.dart';
import '../view/doctorBooking/successBooking_screen.dart';
import '../view/editProfile_screen.dart';
import '../view/settings_screen.dart';
import '../view/signUp/signup_createPassword.dart';
import '../view/welcome_screen.dart';
import '../viewModel/user_viewmodel.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const SignUpVerifyOTPScreen(),
    ),
    GoRoute(
        path: '/createPassword',
        builder: (context, state) => const SignUpCreatePasswordScreen()),
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/navigationMenu',
      builder: (context, state) => const NavigationMenu(),
    ),
    GoRoute(
        path: '/welcome', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
        path: '/started', builder: (context, state) => const StartedScreen()),
    GoRoute(
        path: '/explore', builder: (context, state) => const ExploreScreen()),
    GoRoute(
        path: '/booking', builder: (context, state) => const BookingScreen()),
    GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
    GoRoute(
        path: '/profile', builder: (context, state) => const ProfileScreen()),
    GoRoute(
        path: '/editProfile',
        builder: (context, state) => const EditProfileScreen()),
    GoRoute(
        path: '/settings', builder: (context, state) => const SettingScreen()),
    GoRoute(
        path: '/changePassword',
        builder: (context, state) => const ChangePasswordScreen()),
    GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen()),
    GoRoute(
        path: '/doctorMain/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? "";
          return DoctorMainScreen(id: id);
        }),
    GoRoute(
        path: '/selectBookingTime',
        builder: (context, state) => const SelectBookingTimeScreen()),
    GoRoute(
        path: '/paymentBooking',
        builder: (context, state) => const PaymentBookingScreen()),
    GoRoute(
        path: '/successBooking',
        builder: (context, state) => const SuccessBookingScreen()),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text("No route is configured"),
    ),
  ),
);
