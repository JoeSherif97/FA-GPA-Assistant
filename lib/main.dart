import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:gpacalculator/screens/gpa_calc_screen.dart';

void main() {
  runApp(const GpaSplash());
}

class GpaSplash extends StatelessWidget {
  const GpaSplash({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: AnimatedSplashScreen(
        splashIconSize: double.infinity, // Ensure splash covers full screen
        duration: 3000,
        splash: Image.asset(
          "images/image_3.png",
          fit: BoxFit.cover, // Fill the entire screen
          width: size.width, // Full width
          height: size.height, // Full height
        ),
        nextScreen: const GpaCalc(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color.fromARGB(255, 241, 244, 251),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
