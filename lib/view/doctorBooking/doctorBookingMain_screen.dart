import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/models/qualificationModel.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../res/widgets/buttons/backButton.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../res/widgets/doctorCard.dart';
import '../../viewModel/doctorBooking_viewmodel.dart';

class DoctorMainScreen extends StatefulWidget {
  final String id;
  const DoctorMainScreen({super.key, required this.id});

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorBookingViewModel>().getDoctorById(widget.id, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final doctorViewModel = context.watch<DoctorBookingViewModel>();
    final size = MediaQuery.of(context).size;
    final doctorBooking = doctorViewModel.doctorBooking;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Doctor Details",
          style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CustomBackButton(
            onPressed: () => context.pop(), // Navigate to 'Bookings' screen
          ),
        ),
        actions: [
          CustomBackButton(onPressed: () {}, icon: Icons.share),
          CustomBackButton(onPressed: () {}, icon: Icons.favorite_border),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: doctorViewModel.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  DoctorInfo(
                    height: size.height,
                    width: size.width,
                    address: doctorBooking?.doctor.address ?? "",
                    name: doctorBooking?.doctor.name ?? "",
                    specializations:
                        doctorBooking?.specialization.specializations ?? [],
                    url: doctorBooking?.doctor.avatar?.url ?? "",
                  ),
                  Divider(
                    height: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightPrimaryColor),
                              child: Icon(
                                Icons.people,
                                color: AppColors.primaryColor,
                              )),
                          SizedBox(height: 8),
                          // TODO : Change the value to the actual number of patients
                          Text("7,500+",
                              style: AppTextStyle.body
                                  .copyWith(color: AppColors.primaryColor)),
                          Text("Patients", style: AppTextStyle.caption),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightPrimaryColor),
                              child: Icon(
                                Icons.work_history,
                                color: AppColors.primaryColor,
                              )),
                          SizedBox(height: 8),
                          // TODO : Change the value to the actual number of years of experience
                          Text("10+",
                              style: AppTextStyle.body
                                  .copyWith(color: AppColors.primaryColor)),
                          Text("Years Exp.", style: AppTextStyle.caption),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightPrimaryColor),
                              child: Icon(
                                Icons.star,
                                color: AppColors.primaryColor,
                              )),
                          SizedBox(height: 8),
                          // TODO : Change the value to the actual rating
                          Text("4.9+",
                              style: AppTextStyle.body
                                  .copyWith(color: AppColors.primaryColor)),
                          Text("Rating", style: AppTextStyle.caption),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.lightPrimaryColor),
                              child: Icon(
                                Icons.chat,
                                color: AppColors.primaryColor,
                              )),
                          SizedBox(height: 8),
                          // TODO : Change the value to the actual number of reviews
                          Text("4,956",
                              style: AppTextStyle.body
                                  .copyWith(color: AppColors.primaryColor)),
                          Text("Review ", style: AppTextStyle.caption),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About",
                      style: AppTextStyle.subtitle,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: doctorBooking?.specialization.qualifications.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final qualification = doctorBooking?.specialization.qualifications[index];
                      return Row(
                        children: [
                          Icon(Icons.school_rounded, color: AppColors.primaryColor),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Text(
                                      '${qualification?.year.toString()}',
                                      style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' - ${qualification?.degree}',
                                      style: AppTextStyle.body.copyWith(fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${qualification?.institution}',
                                  style: AppTextStyle.body.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Working Hours",
                      style: AppTextStyle.subtitle,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Divider(
                    height: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: size.height * 0.01),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: doctorBooking?.workSchedule.availableTimes.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final workingHour = doctorBooking?.workSchedule.availableTimes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${workingHour?.dayOfWeek.capitalizeFirst}',
                                        style: AppTextStyle.body.copyWith(fontStyle: FontStyle.italic),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        '${workingHour?.startTime} - ${workingHour?.endTime}',
                                        style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: "Book Appointment",
          // loading: context.watch<UserViewModel>().isLoading,
          onPressed: () {
            // print("Book Appointment");
            context.push('/selectBookingTime');
          },
          context: context,
        ),
      ),
    );
  }
}
