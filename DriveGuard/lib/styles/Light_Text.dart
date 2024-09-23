import 'package:flutter/material.dart';

class Light_Text extends StatelessWidget {
  Light_Text({super.key, required this.text, required this.fontSize});

  String text;
  double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w500, color: Colors.grey),
    );
  }
}
