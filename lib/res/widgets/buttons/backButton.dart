import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;

  const CustomBackButton({Key? key, required this.onPressed, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        'assets/buttons/icons8-back-arrow.svg',
        color: color,  // Use the color parameter here
        fit: BoxFit.contain,
      ),
    );
  }
}
