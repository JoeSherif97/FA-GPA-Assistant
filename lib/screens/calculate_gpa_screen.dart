import 'package:flutter/material.dart';
import 'package:gpacalculator/screens/calculate_gpa_screen2.dart';
import 'package:gpacalculator/utils/gpa_logic.dart';
import 'package:gpacalculator/widgets/body_text.dart';
import 'package:gpacalculator/widgets/material_screen.dart';
import 'package:gpacalculator/widgets/submit_button.dart';
import 'package:gpacalculator/widgets/textfield.dart';

class GpaCalcCG extends StatefulWidget {
  const GpaCalcCG({super.key});
  @override
  State<GpaCalcCG> createState() => GpaCG();
}

class GpaCG extends State<GpaCalcCG> {
  final TextEditingController cs = TextEditingController();
  List<TextEditingController> ssubj = [];
  bool menuvisible = false;
  int itemscount = 0;

  @override
  void initState() {
    super.initState();
    ssubj = [];
  }

  @override
  void dispose() {
    cs.dispose();
    for (var controller in ssubj) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.03;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;

    return screen(
      context,
      "Calculate GPA",
      null,
      null,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "Please enter your current semester",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: spacing / 2),
          Wrap(
            spacing: size.width * 0.02,
            runSpacing: spacing / 2,
            alignment: WrapAlignment.center,
            children: [
              RTextField(controller: cs, label: "Current Semester"),
              SubmitButton(
                icosize: size.width * 0.15,
                icoimg: AssetImage("images/submit.png"),
                onp: () {
                  if (cs.text.isEmpty) {
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
                  } else if (only0to4num(cs, false)) {
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
                      itemscount = int.parse(cs.text);
                      ssubj = List.generate(
                        itemscount,
                        (_) => TextEditingController(),
                      );
                      menuvisible = true;
                    });
                  }
                },
              ),
            ],
          ),
          Visibility(
            visible: menuvisible,
            child: Column(
              children: [
                SizedBox(height: spacing),
                Text(
                  "Please enter how many subjects you have each semester",
                  style: TextStyle(
                    fontSize: fontSize * 0.9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spacing / 2),
                Container(
                  margin: EdgeInsets.all(padding),
                  padding: EdgeInsets.all(padding),
                  decoration: ShapeDecoration(
                    color: Color.fromARGB(255, 213, 222, 239),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(width: 1.5, style: BorderStyle.solid),
                    ),
                  ),
                  width: double.infinity,
                  height: size.height * 0.5, // 50% of screen height
                  child: ListView.builder(
                    itemCount: itemscount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: spacing / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BodyText(data: "Semester Nb ${index + 1}"),
                            RTextField(
                              controller: ssubj[index],
                              label: "Number of Subjects",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: spacing),
                Text(
                  "Kindly fill the fields above, then press the button below",
                  style: TextStyle(
                    fontSize: fontSize * 0.9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spacing / 2),
                SubmitButton(
                  icosize: size.width * 0.15,
                  icoimg: AssetImage("images/submit.png"),
                  onp: () {
                    bool missingval = false;
                    bool invalidval = false;
                    for (var controller in ssubj) {
                      if (controller.text.isEmpty) {
                        missingval = true;
                      }
                      if (double.tryParse(controller.text) == null ||
                          double.parse(controller.text) <= 0) {
                        invalidval = true;
                      }
                    }
                    if (missingval) {
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
                    } else if (invalidval) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => GpaCalcCG2(
                                totalsemesters: int.parse(cs.text),
                                subjectcounts:
                                    ssubj
                                        .map((c) => int.parse(c.text))
                                        .toList(),
                              ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
