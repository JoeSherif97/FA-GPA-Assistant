import 'package:flutter/material.dart';
import 'package:gpacalculator/widgets/material_screen.dart';

class GpaCalcAbt extends StatefulWidget {
  const GpaCalcAbt({super.key});
  @override
  State<GpaCalcAbt> createState() => GpaAbt();
}

class GpaAbt extends State<GpaCalcAbt> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;

    return screen(
      context,
      "About Us",
      null,
      fontSize * 1.2,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "The GPA Calculator app is a user-friendly, responsive tool designed for students at all levels. Whether you're calculating your current GPA, predicting future outcomes, or planning summer courses, our app provides accurate, real-time results. Key features include:\n\n\t-GPA Prediction: Estimate your future GPA based on current performance and planned courses.\n\n\t-Letter Grade Conversion: Convert numerical GPAs to letter grades with a customizable grading scale.\n\n\t-Responsive Design: Seamlessly works on any device, from smartphones (e.g., iPhone SE, Pixel 5) to tablets (e.g., iPad).\n\n\t-Intuitive Interface: Built with Flutter, our app ensures a smooth experience with clear inputs and instant feedback.\n\n\n\nMade By Youssef Sherif.",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing / 2),
        ],
      ),
    );
  }
}
