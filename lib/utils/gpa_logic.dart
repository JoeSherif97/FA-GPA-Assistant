import 'package:flutter/material.dart';

double gpapredictor(
  double currentGPA,
  double totalHours,
  double futureGPA,
  double nextHours,
) {
  return ((currentGPA * totalHours) + (futureGPA * nextHours)) /
      (totalHours + nextHours);
}

String? lettergrader(double parse) {
  double grade = parse;
  if (grade >= 0.0 && grade < 2) {
    return "F";
  } else if (grade >= 2.0 && grade < 2.2) {
    return "D-";
  } else if (grade >= 2.2 && grade < 2.4) {
    return "D";
  } else if (grade >= 2.4 && grade < 2.56) {
    return "D+";
  } else if (grade >= 2.56 && grade < 2.72) {
    return "C-";
  } else if (grade >= 2.72 && grade < 2.88) {
    return "C";
  } else if (grade >= 2.88 && grade < 3.04) {
    return "C+";
  } else if (grade >= 3.04 && grade < 3.2) {
    return "B-";
  } else if (grade >= 3.2 && grade < 3.36) {
    return "B";
  } else if (grade >= 3.36 && grade < 3.52) {
    return "B+";
  } else if (grade >= 3.52 && grade < 3.68) {
    return "A-";
  } else if (grade >= 3.68 && grade < 3.84) {
    return "A";
  } else if (grade >= 3.84 && grade <= 4) {
    return "A+";
  }
  return null;
}

Map<String?, bool> futuregpa(double cgpa, double th, double fgpa, double nh) {
  bool exceeded;
  final double sumcurrent = cgpa * th;
  double sumfuture = fgpa * (th + nh);
  double denom = sumfuture - sumcurrent;
  double estimatedGPA = denom / nh;
  if (estimatedGPA > 4) {
    exceeded = true;
    estimatedGPA = 4;
    denom = estimatedGPA * nh;
    sumfuture = denom + sumcurrent;
    fgpa = sumfuture / (th + nh);
    return {fgpa.toStringAsFixed(2): exceeded};
  } else {
    exceeded = false;
    return {estimatedGPA.toStringAsFixed(2): exceeded};
  }
}

bool only0to4num(TextEditingController controller, bool to4) {
  if (to4) {
    return (controller.text.toUpperCase().contains(RegExp(r'[A-Z]')) ||
        double.parse(controller.text) > 4 ||
        double.parse(controller.text) < 0);
  } else {
    return (controller.text.toUpperCase().contains(RegExp(r'[A-Z]')));
  }
}

List<String> grades = [
  'A+',
  'A',
  'A-',
  'B+',
  'B',
  'B-',
  'C+',
  'C',
  'C-',
  'D+',
  'D',
  'D-',
  'F',
];

double gradeletterer(String letter) {
  Map<String, double> grading = {
    'A+': 4,
    'A': 3.7,
    'A-': 3.4,
    'B+': 3.2,
    'B': 3.0,
    'B-': 2.8,
    'C+': 2.6,
    'C': 2.4,
    'C-': 2.2,
    'D+': 2,
    'D': 1.5,
    'D-': 1,
    'F': 0,
  };
  return grading[letter] ?? 0;
}

String summergpa(
  double cgpa,
  double th,
  List<String> grades,
  List<TextEditingController> hours,
) {
  final double currentPoints = cgpa * th;
  double summerPoints = 0.0;
  double summerHours = 0.0;

  for (int i = 0; i < grades.length; i++) {
    final double gradePoints = gradeletterer(grades[i]);
    final double creditHours = double.parse(hours[i].text);
    summerPoints += gradePoints * creditHours;
    summerHours += creditHours;
  }

  final double totalPoints = currentPoints + summerPoints;
  final double totalHours = th + summerHours;

  if (totalHours == 0) return "0.00"; // Prevent division by zero
  return (totalPoints / totalHours).toStringAsFixed(2);
}

