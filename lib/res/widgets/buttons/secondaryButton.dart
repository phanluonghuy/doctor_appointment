import 'package:flutter/material.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart'; // Assuming AppColors is defined here

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final FocusNode? focusNode;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
