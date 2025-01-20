import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeBanner1 extends StatelessWidget {
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
              backgroundImage: AssetImage('assets/illustrations/doctor-3d.png'),
            ),
            title: Text('Dr John Doe', style: TextStyle(color: Colors.white)),
            subtitle: Text('Dentist Consultant', style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {

              },
            ),
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
                Text('Monday, 26 July', style: TextStyle(color: Colors.white)),
                Container(height: 20, child: VerticalDivider(color: Colors.white)),
                Icon(Icons.watch_later_outlined, color: Colors.white),
                Text('10:00 - 12:00', style: TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}