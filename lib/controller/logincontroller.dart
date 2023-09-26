import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../bottom_main.dart';
import '../services/db_person.dart';
import '../model/person_model/persondata.dart';
class PersonProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final personheightController = TextEditingController();
  final personweightController = TextEditingController();
  final personageController = TextEditingController();



  String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future<void> onAddTaskButtonPressed(BuildContext context) async {
   final persondb= Provider.of<PersonDataProvider>(context,listen: false);
    final personname = nameController.text.trim();
    final personheight = personheightController.text.trim();
    final personweight = personweightController.text.trim();
    final personage = personageController.text.trim();

    if (personname.isEmpty ||
        personage.isEmpty ||
        personheight.isEmpty ||
        personweight.isEmpty) {
      return;
    }

    final task = persondata(
      personname: personname,
      personage: personage,
      personweight: personweight,
      personheight: personheight,
      
    );

   await persondb.addPerson(task) ;// Assuming addperson is an asynchronous function
   try {
    
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const ScreeenHome()),
    
  );
  print('$personage,$personname');
} catch (e) {
  print('Error during navigation: $e');
}}}