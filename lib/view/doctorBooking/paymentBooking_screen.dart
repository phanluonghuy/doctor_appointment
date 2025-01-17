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
import '../../res/widgets/doctorCard.dart';
import '../../utils/List_Helper.dart';
import '../../utils/utils.dart';
import '../../viewModel/doctorBooking_viewmodel.dart';

class PaymentBookingScreen extends StatefulWidget {
  const PaymentBookingScreen({super.key});

  @override
  State<PaymentBookingScreen> createState() =>
      _PaymentBookingScreenState();
}

class _PaymentBookingScreenState extends State<PaymentBookingScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorViewModel = context.watch<DoctorBookingViewModel>();
    final size = MediaQuery.of(context).size;
    final List<Map<String, String>> paymentMethods = [
      {"name": "Visa", "icon": "assets/payments/icons8-visa.svg"},
      {"name": "Stripe", "icon": "assets/payments/icons8-stripe.svg"},
      {"name": "Cash", "icon": "assets/payments/icons8-cash.svg"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Method",
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
        child: doctorViewModel.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Method",
                style: AppTextStyle.title,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            ListView(
              shrinkWrap: true,
              children: paymentMethods.map((method) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: RadioListTile<String>(
                    title: Text(method['name']!,
                        style: AppTextStyle.subtitle),
                    value: method['name']!,
                    groupValue: doctorViewModel.getSelectedMethod,
                    onChanged: (value) {
                      doctorViewModel.setSelectedMethod(value);
                    },
                    secondary: SvgPicture.asset(
                      method['icon']!,
                      width: 40,
                      height: 40,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: "Pay",
          loading: doctorViewModel.isQueue,
          onPressed: () {
            if (doctorViewModel.getSelectedMethod == null) {
              Utils.flushBarErrorMessage(
                  "Please select a payment method", context);
              return;
            }
            Map<String,dynamic> data = {
             "doctorId" : doctorViewModel.doctorBooking?.doctor.id ?? "",
              "appointmentDate" : doctorViewModel.getSelectedDate.toIso8601String(),
              "symptoms" : doctorViewModel.getSymptoms,
            };
            doctorViewModel.createAppointment(data, context);

          },
          context: context,
        ),
      ),
    );
  }
}
