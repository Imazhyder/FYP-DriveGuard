import 'package:flutter/material.dart';

class CardText extends StatelessWidget {
  CardText({super.key, required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }
}