Color colormode(double percent) {
  if (percent <= 1 && percent > 0.96) {
    return Colors.green;
  } else if (percent < 0.96 && percent >= 0.92) {
    return Colors.lightGreen;
  } else if (percent < 0.92 && percent >= 0.84) {
    return Colors.lime;
  } else if (percent < 0.84 && percent >= 0.80) {
    return Colors.yellow;
  } else if (percent < 0.80 && percent >= 0.76) {
    return Colors.amber;
  } else if (percent < 0.76 && percent >= 0.72) {
    return Colors.orange;
  } else if (percent < 0.72 && percent >= 0.68) {
    return Colors.deepOrange;
  } else if (percent < 0.68 && percent >= 0.64) {
    return Colors.red;
  } else if (percent < 0.64 && percent >= 0.60) {
    return Colors.red.shade600;
  } else if (percent < 0.60 && percent >= 0.55) {
    return Colors.red.shade800;
  } else if (percent < 0.55 && percent >= 0.50) {
    return Colors.red.shade900;
  } else {
    return Colors.black;
  }
}

class GpaCalculator {
  static List<double> sumPoints = [];
  static List<double> sumHours = [];
  static int openCount = 0;

  static Map<String, dynamic> calculateSemesterGpa(
    List<String> grades,
    List<TextEditingController> hours,
  ) {
    double semesterPoints = 0.0;
    double semesterHours = 0.0;

    for (int i = 0; i < grades.length; i++) {
      final double gradePoints = gradeletterer(grades[i]);
      final double creditHours = double.parse(hours[i].text);
      semesterPoints += gradePoints * creditHours;
      semesterHours += creditHours;
      debugPrint(
        'Subject ${i + 1}: Grade = ${grades[i]}, Points = $gradePoints, Hours = $creditHours, Contribution = ${gradePoints * creditHours}',
      );
    }
    debugPrint(
      'Semester Points: $semesterPoints, Semester Hours: $semesterHours',
    );

    if (openCount >= sumPoints.length) {
      sumPoints.add(semesterPoints);
      sumHours.add(semesterHours);
    } else {
      sumPoints[openCount] = semesterPoints;
      sumHours[openCount] = semesterHours;
    }
    openCount++;

    double semesterGpa =
        semesterHours > 0 ? semesterPoints / semesterHours : 0.0;

    semesterGpa *= 10000;
    semesterGpa.roundToDouble();
    semesterGpa /= 10000;
    semesterGpa *= 1000;
    semesterGpa.roundToDouble();
    semesterGpa /= 1000;
    semesterGpa *= 100;
    semesterGpa.roundToDouble();
    semesterGpa /= 100;

    debugPrint('Semester GPA: $semesterGpa');
    return {
      'gpa': semesterGpa.toStringAsFixed(2),
      'hours': semesterHours.toStringAsFixed(1),
      'letterGrade': lettergrader(semesterGpa),
    };
  }

  static Map<String, dynamic> calculateCumulativeGpa() {
    double totalPoints = sumPoints.fold(0.0, (sum, points) => sum + points);
    double totalHours = sumHours.fold(0.0, (sum, hours) => sum + hours);
    double cumulativeGpa = totalHours > 0 ? totalPoints / totalHours : 0.0;

    cumulativeGpa *= 10000;
    cumulativeGpa.roundToDouble();
    cumulativeGpa /= 10000;
    cumulativeGpa *= 1000;
    cumulativeGpa.roundToDouble();
    cumulativeGpa /= 1000;
    cumulativeGpa *= 100;
    cumulativeGpa.roundToDouble();
    cumulativeGpa /= 100;

    debugPrint(
      'Cumulative Points: $totalPoints, Cumulative Hours: $totalHours, Cumulative GPA: $cumulativeGpa',
    );
    return {
      'gpa': cumulativeGpa.toStringAsFixed(2),
      'hours': totalHours.toStringAsFixed(1),
      'letterGrade': lettergrader(cumulativeGpa),
    };
  }

  static String permittedHours(double gpa) {
    if (gpa >= 3.0) {
      return '21';
    } else if (gpa >= 2.0) {
      return '18';
    } else if (gpa >= 1.0) {
      return '15';
    } else if (gpa >= 0.0) {
      return '12';
    }
    return 'N/A';
  }

  static void reset() {
    openCount = 0;
    sumPoints.clear();
    sumHours.clear();
  }
}
