import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpacalculator/widgets/header.dart';

Widget screen(
  BuildContext context,
  String headertext,
  double? ktoolh,
  double? fsz,
  Widget body,
) {
  final size = MediaQuery.of(context).size;
  final double padding = size.width * 0.03;

  return MaterialApp(
    theme: ThemeData(
      textTheme: GoogleFonts.lexendDecaTextTheme(Theme.of(context).textTheme),
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: header(headertext, context, ktoolh, fsz),
      backgroundColor: const Color.fromARGB(255, 139, 175, 225),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding / 2,
          ),
          child: SingleChildScrollView(child: body),
        ),
      ),
    ),
  );
}
