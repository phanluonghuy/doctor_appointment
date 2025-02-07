import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/appointmentModel.dart';
import '../../viewModel/bookingViewDetails_viewmodel.dart';
import '../../viewModel/myBooking_viewmodel.dart';
import '../texts/app_text.dart';
import 'buttons/primaryButton.dart';
import 'buttons/whitePrimaryButton.dart';
import 'coloors.dart';

class MyBookingConfirmCard extends StatelessWidget {
  final Appointment appointment;

  const MyBookingConfirmCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            DateFormat.yMMMMd().format(appointment.appointmentDate),
            style: AppTextStyle.subtitle,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: appointment.doctorAvatarUrl ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: 16, color: Colors.grey.shade800),
              ),
            ),
            title: Text(
              'Dr ${appointment.doctorName}',
              style: AppTextStyle.subtitle.copyWith(fontSize: 15),
            ),
            subtitle: Text(
              'Booking ID : ${appointment.id}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Text(
            "Your query number : ${appointment.queueNumber}",
            style: AppTextStyle.body,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: OutlinePrimaryButton(
                      text: "Cancel",
                      textStyle: TextStyle(
                          fontSize: 16.0, color: AppColors.primaryColor),
                      onPressed: () {})),
              SizedBox(width: 8),
              Expanded(
                  child: PrimaryButton(
                      text: "Reschedule",
                      onPressed: () {},
                      fontSize: 16.0,
                      context: context))
            ],
          )
        ],
      ),
    );
  }
}

class MyBookingPendingCard extends StatelessWidget {
  final Appointment appointment;

  const MyBookingPendingCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            DateFormat.yMMMMd().format(appointment.appointmentDate),
            style: AppTextStyle.subtitle,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: appointment.doctorAvatarUrl ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: 16, color: Colors.grey.shade800),
              ),
            ),
            title: Text(
              'Dr ${appointment.doctorName}',
              style: AppTextStyle.subtitle.copyWith(fontSize: 15),
            ),
            subtitle: Text(
              'Booking ID : ${appointment.id}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Text(
            "Your query number : ${appointment.queueNumber}",
            style: AppTextStyle.body,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: OutlinePrimaryButton(
                      text: "Cancel",
                      textStyle: TextStyle(
                          fontSize: 16.0, color: AppColors.primaryColor),
                      onPressed: () {})),
              SizedBox(width: 8),
              Expanded(
                  child: PrimaryButton(
                      text: "Pay",
                      onPressed: () {},
                      fontSize: 16.0,
                      context: context))
            ],
          )
        ],
      ),
    );
  }
}

class MyBookingCompleteCard extends StatelessWidget {
  final Appointment appointment;

  const MyBookingCompleteCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            DateFormat.yMMMMd().format(appointment.appointmentDate),
            style: AppTextStyle.subtitle,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: appointment.doctorAvatarUrl ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: 16, color: Colors.grey.shade800),
              ),
            ),
            title: Text(
              'Dr ${appointment.doctorName}',
              style: AppTextStyle.subtitle.copyWith(fontSize: 15),
            ),
            subtitle: Text(
              'Booking ID : ${appointment.id}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          Text(
            "Your query number : ${appointment.queueNumber}",
            style: AppTextStyle.body,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: OutlinePrimaryButton(
                      text: "View Details",
                      textStyle: TextStyle(
                          fontSize: 16.0, color: AppColors.primaryColor),
                      onPressed: () {
                        context
                            .read<BookingViewDetailsViewModel>()
                            .appointment = appointment;
                        context.push('/booking/completeBookingDetails');
                      })),
              SizedBox(width: 8),
              Expanded(
                  child: PrimaryButton(
                      text: "Add Review",
                      onPressed: () {
                        context.push('/add-review/${appointment.doctorId}');
                      },
                      fontSize: 16.0,
                      context: context))
            ],
          )
        ],
      ),
    );
  }
}

class MyBookingCancelCard extends StatelessWidget {
  final Appointment appointment;

  const MyBookingCancelCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            DateFormat.yMMMMd().format(appointment.appointmentDate),
            style: AppTextStyle.subtitle,
          ),
          Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            leading: SizedBox(
              width: 50,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: appointment.doctorAvatarUrl ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: 16, color: Colors.grey.shade800),
              ),
            ),
            title: Text(
              'Dr ${appointment.doctorName}',
              style: AppTextStyle.subtitle.copyWith(fontSize: 15),
            ),
            subtitle: Text(
              'Booking ID : ${appointment.id}',
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}