import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart'; // Import the provider package// Import your data functions

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart'; // Import the provider package

import '../services/db_functions.dart';
import '../model/task_model/workoutmodel1.dart'; // Import your data functions

class ChartData extends ChangeNotifier {
  String _selectedValue = 'Day'; // Initial selected value
  int daytotal = getDayTasksCount();
  int dayCompleted = getDayTasksCountCpt();
  int weektotal = getWeekTasksCountwk();
  int weekcompleted = getWeekTasksCountCheckeds();
  int monthtotal = getMonthTasksCount();
  int monthcompleted = getMonthTasksCountmonth();
  int daydiffrence = getDayTasksCount() - getDayTasksCountCpt();
  int weekdiffrence = getWeekTasksCountwk() - getWeekTasksCountCheckeds();
  int monthdiffrence = getMonthTasksCount() - getMonthTasksCountmonth();
  int touchedIndex = -1;
  
  // Getter for selected value
  String get selectedValue => _selectedValue;

  // Setter for selected value
  set selectedValue(String newValue) {
    _selectedValue = newValue;
    notifyListeners(); // Notify listeners when the value changes
  }

  // Add methods to update other data properties based on selectedValue
  List<PieChartSectionData> showingSections() {
    switch (_selectedValue) {
      case 'Day':
        int completedTasks = dayCompleted;
        int totalTasks = daytotal;
        double completedPercentage = (completedTasks / totalTasks) * 100;
        double remainingPercentage = 100 - completedPercentage;
        return generateChartData(completedPercentage, remainingPercentage);
      case 'Week':
        int completedTasks = weekcompleted;
        int totalTasks = weektotal;
        double completedPercentage = (completedTasks / totalTasks) * 100;
        double remainingPercentage = 100 - completedPercentage;
        return generateChartData(completedPercentage, remainingPercentage);
      case 'Month':
        int completedTasks = monthcompleted;
        int totalTasks = monthtotal;
        double completedPercentage = (completedTasks / totalTasks) * 100;
        double remainingPercentage = 100 - completedPercentage;
        return generateChartData(completedPercentage, remainingPercentage);
      default:
        throw Exception('Invalid selected value');
    }
  }

  List<PieChartSectionData> generateChartData(double value1, double value2) {
    final List<Color> colors = [Colors.green, Colors.red];
    final List<double> values = [value1, value2];

    if (values.any((value) => value.isNaN || value.isInfinite || value.isNegative)) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 100.0,
          title: 'NO TASKS',
          radius: 100.0,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
          titlePositionPercentageOffset: 0.0,
        ),
      ];
    }

    return List.generate(2, (i) {
      final fontSize = 16.0;
      final radius = 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colors[i],
        value: values[i],
        title: 'Task ${values[i].toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
      );
    });
  }
//   import '../function/db_functions.dart';
// import '../model/task_model/workoutmodel1.dart';


}
int getDayTasksCount() {
  // Get the list of tasks from the notifier
  List<Workoutmodel> tasks = workoutListNotifier.value;

  // Get the current date with time set to midnight
  DateTime currentDate = DateTime.now();
  currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

  // Filter tasks where the duration is 'Day' and the date is the current date
  List<Workoutmodel> dayTasks = tasks.where((task) {
    DateTime taskDate = task.date;
    taskDate = DateTime(taskDate.year, taskDate.month, taskDate.day);
    return task.duration == 'Day' && taskDate.isAtSameMomentAs(currentDate);
  }).toList();

  // Return the count of 'Day' tasks for the current date
  return dayTasks.length;
}

// -----------------------------------------------------------------------------------------------------------------------------completed day-----------------------
int getDayTasksCountCpt() {
  // Get the list of tasks from the notifier
  List<Workoutmodel> tasks = workoutListNotifier.value;

  // Get the current date with time set to midnight
  DateTime currentDate = DateTime.now();
  currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

  // Filter tasks where the duration is 'Day', the date is the current date, and isChecked is true
  List<Workoutmodel> dayTasks = tasks.where((task) {
    DateTime taskDate = task.date;
    taskDate = DateTime(taskDate.year, taskDate.month, taskDate.day);
    return task.duration == 'Day' &&
        taskDate.isAtSameMomentAs(currentDate) &&
        task.isChecked;
  }).toList();

  // Return the count of 'Day' tasks for the current date
  return dayTasks.length;
}

