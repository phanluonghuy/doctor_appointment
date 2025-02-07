import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/res/widgets/buttons/primaryButton.dart';
import 'package:doctor_appointment/res/widgets/profile_tab.dart';
import 'package:doctor_appointment/utils/noti_service.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../res/texts/app_text.dart';
import '../res/widgets/buttons/backArrowButton.dart';
import '../res/widgets/buttons/backButton.dart';
import '../res/widgets/buttons/whitePrimaryButton.dart';
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
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: CircleAvatar(
                radius: height * 0.08,
                backgroundColor: Colors.grey.shade300,
                child: CachedNetworkImage(
                  imageUrl: userViewModel.user?.avatar?.url ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.person,
                      size: height * 0.08, color: Colors.grey.shade800),
                ),
              )),
              SizedBox(height: height * 0.02),
              Text(userViewModel.user?.name ?? "User",
                  style: AppTextStyle.subtitle),
              SizedBox(height: height * 0.02),
              ProfileTab(
                onPressed: () {
                  context.push('/editProfile');
                },
                iconPath: 'assets/buttons/icons8-person.svg',
                title: "Your Profile",
              ),
              Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              ProfileTab(
                onPressed: () {
                  context.read<NavigationProvider>().setIndex(0);
                },
                iconPath: 'assets/buttons/icons8-card.svg',
                title: "Payment Methods",
              ),
              Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              ProfileTab(
                onPressed: () {
                  // print("Show Notification");
                  // NotificationService().showNotification(
                  //     id: 0, title: "Daily Notification", body: "Hello");
                  // NotificationService().scheduleNotification(
                  //     id: 0,
                  //     title: "Scheduled Notification",
                  //     body: DateTime.now().toString(),
                  //     hour: 16,
                  //     minute: 44);
                   NotificationService().cancelAllNotification();
                },
                iconPath: 'assets/buttons/icons8-love.svg',
                title: "Favourites",
              ),
              Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              ProfileTab(
                onPressed: () {
                  context.push('/settings');
                },
                iconPath: 'assets/buttons/icons8-setting.svg',
                title: "Settings",
              ),
              Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              ProfileTab(
                onPressed: () {},
                iconPath: 'assets/buttons/icons8-help.svg',
                title: "Help & Support",
              ),
              Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              ProfileTab(
                onPressed: () {},
                iconPath: 'assets/buttons/icons8-lock.svg',
                title: "Privacy Policy",
              ),
              Divider(
                height: 5,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              ProfileTab(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          // height: 200,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 100),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Logout', style: AppTextStyle.subtitle),
                              SizedBox(height: 10),
                              Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              Text("Are you sure you want to logout?",
                                  style: AppTextStyle.body),
                              SizedBox(height: 20),
                              OutlinePrimaryButton(
                                  text: "Cancel",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              SizedBox(height: 10),
                              PrimaryButton(
                                  text: "Yes, Logout",
                                  onPressed: () {
                                    userViewModel.removeUser().then((value) {
                                      context.go('/login');
                                    }).onError((error, stackTrace) {
                                      print(error.toString());
                                      context.go('/login');
                                    });
                                  },
                                  context: context)
                            ],
                          ),
                        );
                      });
                },
                iconPath: 'assets/buttons/icons8-log-out.svg',
                title: "Logout",
              ),
            ],
          ),
        )),
      ),
    );
  }
}
