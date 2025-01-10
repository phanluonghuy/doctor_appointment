import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../coloors.dart';

class BackArrowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;
  final bool isArrow;

  const BackArrowButton(
      {super.key, required this.onPressed, this.isArrow = true, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: MaterialButton(
        onPressed: onPressed,
        child: isArrow
            ? RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset('assets/buttons/icons8-arrow.svg',
                    color: AppColors.primaryColor))
            : SvgPicture.asset('assets/buttons/icons8-back-arrow.svg',
                color: AppColors.primaryColor),
      ),
    );
  }
}
