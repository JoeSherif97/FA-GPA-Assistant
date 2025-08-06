import 'package:flutter/material.dart';
import 'package:gpacalculator/screens/summer_course_screen2.dart';
import 'package:gpacalculator/utils/gpa_logic.dart';
import 'package:gpacalculator/widgets/material_screen.dart';
import 'package:gpacalculator/widgets/submit_button.dart';
import 'package:gpacalculator/widgets/textfield.dart';

class GpaCalcSC extends StatefulWidget {
  const GpaCalcSC({super.key});
  @override
  State<GpaCalcSC> createState() => GpaSC();
}

class GpaSC extends State<GpaCalcSC> {
  late int summerSubj;
  late double totalpoints;
  TextEditingController agpa = TextEditingController();
  TextEditingController th = TextEditingController();
  TextEditingController sh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final double padding = size.width * 0.03;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;

    return screen(
      context,
      "Summer Course\nCalculator",
      null,
      null,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "Please enter your current accumulative GPA, total credit hours, and number of summer course subjects you will take.",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing / 2),
          Wrap(
            spacing: size.width * 0.02,
            runSpacing: spacing / 2,
            alignment: WrapAlignment.center,
            children: [
              RTextField(controller: agpa, label: "Accumulative GPA"),
              RTextField(controller: th, label: "Total Hours"),
              RTextField(controller: sh, label: "Summer Subjects"),
              SubmitButton(
                icosize: size.width * 0.15,
                icoimg: AssetImage("images/submit.png"),
                onp: () {
                  if (agpa.text.isEmpty || th.text.isEmpty || sh.text.isEmpty) {
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
                  } else if (only0to4num(agpa, true) ||
                      only0to4num(th, false) ||
                      only0to4num(sh, false)) {
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
                    setState(() {
                      totalpoints =
                          double.parse(agpa.text) * double.parse(th.text);
                      summerSubj = int.parse(sh.text);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => GpaCalcSC2(
                              summerSubj: summerSubj,
                              agpa: double.parse(agpa.text),
                              th: double.parse(th.text),
                            ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    agpa.dispose();
    th.dispose();
    sh.dispose();
    super.dispose();
  }
}
