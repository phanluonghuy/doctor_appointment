import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'coloors.dart';

class ProfileTab extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String title;
  final double size;

  const ProfileTab({
    required this.onPressed,
    required this.iconPath,
    required this.title,
    this.size = 30
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: SvgPicture.asset(iconPath,height: size,color: AppColors.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios,color: AppColors.primaryColor),
    );
  }
}
