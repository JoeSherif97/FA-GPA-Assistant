import 'package:flutter/material.dart';
import 'package:gpacalculator/utils/gpa_logic.dart';
import 'package:gpacalculator/widgets/body_text.dart';
import 'package:gpacalculator/widgets/material_screen.dart';
import 'package:gpacalculator/widgets/submit_button.dart';
import 'package:gpacalculator/widgets/textfield.dart';

class GpaCalcSC2 extends StatefulWidget {
  final int summerSubj;
  final double agpa;
  final double th;

  const GpaCalcSC2({
    super.key,
    required this.summerSubj,
    required this.agpa,
    required this.th,
  });
  @override
  State<GpaCalcSC2> createState() => GpaSC2();
}

class GpaSC2 extends State<GpaCalcSC2> {
  late List<String?> selectedGrades;
  late List<TextEditingController> ch;

  @override
  void initState() {
    super.initState();
    selectedGrades = List.filled(widget.summerSubj, null);
    ch = List.generate(widget.summerSubj, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in ch) {
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
      "Summer Course\nCalculator",
      null,
      null,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "Please enter your subject letter grade and its credit hours",
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
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
            height: size.height * 0.5,
            child: ListView.builder(
              itemCount: widget.summerSubj,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: spacing / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BodyText(data: "Subject Nb ${index + 1}"),
                      DropdownButton<String>(
                        value: selectedGrades[index],
                        hint: Text(
                          "Grade",
                          style: TextStyle(fontSize: fontSize * 0.8),
                        ),
                        items:
                            grades.map((String grade) {
                              return DropdownMenuItem<String>(
                                value: grade,
                                child: Text(
                                  grade,
                                  style: TextStyle(
                                    fontSize: fontSize * 0.8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGrades[index] = newValue;
                          });
                        },
                        dropdownColor: Color.fromARGB(255, 213, 222, 239),
                        borderRadius: BorderRadius.circular(20),
                        underline: Container(height: 2, color: Colors.black),
                      ),
                      RTextField(controller: ch[index], label: "Hours"),
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
              for (var controller in ch) {
                if (controller.text.isEmpty) {
                  missingval = true;
                }
                if (double.tryParse(controller.text) == null ||
                    double.parse(controller.text) <= 0) {
                  invalidval = true;
                }
              }
              if (missingval || selectedGrades.contains(null)) {
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
                showDialog(context: context, builder: (context) => scdialog());
              }
            },
          ),
        ],
      ),
    );
  }

  AlertDialog scdialog() {
    //final size = MediaQuery.of(context).size;
    //final double fontSize = size.width * 0.05;

    return AlertDialog(
      title: null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              BodyText(
                data:
                    "Your new accumulative GPA\nafter taking ${widget.summerSubj} subjects in the\nsummer course is ${summergpa(widget.agpa, widget.th, selectedGrades.whereType<String>().toList(), ch)}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
