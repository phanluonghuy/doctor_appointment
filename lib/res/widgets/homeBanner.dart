import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/models/appointmentModel.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeBanner1 extends StatelessWidget {
  final Appointment appointment;
  const HomeBanner1({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: appointment.doctorAvatarUrl != null && appointment.doctorAvatarUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(appointment.doctorAvatarUrl!)
                  : AssetImage('assets/illustrations/doctor-3d.png') as ImageProvider, // Fallback image
            ),

            title: Text('Dr ${appointment.doctorName}',
                style: TextStyle(color: Colors.white)),
            subtitle: Text(
                'Priority : ${toBeginningOfSentenceCase(appointment.priority)}',
                style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primarySwatch.shade900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month_outlined, color: Colors.white),
                Text(DateFormat('EEEE, dd MMM').format(appointment.appointmentDate), style: TextStyle(color: Colors.white)),
                SizedBox(
                    height: 20, child: VerticalDivider(color: Colors.white)),
                Icon(Icons.numbers, color: Colors.white),
                Text('Number : ${appointment.queueNumber.toString()}', style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
