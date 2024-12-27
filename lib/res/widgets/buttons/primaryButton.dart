import 'package:flutter/material.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart'; // Assuming AppColors is defined here

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final BuildContext context;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.context,
    this.loading = false
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
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
        ),
      ),
    );
  }
}
