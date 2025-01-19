import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;

  const CustomBackButton({Key? key, required this.onPressed, this.color = Colors.black, this.icon = Icons.arrow_back})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        shape: BoxShape.circle,
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon), padding: EdgeInsets.zero),
    );
  }
}
