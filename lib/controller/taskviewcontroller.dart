import 'package:flutter/material.dart';

import '../services/db_functions.dart';
import '../model/task_model/workoutmodel1.dart';

class Taskviewprovider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<Workoutmodel> filteredTasks = [];
  bool isSearching = false;

  Taskviewprovider() {
    searchController.addListener(onSearchChanged);
  }

  void onSearchChanged() {
    if (searchController.text.isEmpty) {
      isSearching = false;
      filteredTasks.clear();
    } else {
      isSearching = true;
      filteredTasks = workoutListNotifier.value
          .where((task) =>
              task.typename.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    isSearching = false;
    filteredTasks.clear();
    notifyListeners();
  }
 void updateTaskCompletion(int index, bool newValue) {
    if (index < workoutListNotifier.value.length) {
      workoutListNotifier.value[index].isChecked = newValue;
      notifyListeners();
    }
  }


}
