import 'package:doctor_appointment/models/qualificationModel.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
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
  State<PaymentBookingScreen> createState() => _PaymentBookingScreenState();
}

class _PaymentBookingScreenState extends State<PaymentBookingScreen> {
  Future<void> _paypalPayment(
      BuildContext context, DoctorBookingViewModel doctorViewModel) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId:
            "AcNiZPbu8Y1nqIwg4VPYx6N4IFRGwsjZUP9cIFJNHcssQEyPp3Ng6yr7GlXzrWXfLlDjShZeb_evLnyx",
        secretKey:
            "ECyE-OhKEFEC4sbbae5DeHSroQoHnLwh-sqU9I7e8PpJ9zV-rtlBn7BI_uygJoBqRqUwX8lpyTvlFYBb",
        transactions: [
          {
            "amount": {
              "total": "10",
              "currency": "USD",
              "details": {
                "subtotal": "10",
                "shipping": "0",
                "shipping_discount": "0"
              }
            },
            "description": "The payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name":
                      "Booking Dr. ${doctorViewModel.doctorBooking?.doctor.name ?? ''}",
                  "quantity": 1,
                  "price": "10",
                  "currency": "USD"
                }
              ]
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
          // context.pop();
          doctorViewModel.createPayment(context);
        },
        onError: (error) {
          print("onError: $error");
          Utils.flushBarErrorMessage("Error", context);
          // context.pop();
        },
        onCancel: () {
          print('cancelled:');
          Utils.flushBarErrorMessage("Payment Cancelled", context);
          // context.pop();
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final doctorViewModel = context.watch<DoctorBookingViewModel>();
    final size = MediaQuery.of(context).size;

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
                            if (!method['isEnable']) {
                              return;
                            }
                            doctorViewModel.setSelectedMethod(value);
                          },
                          subtitle: method['isEnable']
                              ? null
                              : Text(
                                  "Not Available",
                                  style: AppTextStyle.caption
                                      .copyWith(color: Colors.red),
                                ),
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
            if (doctorViewModel.getSelectedMethod == "Paypal") {
              _paypalPayment(context, doctorViewModel);
              return;
            }
            doctorViewModel.createPayment(context);
          },
          context: context,
        ),
      ),
    );
  }
}
