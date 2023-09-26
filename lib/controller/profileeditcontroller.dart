import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profileeditprovider with ChangeNotifier {

final formKey = GlobalKey<FormState>();
  final personnamecontroller = TextEditingController();
  final wpersonageController = TextEditingController();
  final personweightController = TextEditingController();
  final personheightController = TextEditingController();
  final imageController = TextEditingController();

   String? _profileImagePath;

  String? get profileImagePath => _profileImagePath;

  Future<void> loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    _profileImagePath = imagePath;
    notifyListeners(); // Notify listeners after updating the data
  }
    String? validateTextField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }


}