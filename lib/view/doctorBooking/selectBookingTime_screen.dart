import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/models/qualificationModel.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../res/widgets/buttons/backButton.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../res/widgets/doctorCard.dart';
import '../../utils/List_Helper.dart';
import '../../utils/utils.dart';
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
    final ScrollController scrollController = ScrollController();
    List<Map<String, dynamic>> next7Days = getNext7DaysAvailability(
        doctorBooking?.workSchedule.availableTimes ?? []);

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
        controller: scrollController,
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
                      "Select a Day",
                      style: AppTextStyle.subtitle,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.15,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: next7Days.length,
                      itemBuilder: (BuildContext context, int index) {
                        final day = next7Days[index];
                        final isSelected =
                            doctorViewModel.getSelectedTimeIndex == index;
                        final textColor =
                            isSelected ? Colors.white : Colors.black;
                        final backgroundColor =
                            isSelected ? AppColors.primaryColor : Colors.white;
                        return GestureDetector(
                          onTap: () {
                            doctorViewModel.setSelectedTimeIndex(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: backgroundColor,
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    toBeginningOfSentenceCase(
                                        day["dayOfWeek"])!,
                                    style: AppTextStyle.subtitle
                                        .copyWith(color: textColor),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          color: textColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        day["date"],
                                        style: AppTextStyle.caption.copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined,
                                          color: textColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${day["startTime"]} - ${day["endTime"]}',
                                        style: AppTextStyle.caption.copyWith(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Write your symptoms",
                      style: AppTextStyle.subtitle,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    // expands: true,
                    onChanged: (value) {
                      doctorViewModel.symptoms = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Write your symptoms here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: size.height * 0.04),
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
                  ),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Total: ",
                style: AppTextStyle.subtitle,
              ),
              Spacer(),
              Text(
                "\$10",
                style: AppTextStyle.subtitle.copyWith(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          PrimaryButton(
            text: "Make Appointment",
            loading: doctorViewModel.isQueue,
            onPressed: () {
              if (doctorViewModel.getSelectedTimeIndex == -1) {
                Utils.flushBarErrorMessage(
                    "Please select a time to book an appointment", context);
                return;
              }
              if (doctorViewModel.getSymptoms?.isEmpty ?? false) {
                Utils.flushBarErrorMessage(
                    "Please write your symptoms to book an appointment", context);
                return;
              }

              doctorViewModel.selectedDate = DateTime.parse(
                  next7Days[doctorViewModel.getSelectedTimeIndex]["date"]);
              Map<String, dynamic> data = {
                "doctorId": doctorViewModel.doctorBooking?.doctor.id ?? "",
                "appointmentDate":
                    doctorViewModel.getSelectedDate.toIso8601String(),
                "symptoms": doctorViewModel.getSymptoms,
                "notes": "N/A",
              };
              doctorViewModel.createAppointment(data, context);
            },
            context: context,
          )
        ]),
      ),
    );
  }
}
