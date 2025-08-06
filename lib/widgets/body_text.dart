import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  final String data;
  const BodyText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.05; // Responsive font size

    return Text(
      textAlign: TextAlign.left,
      data,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
    );
  }
}
