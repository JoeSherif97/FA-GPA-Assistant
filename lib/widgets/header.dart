import 'package:flutter/material.dart';
import 'package:gpacalculator/widgets/submit_button.dart';

AppBar header(
  String heading,
  BuildContext context,
  double? ktoolh,
  double? fsz,
) {
  final size = MediaQuery.of(context).size;
  final double toolbarHeight = size.height * 0.1; // 10% of screen height
  final double fontSize = fsz ?? size.width * 0.06; // Responsive font size
  ktoolh = ktoolh ?? 1.25;

  return AppBar(
    toolbarHeight: toolbarHeight * ktoolh,
    backgroundColor: const Color.fromARGB(255, 139, 175, 225),
    automaticallyImplyLeading: false, // Disable default leading to customize
    flexibleSpace: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            Container(
              width: size.width * 0.15, // Fixed width for back button
              padding: EdgeInsets.only(
                right: size.width * 0.03,
              ), // Gap from text
              child: SubmitButton(
                icosize: (size.width * 0.05).clamp(
                  18,
                  32,
                ), // Tighter size range
                icoimg: const AssetImage("images/backarrow.png"),
                onp: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Header text
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 98, 142, 205),
                  border: Border.all(),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                padding: EdgeInsets.all(size.width * 0.03),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    heading,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
