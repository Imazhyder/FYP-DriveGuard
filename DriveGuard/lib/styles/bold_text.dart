import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  BoldText({super.key, required this.text, required this.fontSize});

  String text;
  double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          overflow: TextOverflow.ellipsis),
    );
  }
}
