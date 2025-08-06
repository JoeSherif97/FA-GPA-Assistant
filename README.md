# FA-GPA-Assistant

FA-GPA-Assistant is a Flutter-based mobile application designed for Future Academy students to calculate, predict, and track their Grade Point Average (GPA). The app provides tools for GPA calculation, letter grade conversion, future GPA prediction, and summer course planning, with a responsive design that works seamlessly across various screen sizes.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [Main Screen](#main-screen)
  - [GPA Predictor](#gpa-predictor)
  - [Letter Grader](#letter-grader)
  - [Calculate GPA](#calculate-gpa)
  - [Summer Course](#summer-course)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)

## Features
- **GPA Prediction**: Estimate the GPA needed to achieve a target GPA based on current GPA and course hours.
- **Letter Grade Conversion**: Convert numerical GPAs to letter grades (e.g., A+, B-, F) using a customizable grading scale.
- **GPA Calculation**: Compute semester and cumulative GPAs by inputting course grades and credit hours.
- **Summer Course Planning**: Calculate the impact of summer courses on your cumulative GPA.
- **Responsive Design**: Adapts to various screen sizes, ensuring a consistent UI on mobile and tablet devices.
- **User-Friendly Interface**: Built with Flutter for a smooth, intuitive experience with clear input fields and instant feedback.

## Installation
To set up and run FA-GPA-Assistant locally, follow these steps:

1. **Prerequisites**:
   - Install [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0.0 or higher).
   - Install a code editor (e.g., VS Code, Android Studio) with Flutter and Dart plugins.
   - Ensure an emulator or physical device is set up for testing (Android or iOS).

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/FA-GPA-Assistant.git
   cd FA-GPA-Assistant
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   ```bash
   flutter run
   ```
   Select your target device (e.g., Android emulator, iOS simulator, or connected device).

## Usage
FA-GPA-Assistant offers multiple screens to manage your academic performance. Below is a guide to each screen, including placeholders for screenshots to illustrate functionality and cases.

### Main Screen
The main screen serves as the entry point, providing navigation to all features: GPA Predictor, Letter Grader, Calculate GPA, and Summer Course.

- **Navigation**: Tap buttons to access each feature.
- **UI Elements**: Custom header, buttons styled with `google_fonts`, and a responsive layout.

**Screenshots**:

<img src="https://github.com/user-attachments/assets/8fbe2fe2-d74f-4aae-a116-4dfc74b7525d" width="332" height="720">

### GPA Predictor
The GPA Predictor screen (`lib/gpa_predictor_screen.dart`) allows users to predict the GPA needed to reach a target GPA.

- **Inputs**:
  - Current GPA (0–4)
  - Total Hours
  - Future GPA (target, 0–4)
  - Next Hours
- **Functionality**:
  - Validates inputs (non-empty, numeric, GPA 0–4, non-negative hours).
  - Displays a dialog with results:
    - **Exceeded Case**: If the required GPA exceeds 4.0, shows the maximum achievable GPA with a 4.0 semester.
    - **Not Exceeded Case**: Shows the required GPA to meet the target.
- **UI Elements**:
  - Input fields (`RTextField`) in two rows.
  - Submit button with a custom icon (`assets/images/submit.png`).
  - Responsive dialog with `Text` widgets for messages and a read-only `TextField` for GPA results.

**Screenshots**:

#### Main GPA Predictor Screen

<img src="https://github.com/user-attachments/assets/ec45f5b2-c07b-43c1-bff8-954956f8bd3b" width="332" height="720">

#### Exceed And Not Exceed Cases

<img src="https://github.com/user-attachments/assets/200e3e59-c113-4c83-bac9-3c5d1db25b9c" width="332" height="720">
<img src="https://github.com/user-attachments/assets/5ce448b1-91c7-4d03-92d8-40ee3ba30dab" width="332" height="720">

#### Error Handling

<img src="https://github.com/user-attachments/assets/24e23813-e2ac-4fe7-ae11-6b9a8ff8227e" width="332" height="720">
<img src="https://github.com/user-attachments/assets/e1154dda-3739-44a7-b4e3-2425e1714cef" width="332" height="720">

### Letter Grader
The Letter Grader screen (`lib/letter_grader_screen.dart`) converts a numerical GPA to a letter grade based on a predefined scale (e.g., 3.84–4.0 = A+).

- **Inputs**: A single GPA value (0–4).
- **Functionality**:
  - Validates the input (numeric, 0–4).
  - Displays the corresponding letter grade (e.g., A, B-, F) in a dialog.
- **UI Elements**:
  - Single input field.
  - Submit button.
  - Dialog with the letter grade result.

**Screenshots**:

#### Main Letter Grader Screen

<img src="https://github.com/user-attachments/assets/4633cd69-4dd7-4136-a4e6-7da1b18cf453" width="332" height="720">

#### Letter Graded

<img src="https://github.com/user-attachments/assets/529fc716-c525-40ce-a8e2-cf7eeb94c54f" width="332" height="720">
<img src="https://github.com/user-attachments/assets/46daac6c-ccf9-4657-b634-56e3dfd1a48f" width="332" height="720">

### Calculate GPA
The Calculate GPA screens (`lib/calculate_gpa_screen.dart`, `lib/calculate_gpa_screen2.dart`) compute semester and cumulative GPAs.

- **Inputs**:
  - Course grades (dropdowns with A+, A, B-, etc.).
  - Credit hours per course.
- **Functionality**:
  - Calculates semester GPA based on grades and hours.
  - Tracks cumulative GPA across multiple submissions.
  - Displays results in a dialog with semester GPA, hours, and letter grade.
- **UI Elements**:
  - Dynamic list of grade/hour inputs.
  - Submit button to calculate and display results.
  - Navigation between screens for multiple semesters.

**Screenshots**:

#### Main Calculate GPA Screen

<img src="https://github.com/user-attachments/assets/af9452b2-8b2d-4cdc-a205-cde094df714c" width="332" height="720">
<img src="https://github.com/user-attachments/assets/f94641c0-cfd7-463f-afd2-5b8e6aa508da" width="332" height="720">

#### Semester Calculating Screen

<img src="https://github.com/user-attachments/assets/1218b7e6-55f7-4579-92c8-2edd64bcaf8b" width="332" height="720">

#### Semester And Accumulative Analytics

<img src="https://github.com/user-attachments/assets/a6a9912a-ef0e-4bb3-be68-ab95155743fd" width="332" height="720">

#### All Semester Fullfield 

<img src="https://github.com/user-attachments/assets/2d3a5369-553b-4d49-ad1e-2b420835fa4e" width="332" height="720">

### Summer Course
The Summer Course screens (`lib/summer_course_screen.dart`, `lib/summer_course_screen2.dart`) calculate the impact of summer courses on cumulative GPA.

- **Inputs**:
  - Current GPA and total hours.
  - Summer course grades and hours.
- **Functionality**:
  - Computes the new cumulative GPA after adding summer courses.
  - Displays results in a dialog.
- **UI Elements**:
  - Input fields for current GPA and hours.
  - Dynamic grade/hour inputs for summer courses.
  - Submit button and result dialog.

**Screenshots**:

#### Main Summer Course Screen

<img src="https://github.com/user-attachments/assets/eef0c1f7-1708-4200-9773-8ae4ed7d3862" width="332" height="720">
<img src="https://github.com/user-attachments/assets/2194a647-1943-42d9-8636-7f4f38d1192c" width="332" height="720">

#### Summer Course Analytics

<img src="https://github.com/user-attachments/assets/d4dfc805-0d69-44bd-a8d4-34c0d238b7bf" width="332" height="720">

## Project Structure
The project is organized to ensure modularity and maintainability:

```
FA-GPA-Assistant/
├── lib/
│   ├── main.dart                # App entry point
│   ├── gpa_predictor_screen.dart # GPA prediction feature
│   ├── gpa_calc_screen.dart     # Semester GPA calculation
│   ├── calculate_gpa_screen.dart # Multi-semester GPA calculation
│   ├── calculate_gpa_screen2.dart # Additional semester inputs
│   ├── summer_course_screen.dart # Summer course GPA impact
│   ├── summer_course_screen2.dart # Additional summer course inputs
│   ├── letter_grader_screen.dart # Letter grade conversion
│   ├── header.dart              # Custom header widget
│   ├── utils/
│   │   └── gpa_logic.dart       # GPA calculation and grading logic
│   ├── widgets/
│   │   ├── material_screen.dart  # Custom screen wrapper
│   │   ├── textfield.dart       # Custom text field widget
│   │   ├── submit_button.dart   # Custom submit button
│   │   └── body_text.dart       # Custom text widget
├── images/
│       └── submit.png           # Submit button icon
├── android/                     # Android-specific configs
│   ├── app/src/main/AndroidManifest.xml
│   └── app/build.gradle
├── pubspec.yaml                 # Dependencies and metadata
├── pubspec.lock                 # Locked dependency versions          
└── README.md                   # Project documentation
```

## Dependencies
The app relies on the following Flutter packages:
- `flutter`: Core SDK for building the app.
- `percent_indicator: ^4.2.3`: Displays progress indicators (used in some screens).
- `google_fonts: ^6.2.1`: Custom fonts for consistent typography.

Add these to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  percent_indicator: ^4.2.3
  google_fonts: ^6.2.1
```
