import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
 File? selectedImage;

  Future<void> loadStoredImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      selectedImage = File(imagePath);
      notifyListeners(); // Notify listeners that the selected image has changed
    }
  }

  Future<void> pickImageAndStore() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        notifyListeners(); // Notify listeners that the selected image has changed

        // Store the image path in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('profile_image', pickedImage.path);
      }
    } catch (e) {
      // Handle any exceptions here
      print('Error picking image: $e');
    }
  }
}