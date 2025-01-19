import 'package:flutter/material.dart';

class OutlinePrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final TextStyle? textStyle;

  const OutlinePrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.borderRadius = 20.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: color,
                  fontSize: 20,
                ),
          ),
        ),
      ),
    );
  }
}
