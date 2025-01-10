import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../res/texts/app_text.dart';
import '../res/widgets/buttons/backArrowButton.dart';
import '../res/widgets/buttons/backButton.dart';
import '../res/widgets/coloors.dart';
import '../viewModel/NavigationProvider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CustomBackButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false).setIndex(0); // This will navigate to the 'Bookings' screen
            },
          ),
        ),
        leadingWidth: width*0.2,

      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Stack(children: [
                    CircleAvatar(
                      radius: height * 0.08,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: height * 0.08,color: Colors.grey.shade800),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: height * 0.04, // Diameter of the CircleAvatar + border
                        height: height * 0.04,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // print(userViewModel.user);
                          },
                          child: CircleAvatar(
                            radius: height * 0.03,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.edit_rounded,
                              size: height * 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],)),
                  SizedBox(height: height * 0.03),
                  Text(userViewModel.user?.name ?? "User", style: AppTextStyle.title),
                ],
              ),
            )),
      ),
    );
  }
}
