import 'package:flutter/material.dart';
import 'package:gpacalculator/utils/gpa_logic.dart';
import 'package:gpacalculator/widgets/body_text.dart';
import 'package:gpacalculator/widgets/custom_button.dart';
import 'package:gpacalculator/widgets/material_screen.dart';
import 'package:gpacalculator/widgets/submit_button.dart';
import 'package:gpacalculator/widgets/textfield.dart';

class GpaCalcCG2 extends StatefulWidget {
  final int totalsemesters;
  final List<int> subjectcounts;

  const GpaCalcCG2({
    super.key,
    required this.totalsemesters,
    required this.subjectcounts,
  });

  @override
  State<GpaCalcCG2> createState() => GpaCG2();
}

class GpaCG2 extends State<GpaCalcCG2> {
  int currentSemester = 1;
  List<String?> selectedGrades = [];
  List<TextEditingController> ch = [];
  Map<String, dynamic>? semesterStats;

  @override
  void initState() {
    super.initState();
    _initializeSubjectInputs();
  }

  void _initializeSubjectInputs() {
    final int numSubjects = widget.subjectcounts[currentSemester - 1];
    selectedGrades = List.filled(numSubjects, null);
    ch = List.generate(numSubjects, (_) => TextEditingController());
    semesterStats = null;
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
      "Calculate GPA",
      null,
      null,
      Column(
        children: [
          SizedBox(height: spacing),
          Text(
            "Please enter grades and hours for semester $currentSemester",
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
              itemCount: selectedGrades.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: spacing / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BodyText(data: "Subject ${index + 1}"),
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
              bool missingVal = false;
              bool invalidVal = false;
              for (var controller in ch) {
                if (controller.text.isEmpty) {
                  missingVal = true;
                } else if (double.tryParse(controller.text) == null ||
                    double.parse(controller.text) <= 0) {
                  invalidVal = true;
                }
              }
              if (missingVal || selectedGrades.contains(null)) {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Center(
                          child: Text(
                            "Please enter all grades and hours",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                );
              } else if (invalidVal) {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Center(
                          child: Text(
                            "Invalid credit hours",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                );
              } else {
                if (GpaCalculator.openCount < currentSemester) {
                  setState(() {
                    semesterStats = GpaCalculator.calculateSemesterGpa(
                      selectedGrades.whereType<String>().toList(),
                      ch,
                    );
                  });
                }
                showDialog(
                  context: context,
                  builder: (context) => cgstatdialog(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  AlertDialog cgstatdialog() {
    final size = MediaQuery.of(context).size;
    final double fontSize = size.width * 0.05;
    final double spacing = size.height * 0.02;
    final cumulativeStats = GpaCalculator.calculateCumulativeGpa();

    return AlertDialog(
      insetPadding: EdgeInsets.all(size.width * 0.02),
      title: Text(
        "Semester $currentSemester Statistics",
        style: TextStyle(fontSize: fontSize * 1.1, fontWeight: FontWeight.w600),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Semester Analytics",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: spacing),
            BodyText(data: "Semester Credit Hours: ${semesterStats!['hours']}"),
            BodyText(data: "Semester GPA: ${semesterStats!['gpa']}"),
            BodyText(
              data: "Semester Letter Grade: ${semesterStats!['letterGrade']}",
            ),
            SizedBox(height: spacing),
            LinearProgressIndicator(value: 1, color: Colors.black),
            SizedBox(height: spacing),
            Center(
              child: Text(
                "Cumulative Analytics",
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: spacing),
            BodyText(data: "Total Credit Hours: ${cumulativeStats['hours']}"),
            BodyText(data: "Cumulative GPA: ${cumulativeStats['gpa']}"),
            BodyText(
              data:
                  "Letter Grade of your GPA: ${cumulativeStats['letterGrade']}",
            ),
            BodyText(
              data:
                  "Permitted hours in next semester: ${GpaCalculator.permittedHours(double.parse(cumulativeStats['gpa']))}",
            ),
          ],
        ),
      ),
      actions: [
        OperationButton(
          data: "Next Semester",
          align: Alignment.center,
          func: () {
            if (currentSemester >= widget.totalsemesters) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: Center(
                        child: Text(
                          "All semesters completed",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
              ).then((_) {
                GpaCalculator.reset();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              });
            } else {
              setState(() {
                currentSemester++;
                _initializeSubjectInputs();
              });
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
