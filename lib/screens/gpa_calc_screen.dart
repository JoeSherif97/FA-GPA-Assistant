import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpacalculator/screens/about_screen.dart';
import 'package:gpacalculator/screens/calculate_gpa_screen.dart';
import 'package:gpacalculator/screens/letter_grader_screen.dart';
import 'package:gpacalculator/screens/gpa_predictor_screen.dart';
import 'package:gpacalculator/screens/summer_course_screen.dart';
import 'package:gpacalculator/widgets/custom_button.dart';

class GpaCalc extends StatefulWidget {
  const GpaCalc({super.key});
  @override
  State<GpaCalc> createState() => GpaCalcMain();
}

class GpaCalcMain extends State<GpaCalc> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.05; // 5% of screen width
    final double buttonSpacing = size.height * 0.01; // 1% of screen height
    final double logoHeight =
        size.height * 0.2; // 20% of screen height for logo
    final double fontSize = size.width * 0.06; // Responsive font size

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.lexendDecaTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 139, 175, 225),
          elevation: 0,
          child: Icon(
            color: Colors.black,
            Icons.info_rounded,
            size: MediaQuery.of(context).size.width * 0.05, //.clamp(18, 32),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GpaCalcAbt()),
            );
          },
        ),
        appBar: AppBar(toolbarHeight: 0),
        backgroundColor: Color.fromARGB(255, 139, 175, 225),
        body: SingleChildScrollView(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/image_1.png"),
                fit: BoxFit.cover, // Fill the entire background
                // Removed repeat to avoid tiling
              ),
            ),
            child: SizedBox(
              height: size.height, // Ensure container fills screen height
              width: size.width, // Ensure container fills screen width
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.05), // 5% of screen height
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "images/image_2.png",
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.medium,
                            height: logoHeight, // Responsive logo size
                          ),
                          Text(
                            'GPA\nCalculator',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: buttonSpacing),
                    OperationButton(
                      data: 'Calculate GPA',
                      align: Alignment.centerLeft,
                      func: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GpaCalcCG(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: buttonSpacing),
                    OperationButton(
                      data: 'Letter Grader',
                      align: Alignment.centerRight,
                      func: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GpaCalcLG(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: buttonSpacing),
                    OperationButton(
                      data: 'GPA Predictor',
                      align: Alignment.centerLeft,
                      func: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GpaCalcFG(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: buttonSpacing),
                    OperationButton(
                      data: 'Summer Course\nCalculator',
                      align: Alignment.centerRight,
                      func: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GpaCalcSC(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: buttonSpacing) /*
                    OperationButton(
                      data: 'About Us',
                      align: Alignment.centerLeft,
                      func: () {},
                    ),
                    //SizedBox(height: size.height * 0.05),*/,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
