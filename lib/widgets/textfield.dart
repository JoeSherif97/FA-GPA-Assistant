import 'package:flutter/material.dart';

class RTextField extends StatelessWidget {
  const RTextField({super.key, required this.controller, required this.label});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fieldWidth = size.width * 0.25; // 25% of screen width
    final double fieldHeight = size.height * 0.07; // 7% of screen height
    final double fontSize = size.width * 0.05; // Responsive font size

    return SizedBox(
      width: fieldWidth,
      height: fieldHeight,
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLength: 4,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: fontSize * 0.8),
          filled: true,
          fillColor: Color.fromARGB(255, 213, 222, 239),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
