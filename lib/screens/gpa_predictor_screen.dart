import 'package:flutter/material.dart';
import 'package:gpacalculator/widgets/material_screen.dart';
import 'package:gpacalculator/widgets/submit_button.dart';
import 'package:gpacalculator/utils/gpa_logic.dart';
import 'package:gpacalculator/widgets/textfield.dart';

class GpaCalcFG extends StatefulWidget {
  const GpaCalcFG({super.key});
  @override
  State<GpaCalcFG> createState() => GpaFG();
}

class GpaFG extends State<GpaCalcFG> {
  TextEditingController cgpa = TextEditingController();
  TextEditingController th = TextEditingController();
  TextEditingController fgpa = TextEditingController();
  TextEditingController nh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final double padding = size.width * 0.03;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;
    final double inputWidth = size.width * 0.35;
    final double buttonSize = size.width * 0.15;

    return screen(
      context,
      "GPA Predictor",
      null,
      fontSize * 1.2,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "Please enter your current GPA, current total hours, the GPA you want to achieve, & aproximate next semester hours, to see what semester GPA you have to get:",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: inputWidth,
                child: RTextField(controller: cgpa, label: "Current GPA"),
              ),
              SizedBox(width: spacing),
              SizedBox(
                width: inputWidth,
                child: RTextField(controller: th, label: "Total Hours"),
              ),
              SizedBox(width: spacing),
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: SubmitButton(
                  icosize: buttonSize * 0.8,
                  icoimg: const AssetImage("images/submit.png"),
                  onp: () {
                    if (cgpa.text.isEmpty ||
                        th.text.isEmpty ||
                        fgpa.text.isEmpty ||
                        nh.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  "Please Enter all inputs",
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                      );
                    } else if (cgpa.text.toUpperCase().contains(
                          RegExp(r'[A-Z]'),
                        ) ||
                        th.text.toUpperCase().contains(RegExp(r'[A-Z]')) ||
                        fgpa.text.toUpperCase().contains(RegExp(r'[A-Z]')) ||
                        nh.text.toUpperCase().contains(RegExp(r'[A-Z]')) ||
                        double.parse(cgpa.text) > 4 ||
                        double.parse(cgpa.text) < 0 ||
                        double.parse(fgpa.text) > 4 ||
                        double.parse(fgpa.text) < 0 ||
                        double.parse(th.text) < 0 ||
                        double.parse(nh.text) < 0) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  "Invalid Input",
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => fgdialog(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spacing / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: inputWidth,
                child: RTextField(controller: fgpa, label: "Future GPA"),
              ),
              SizedBox(width: spacing),
              SizedBox(
                width: inputWidth,
                child: RTextField(controller: nh, label: "Next Hours"),
              ),
              SizedBox(width: buttonSize + spacing),
            ],
          ),
          SizedBox(height: spacing / 2),
          Text(
            "Note: if Your GPA Cannot be achieved in 1 Semester, You will get the maximum accumulative GPA you can get by scoring semester GPA 4.0",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  AlertDialog fgdialog() {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;
    //final double textFieldWidth = size.width * 0.15;
    //final double textFieldHeight = size.width * 0.1;

    final result = futuregpa(
      double.parse(cgpa.text),
      double.parse(th.text),
      double.parse(fgpa.text),
      double.parse(nh.text),
    );

    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 213, 222, 239),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          "GPA Prediction Result",
          style: TextStyle(
            fontSize: fontSize * 1.2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(spacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (result.values.first) ...[
                // Exceeded Case
                Text(
                  "You cannot reach this GPA by next semester, but if you got a GPA of 4.0, you will reach GPA of ${result.keys.first ?? "N/A"}",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                // Not Exceeded Case
                Text(
                  "You will need estimate GPA of ${result.keys.first ?? "N/A"} to reach the GPA you want",
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
      /*actions: [
        /*
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      */
      ],*/
    );
  }
}