// ---------------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------week all---------------
int getWeekTasksCountwk() {
  // Get the list of tasks from the notifier
  List<Workoutmodel> tasks = workoutListNotifier.value;

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the start and end dates of the current week (Monday to Sunday)
  DateTime startOfWeek = currentDate
      .subtract(Duration(days: currentDate.weekday - 1))
      .subtract(const Duration(days: 1));
  DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

  // Filter tasks where the duration is 'Week' or 'Day' and the task's date is within the current week
  List<Workoutmodel> weekAndDayTasks = tasks.where((task) {
    DateTime taskDate = task.date;
    bool isWithinWeek = taskDate.isAfter(startOfWeek) &&
        taskDate.isBefore(endOfWeek.add(const Duration(days: 1)));
    return (task.duration == 'Week' || task.duration == 'Day') && isWithinWeek;
  }).toList();

  // Print task date range and current week's date range

  // Return the count of 'Week' and 'Day' tasks for the current week
  return weekAndDayTasks.length;
}

// ---------------------------------------------------------------------------------------------------------------------
// -------------------------------------------week completed------------------------------------------------------
int getWeekTasksCountCheckeds() {
  // Get the list of tasks from the notifier
  List<Workoutmodel> tasks = workoutListNotifier.value;

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the start and end dates of the current week (Monday to Sunday)
  DateTime startOfWeek = currentDate
      .subtract(Duration(days: currentDate.weekday - 1))
      .subtract(const Duration(days: 1));
  DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

  // Filter tasks where the duration is 'Week' or 'Day', the task's date is within the current week, and isChecked is true
  List<Workoutmodel> weekTasks = tasks.where((task) {
    DateTime taskDate = task.date;
    bool isWithinWeek = taskDate.isAfter(startOfWeek) &&
        taskDate.isBefore(endOfWeek.add(const Duration(days: 1)));

    return (task.duration == 'Week' || task.duration == 'Day') &&
        isWithinWeek &&
        task.isChecked;
  }).toList();

  // Return the count of 'Week' or 'Day' tasks for the current week that are checked
  return weekTasks.length;
}

// ----------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------month all-----------------------------
int getMonthTasksCount() {
  // Get the list of tasks from the notifier
  List<Workoutmodel> tasks = workoutListNotifier.value;

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the start and end dates of the current month
  DateTime startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
  DateTime endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

// Subtract one day from startOfMonth
  startOfMonth = startOfMonth.subtract(const Duration(days: 1));

// Filter tasks where the duration is 'Week', 'Day', or 'Month',
// the task's date is within the current month, and isChecked is true
  List<Workoutmodel> monthAndDayTasks = tasks.where((task) {
    DateTime taskDate = task.date;
    return (task.duration == 'Week' ||
            task.duration == 'Day' ||
            task.duration == 'Month') &&
        taskDate.isAfter(startOfMonth) &&
        taskDate.isBefore(endOfMonth.add(const Duration(days: 1)));
  }).toList();
  // Return the count of 'Week' and 'Day' tasks for the current month
  return monthAndDayTasks.length;
}

// ------------------------------------------------------------------completed month----------------------
int getMonthTasksCountmonth() {
  // Get the list of tasks from the notifier
  List<Workoutmodel> tasks = workoutListNotifier.value;

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the start and end dates of the current month
  DateTime startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
  DateTime endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

  // Subtract one day from startOfMonth
  startOfMonth = startOfMonth.subtract(const Duration(days: 1));

  // Filter tasks where the duration is 'Week', 'Day', or 'Month',
  // the task's date is within the current month, and isChecked is true
  List<Workoutmodel> monthAndDayTasks = tasks.where((task) {
    DateTime taskDate = task.date;
    return (task.duration == 'Week' ||
            task.duration == 'Day' ||
            task.duration == 'Month') &&
        taskDate.isAfter(startOfMonth) &&
        taskDate.isBefore(endOfMonth.add(const Duration(days: 1))) &&
        task.isChecked;
  }).toList();

  return monthAndDayTasks.length;
}