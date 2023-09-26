import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskEditProvider extends ChangeNotifier {
  //   final String typename;
  // final String weight;
  // final String sets;
  // final String reps;
  // final int index;
  // final DateTime date;
  // final String duration;
  // final bool isChecked;

  // TaskEditProvider({
  //   Key? key,
  //   required this.typename,
  //   required this.weight,
  //   required this.sets,
  //   required this.index,
  //   required this.date,
  //   required this.duration,
  //   required this.reps,
  //   required this.isChecked,
  // }) ;
  final TextEditingController typenameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  
  String? selectedValue;

  void updateSelectedValue(String value) {
    selectedValue = value;
    notifyListeners();
  }
  // You can add more controllers for other fields as needed.

  void dispose() {
    typenameController.dispose();
    weightController.dispose();
    setsController.dispose();
    repsController.dispose();
    durationController.dispose();
    super.dispose();
  }
  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
    Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners(); // Notify listeners after updating the data
    }
  }
  
  
}
