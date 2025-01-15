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
import '../../utils/List_Helper.dart';
import '../../viewModel/doctorBooking_viewmodel.dart';

class SelectBookingTimeScreen extends StatefulWidget {
  const SelectBookingTimeScreen({super.key});

  @override
  State<SelectBookingTimeScreen> createState() =>
      _SelectBookingTimeScreenState();
}

class _SelectBookingTimeScreenState extends State<SelectBookingTimeScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorViewModel = context.watch<DoctorBookingViewModel>();
    final size = MediaQuery.of(context).size;
    final doctorBooking = doctorViewModel.doctorBooking;
    final hours = generateHourlyList(
        doctorBooking?.workSchedule.availableTimes.first.startTime ?? "",
        doctorBooking?.workSchedule.availableTimes.first.endTime ?? "");
    final days = generateNextSevenDaysMap();

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
                      "Book Appointment",
                      style: AppTextStyle.body,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Day",
                      style: AppTextStyle.subtitle,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.07,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: days.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(days.keys.elementAt(index),
                                      style: AppTextStyle.caption.copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12)),
                                  Text(days.values.elementAt(index),
                                      style: AppTextStyle.body
                                          .copyWith(fontSize: 14)),
                                ],
                              )));
                        }),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Time ",
                      style: AppTextStyle.subtitle,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.07,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: hours.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Center(
                                  child: Text(hours[index],
                                      style: AppTextStyle.body
                                          .copyWith(fontSize: 22))));
                        }),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Want to custom schedule?"),
                        TextButton(
                            onPressed: () {
                              // Get.toNamed("/customSchedule");
                            },
                            child: Text("Request here",
                                style: AppTextStyle.linkButton)),
                      ],
                    ),
                  )
                ],
              ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: "Make Appointment",
          // loading: context.watch<UserViewModel>().isLoading,
          onPressed: () {},
          context: context,
        ),
      ),
    );
  }
}
