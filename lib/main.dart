import 'package:fitfolio/controller/mainpagecontrolller.dart';
import 'package:fitfolio/view/sub_screens_wtd/other_sub/splace.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controller/chartcontroller.dart';
import 'controller/logincontroller.dart';
import 'controller/profiledrawer.dart';
import 'controller/profileeditcontroller.dart';
import 'controller/taskaddcontroller.dart';
import 'controller/taskupdatecontroller.dart';
import 'controller/taskviewcontroller.dart';
import 'services/db_functions.dart';
import 'services/db_person.dart';
import 'model/person_model/persondata.dart';
import 'model/task_model/workoutmodel1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(WorkoutmodelAdapter().typeId)) {
    Hive.registerAdapter(WorkoutmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(persondataAdapter().typeId)) {
    Hive.registerAdapter(persondataAdapter());
  }
   await Hive.openBox<Workoutmodel>('workout_db');
   await Hive.openBox<persondata>('person_db');
   await getAllTasks();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => PersonProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => Taskaddingprovider()),
        ChangeNotifierProvider(create: (context) =>Profileeditprovider()),
        ChangeNotifierProvider(create: (context) =>Taskviewprovider()),
        ChangeNotifierProvider(create: (context) =>TaskEditProvider()),
        ChangeNotifierProvider(create: (context) =>ChartData()),
        ChangeNotifierProvider(create: (context) =>PersonDataProvider()),
        ChangeNotifierProvider(create: (context) =>ProfileImageProvider()),

    
    ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        
        home:SplaceScreen(),    
        title: 'Flutter Demo',
      ),
    );
  }
}
//8086