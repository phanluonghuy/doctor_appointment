import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:doctor_appointment/view/booking_screen.dart';
import 'package:doctor_appointment/view/chat_screen.dart';
import 'package:doctor_appointment/view/explore_screen.dart';
import 'package:doctor_appointment/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart'; // Import persistent_bottom_nav_bar package
import '../../view/home_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: PersistentTabView(
        context,
        margin: const EdgeInsets.all(10.0),
        controller: controller
            .tabController, // Using PersistentTabController to manage tab state
        screens: controller.screens,
        items: [
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icons8-home.svg',
              color: AppColors.primaryColor,
            ),
            title: 'Home',
            activeColorPrimary: AppColors.primaryColor,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset('assets/icons/icons8-location.svg',
                color: AppColors.primaryColor),
            title: 'Explore',
            activeColorPrimary: AppColors.primaryColor,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset('assets/icons/icons8-calendar.svg',
                color: AppColors.primaryColor),
            title: 'Bookings',
            activeColorPrimary: AppColors.primaryColor,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset('assets/icons/icons8-chat.svg',
                color: AppColors.primaryColor),
            title: 'Chat',
            activeColorPrimary: AppColors.primaryColor,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset('assets/icons/icons8-user.svg',
                color: AppColors.primaryColor),
            title: 'Profile',
            activeColorPrimary: AppColors.primaryColor,
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        // confineInSafeArea: true,
        backgroundColor: Colors.white70,
        navBarHeight: 80,
        decoration: NavBarDecoration(
          // border: Border.all(color: Colors.grey.shade200, width: 1),
          // colorBehindNavBar: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  final screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const BookingScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
}
