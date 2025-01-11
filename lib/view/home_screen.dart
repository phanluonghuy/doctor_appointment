import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/homeBanner.dart';
import 'package:doctor_appointment/utils/categoryList.dart';
import 'package:doctor_appointment/viewModel/auth_viewmodel.dart';
import 'package:doctor_appointment/viewModel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../res/widgets/coloors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, ${userViewModel.user?.name ?? ""}"),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(child: const Icon(Icons.notifications_sharp)),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: searchController,
                    hintText: 'Search for doctors',
                    leading:
                        const Icon(Icons.search, color: AppColors.primaryColor),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border:
                          Border.all(color: AppColors.primaryColor, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/buttons/icons8-adjust.svg',
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02)
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Text(
                  'Upcoming Schedule',
                  style: AppTextStyle.subtitle,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('View all', style: AppTextStyle.link),
                ),
              ],
            ),
            HomeBanner1(),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Text(
                  'Specialists',
                  style: AppTextStyle.subtitle,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('View all', style: AppTextStyle.link),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.2,
              child: ListView.builder(
                  itemCount: CategoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: AppColors.primarySwatch,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: SvgPicture.asset(
                                  CategoryList.values.elementAt(index),
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              child: Text(
                                CategoryList.keys.elementAt(index),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
