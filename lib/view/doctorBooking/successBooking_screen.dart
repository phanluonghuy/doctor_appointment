import 'package:doctor_appointment/models/qualificationModel.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../res/widgets/buttons/backButton.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../res/widgets/buttons/secondaryButton.dart';
import '../../res/widgets/buttons/whitePrimaryButton.dart';
import '../../res/widgets/doctorCard.dart';
import '../../utils/List_Helper.dart';
import '../../utils/utils.dart';
import '../../viewModel/doctorBooking_viewmodel.dart';

class SuccessBookingScreen extends StatefulWidget {
  const SuccessBookingScreen({super.key});

  @override
  State<SuccessBookingScreen> createState() => _SuccessBookingScreenState();
}

class _SuccessBookingScreenState extends State<SuccessBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorViewModel = context.watch<DoctorBookingViewModel>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded,
                  color: AppColors.primaryColor, size: size.width * 0.5),
              Text(
                "Payment Successful",
                style: AppTextStyle.title,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "Your have successfully booked an appointment with ",
                style: AppTextStyle.body,
                textAlign: TextAlign.center,
              ),
              Text('Dr. ${doctorViewModel.doctorBooking!.doctor.name}',
                  style: AppTextStyle.subtitle),
              SizedBox(height: size.height * 0.02),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month_rounded,
                      color: AppColors.primaryColor),
                  Text(
                    DateFormat('   dd MMM yyyy')
                        .format(doctorViewModel.getSelectedDate),
                    style: AppTextStyle.subtitle,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Text('Your booking number is', style: AppTextStyle.subtitle),
              Text(doctorViewModel.getBookingNumber.toString(),
                  style: AppTextStyle.title
                      .copyWith(color: AppColors.primaryColor, fontSize: 50)),
              // TODO : Add time
              // Row(
              //   children: [
              //     Icon(Icons.watch_later_outlined, color: AppColors.primaryColor),
              //     Text(
              //       DateFormat('   hh:mm a').format(doctorViewModel.getSelectedDate),
              //       style: AppTextStyle.subtitle,
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            PrimaryButton(
              text: "View Appointments",
              loading: doctorViewModel.loading,
              onPressed: () {},
              context: context,
            ),
            SizedBox(height: 10),
            OutlinePrimaryButton(
                text: "Go to Home",
                onPressed: () {
                  context.go('/navigationMenu');
                }),
          ],
        ),
      ),
    );
  }
}
