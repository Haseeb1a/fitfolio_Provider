import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ValueNotifier<List<persondata>> persondataListNotifier = ValueNotifier([]);
// void addperson(persondata value) async {

//   final workoutDB = await Hive.openBox<persondata>('person_db');
//   final id = await workoutDB.add(value);
//   value.id = id;
//   getAllperson();
//  persondataListNotifier.value.add(value);
 

//   persondataListNotifier.notifyListeners();
// }
// Future<void> getAllperson() async {
//   final workoutDB = await Hive.openBox<persondata>('person_db');
//   persondataListNotifier.value.clear();
//   persondataListNotifier.value.addAll(workoutDB.values);
//   persondataListNotifier.notifyListeners();
// }
// Future<void> updateperson(int id,  value) async {
//   final studentsDB = await Hive.openBox<persondata>('person_db');
//   await studentsDB.putAt(id, value);
//   getAllperson() ;
// }
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../model/person_model/persondata.dart';

class PersonDataProvider extends ChangeNotifier {
  final Box<persondata> _personDataBox = Hive.box<persondata>('person_db');
  List<persondata> _personDataList = [];

  List<persondata> get personDataList => _personDataList;

  Future<void> addPerson(persondata value) async {
    final id = await _personDataBox.add(value);
    value.id = id;
    print('Added person with ID: $id'); 
    _updatePersonDataList();
  }  
  Future<void> updatePerson(int id, persondata value) async {
    await _personDataBox.putAt(id, value);
    _updatePersonDataList();
  }

  void _updatePersonDataList() {
    _personDataList = _personDataBox.values.toList();
    notifyListeners();
  }
}