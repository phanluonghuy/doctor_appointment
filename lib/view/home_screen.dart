import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/models/appointmentModel.dart';
import 'package:doctor_appointment/models/doctorModel.dart';
import 'package:doctor_appointment/repository/doctor_repository.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/homeBanner.dart';
import 'package:doctor_appointment/utils/List_Helper.dart';
import 'package:doctor_appointment/viewModel/auth_viewmodel.dart';
import 'package:doctor_appointment/viewModel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../res/widgets/coloors.dart';
import '../viewModel/NavigationProvider.dart';
import '../viewModel/doctor_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final DoctorRepository _doctorRepository = DoctorRepository();
  @override
  void initState() {
    super.initState();
  }

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
                    onTap: () {
                      Provider.of<NavigationProvider>(context, listen: false)
                          .setIndex(1);
                      context.go('/navigationMenu');
                    },
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
                  onPressed: () {
                    final doctorViewModel = context.read<DoctorViewModel>();
                    doctorViewModel.toggleCategory("All");
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setIndex(2);
                    context.go('/navigationMenu');
                  },
                  child: Text('View all', style: AppTextStyle.link),
                ),
              ],
            ),
            FutureBuilder<Appointment>(
              future: _doctorRepository.getNearestAppointment(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "No appointments found.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "No appointments found.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  final appointment = snapshot.data!;
                  return HomeBanner1(appointment: appointment);
                }
              },
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Text(
                  'Specialists',
                  style: AppTextStyle.subtitle,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setIndex(1);
                    context.go('/navigationMenu');
                  },
                  child: Text('View all', style: AppTextStyle.link),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.15,
              child: ListView.builder(
                  itemCount: CategoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final doctorViewModel = context.read<DoctorViewModel>();
                        doctorViewModel.toggleCategory("All");
                        doctorViewModel.toggleCategory(CategoryList.keys.elementAt(index));
                        Provider.of<NavigationProvider>(context, listen: false)
                            .setIndex(1);
                        context.go('/navigationMenu');
                      },
                      child: Container(
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
                              Text(
                                CategoryList.keys.elementAt(index),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
                    );
                  }),
            ),
            Row(
              children: [
                Text(
                  'Top Doctors',
                  style: AppTextStyle.subtitle,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    final doctorViewModel = context.read<DoctorViewModel>();
                    doctorViewModel.toggleCategory("All");
                    Provider.of<NavigationProvider>(context, listen: false)
                        .setIndex(1);
                  },
                  child: Text('View all', style: AppTextStyle.link),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
              child: FutureBuilder<List<Doctor>>(
                future: _doctorRepository.getTopDoctor(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No doctors found.",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  } else {
                    final List<Doctor> doctors = snapshot.data!;
                    return ListView.builder(
                      itemCount: doctors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final doctor = doctors[index];
                        return Center(
                          child: Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: ListTile(
                              leading: SizedBox(
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: doctor.avatar.url,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.person,
                                      color: Colors.grey.shade800),
                                ),
                              ),
                              title: Text('Dr. ${doctor.name.split(' ').last}'),
                              subtitle: Text(
                                "Rating: ${doctor.averageRating.toStringAsFixed(1) ?? 'N/A'} ⭐ \nReviews: ${doctor.totalReviews ?? 0} 📃",
                              ),
                              onTap: () {
                                // Navigate to doctor details or perform an action
                                context.push('/doctorMain/${doctor.id}');
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
