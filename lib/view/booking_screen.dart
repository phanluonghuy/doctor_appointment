import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/buttons/primaryButton.dart';
import 'package:doctor_appointment/res/widgets/buttons/whitePrimaryButton.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:doctor_appointment/viewModel/myBooking_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/appointmentModel.dart';
import '../res/widgets/buttons/backButton.dart';
import '../res/widgets/mybooking.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Map<String, dynamic> currentFilter = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyBookingViewModel>().getAllBooking(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myBookingViewModel = context.watch<MyBookingViewModel>();

    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Booking"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "Confirmed"),
              Tab(text: "Pending"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                var filter = await context.push('/filter', extra: currentFilter);
                if (filter != null) {
                  setState(() {
                    currentFilter = filter as Map<String, dynamic>;
                    myBookingViewModel.setFilters(currentFilter);
                  });
                }
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            upComing(myBookingViewModel),
            pending(myBookingViewModel),
            complete(myBookingViewModel),
            cancel(myBookingViewModel),
          ],
        ),
      ),
    );
  }
}

Widget upComing(MyBookingViewModel myBookingViewModel) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: myBookingViewModel.confirmedAppointments.length,
            itemBuilder: (BuildContext context, int index) {
              final appointment =
                  myBookingViewModel.confirmedAppointments[index];
              return MyBookingConfirmCard(
                appointment: appointment,
              );
            }),
        SizedBox(height: 80),
      ],
    ),
  );
}

Widget pending(MyBookingViewModel myBookingViewModel) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: myBookingViewModel.pendingAppointments.length,
            itemBuilder: (BuildContext context, int index) {
              final appointment =
              myBookingViewModel.pendingAppointments[index];
              return MyBookingPendingCard(
                appointment: appointment,
              );
            }),
        SizedBox(height: 80),
      ],
    ),
  );
}

Widget complete(MyBookingViewModel myBookingViewModel) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: myBookingViewModel.completedAppointments.length,
            itemBuilder: (BuildContext context, int index) {
              final appointment =
              myBookingViewModel.completedAppointments[index];
              return MyBookingCompleteCard(
                appointment: appointment,
              );
            }),
        SizedBox(height: 80),
      ],
    ),
  );
}

Widget cancel(MyBookingViewModel myBookingViewModel) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: myBookingViewModel.cancelledAppointments.length,
            itemBuilder: (BuildContext context, int index) {
              final appointment =
              myBookingViewModel.cancelledAppointments[index];
              return MyBookingCancelCard(
                appointment: appointment,
              );
            }),
        SizedBox(height: 80),
      ],
    ),
  );
}