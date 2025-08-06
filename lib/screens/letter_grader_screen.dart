import 'package:flutter/material.dart';
import 'package:gpacalculator/widgets/material_screen.dart';
import 'package:gpacalculator/widgets/submit_button.dart';
import 'package:gpacalculator/widgets/body_text.dart';
import 'package:gpacalculator/utils/gpa_logic.dart';
import 'package:gpacalculator/widgets/textfield.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GpaCalcLG extends StatefulWidget {
  const GpaCalcLG({super.key});
  @override
  State<GpaCalcLG> createState() => GpaLG();
}

class GpaLG extends State<GpaCalcLG> {
  TextEditingController lg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final double padding = size.width * 0.03;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;

    return screen(
      context,
      "The Letter Grader",
      null,
      fontSize * 1.2,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "Please enter your GPA to get your letter grade",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing / 2),
          Wrap(
            spacing: size.width * 0.02,
            runSpacing: spacing / 2,
            alignment: WrapAlignment.start,
            children: [
              Row(
                children: [
                  RTextField(controller: lg, label: "GPA"),
                  SubmitButton(
                    icosize: size.width * 0.15,
                    icoimg: AssetImage("images/submit.png"),
                    onp: () {
                      if (lg.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Center(
                                  child: Text(
                                    "Please Enter an input",
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                        );
                      } else if (lg.text.toUpperCase().contains(
                            RegExp(r'[A-Z]'),
                          ) ||
                          double.parse(lg.text) > 4 ||
                          double.parse(lg.text) < 0) {
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
                          builder: (context) => lgdialog(),
                        );
                      }
                    },
                  ),
                ],
              ),
              BodyText(data: "Note: GPA must follow the rule of 0 ≤ GPA ≤ 4"),
            ],
          ),
        ],
      ),
    );
  }

  AlertDialog lgdialog() {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;

    return AlertDialog(
      title: null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              BodyText(data: "Your Letter Grade is\t\t\t\t"),
              SizedBox.square(
                dimension: size.width * 0.15,
                child: TextField(
                  controller: TextEditingController(
                    text: lettergrader(double.parse(lg.text)),
                  ),
                  readOnly: true,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 213, 222, 239),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          CircularPercentIndicator(
            progressColor: colormode(double.parse(lg.text) / 4),
            animation: true,
            animationDuration: 300,
            radius: size.width * 0.2,
            lineWidth: size.width * 0.05,
            percent: double.parse(lg.text) / 4,
            center: BodyText(
              data:
                  "${(double.parse((double.parse(lg.text) / 4).toStringAsFixed(3)) * 100).toStringAsPrecision(4)}%",
            ),
          ),
        ],
      ),
    );
  }
}
