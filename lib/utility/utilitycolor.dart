import 'package:flutter/material.dart';
import 'package:fitfolio/helpers/appcolors..dart';

import '../view/sub_screens_wtd/other_sub/login.dart';
Color getBackgroundColor(bool isChecked, String duration, DateTime date) {
  final now = DateTime.now();
  final diff = date.difference(now).inDays;

  if (isChecked) {
    return colors.greenscompleted; // Change color to green when checkbox is checked
  }
    if (duration == 'Day') {
    if (date.isBefore(now.add(const Duration(days: 100000))) &&
        date.isAfter(now.subtract(const Duration(days: 1)))) {
      return colors.defaultask; // Change color for workouts within a day (including today)
    }
    return colors.redincompleted; // Change color for future workouts within a day
  } 
   else if (duration == 'Week') {
    if (diff >= 0 && diff <= 6) {
      return colors.defaultask; // Change color for workouts within a week (excluding today)
    } else if (date.isBefore(now.add(const Duration(days: 7))) &&
               date.isAfter(now)) {
      return colors.redincompleted; // Change color for workouts within the next 7 days, excluding today
    } else if (date.add(const Duration(days: 7)).isBefore(now)) {
      return colors.redincompleted; // Change color for workouts within a week (including today)
    } else if (date.add(const Duration(days: 7)).isAfter(now)) {
      // ignore: prefer_const_constructors
      return Color.fromARGB(255, 207, 198, 198); // Change color for workouts beyond a week
    }
  } else if (duration == 'Month') {
    if (date.add(const Duration(days: 30)).isBefore(now)) {
      return colors.redincompleted; // Change color for workouts within a month (including today)
    }
    if (diff >= 0 && diff <= 30) {
      return diff == 0 ?colors.defaultask: colors.defaultask; // Change color for workouts within a month
    }
  }
  return colors.defaultask; // Default color
}
  void toLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }



