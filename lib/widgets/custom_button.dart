import 'package:flutter/material.dart';

class OperationButton extends StatelessWidget {
  final String data;
  final Alignment align;
  final dynamic func;

  const OperationButton({
    super.key,
    required this.data,
    required this.align,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double buttonWidth = size.width * 0.6; // 60% of screen width
    final double buttonHeight = size.height * 0.1; // 10% of screen height
    final double fontSize = size.width * 0.05; // Responsive font size

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.04,
      ),
      alignment: align,
      child: FilledButton(
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll<Size>(
            Size(buttonWidth, buttonHeight),
          ),
          backgroundColor: WidgetStatePropertyAll<Color>(
            Color.fromARGB(255, 213, 222, 239),
          ),
          overlayColor: WidgetStatePropertyAll<Color>(
            Color.fromARGB(255, 139, 175, 225),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: Colors.black, width: 1.2),
            ),
          ),
        ),
        onPressed: func ?? () {},
        child: Text(
          data,
          style: TextStyle(fontSize: fontSize, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
