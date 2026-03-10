import 'dart:io';

void main() {
  ///List To store Students Name..........
  List<String> studentNames = [];
  ///List To store Students Grade.........
  List<List<double>> allGrades = [];
  int numStudents = 0;
  while (true) {
    try {
      print('\nHow many students do you want to register?');
      String? input = stdin.readLineSync();
      numStudents = int.parse(input!);
      if (numStudents > 0) break;
      print('Please enter a number greater than 0.');
    } catch (e) {
      print('Invalid input! Please enter a valid integer number.');
    }
  }

  ///Register Students Data.....................
  for (int i = 0; i < numStudents; i++) {
    print('\n--- Recording Data for Student #${i + 1} ---');

    print('Enter student name:');
    String name = stdin.readLineSync() ?? 'Unknown';
    studentNames.add(name);

    int numSubjects = 0;
    while (true) {
      try {
        print('Enter number of subjects for $name:');
        numSubjects = int.parse(stdin.readLineSync()!);
        if (numSubjects > 0) break;
      } catch (e) {
        print('Invalid number of subjects. Try again.');
      }
    }

    List<double> currentGrades = [];
    for (int j = 0; j < numSubjects; j++) {
      while (true) {
        try {
          print('Enter grade for subject #${j + 1}:');
          double grade = double.parse(stdin.readLineSync()!);
          currentGrades.add(grade);
          break;
        } catch (e) {
          print('Invalid grade. Please enter a decimal or integer number.');
        }
      }
    }
    allGrades.add(currentGrades);
  }

  while (true) {
    print('\n******************************');
    print('MAIN MENU:');
    print('1. Show All Results');
    print('2. Search Student');
    print('3. Exit');
    print('******************************');
    print('Select an option (1-3):');

    String? choice = stdin.readLineSync();

    if (choice == '1') {
      print('\n--- ALL STUDENTS RESULTS ---');
      for (int i = 0; i < studentNames.length; i++) {
        double sum = 0;
        for (double g in allGrades[i]) {
          sum += g;
        }
        double avg = sum / allGrades[i].length;

        String nameUpper = studentNames[i].toUpperCase();
        String formattedAvg = avg.toStringAsFixed(2);

        String letterGrade;
        if (avg >= 90) letterGrade = 'A';
        else if (avg >= 80) letterGrade = 'B';
        else if (avg >= 70) letterGrade = 'C';
        else letterGrade = 'F';

        print('Name: $nameUpper | Avg: $formattedAvg | Grade: [$letterGrade]');
      }

    } else if (choice == '2') {
      print('\nEnter student name to search:');
      String? searchTarget = stdin.readLineSync()?.toLowerCase();
      bool isFound = false;

      for (int i = 0; i < studentNames.length; i++) {
        if (studentNames[i].toLowerCase() == searchTarget) {
          double sum = 0;
          for (double g in allGrades[i]) sum += g;
          double avg = sum / allGrades[i].length;

          print('FOUND: ${studentNames[i]} | Rounded Average: ${avg.round()}');
          isFound = true;
          break;
        }
      }
      if (!isFound) print('Error: Student name not found in our records.');

    } else if (choice == '3') {
      print('Exiting program... Good luck with your studies!');
      break;

    } else {
      print('Invalid choice. Please select 1, 2, or 3.');
    }
  }
}
