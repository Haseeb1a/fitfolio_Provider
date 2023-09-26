import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fitfolio/helpers/appcolors..dart';

import '../../../controller/taskupdatecontroller.dart';
import '../../../services/db_functions.dart';
import '../../../model/task_model/workoutmodel1.dart';

class UpdateScreen extends StatefulWidget {
 

  final String typename;
  final String weight;
  final String sets;
  final String reps;
  final int index;
  final DateTime date;
  final String duration;
  final bool isChecked;

  const UpdateScreen({
    Key? key,
    required this.typename,
    required this.weight,
    required this.sets,
    required this.index,
    required this.date,
    required this.duration,
    required this.reps,
    required this.isChecked,
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
    // String? selectedValue; // Add this property

  @override
  void initState() {
    final edittask = Provider.of<TaskEditProvider>(context, listen: false);
    super.initState();
    edittask .selectedValue = widget.duration; // Initialize with the default value
  }

  @override
  Widget build(BuildContext context) {
    final edittask = Provider.of<TaskEditProvider>(context, listen: false);
    edittask.typenameController.text = widget.typename;
    edittask.weightController.text = widget.weight;
    edittask.setsController.text = widget.sets;
    edittask.repsController.text = widget.reps;
    edittask.dateController.text = DateFormat('yyyy-MM-dd').format(widget.date);
    // edittask.durationController.text = widget.duration;
    // final edittask = Provider.of<TaskEditProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: colors.primarytheme),
      body: AlertDialog(
        backgroundColor: colors.primarytheme,
        title: const Text('Update Task'),
        content: SizedBox(
          height: 380,
          child: SingleChildScrollView(
            child: Form(
              key: edittask.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: edittask.typenameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'TYPE NAME',
                      filled: true,
                      fillColor: colors.whitetheme,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: edittask.validateTextField,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: edittask.weightController,
                    maxLength: 3,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'KG',
                      filled: true,
                      fillColor: colors.whitetheme,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: edittask.validateTextField,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: edittask.setsController,
                    maxLength: 3,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'SETS',
                      filled: true,
                      fillColor: colors.whitetheme,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: edittask.validateTextField,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: edittask.repsController,
                    maxLength: 3,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'REPS',
                      filled: true,
                      fillColor: colors.whitetheme,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: edittask.validateTextField,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: edittask.dateController,
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.calendar_today),
                      fillColor: colors.whitetheme,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      edittask.selectDate(context); // Removed the extra semicolon
                    },
                    validator: edittask.validateTextField,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
Consumer<TaskEditProvider>(
  builder: (context, dropdownProvider, child) {
    return DropdownButton<String>(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsetsDirectional.all(3),
      borderRadius: BorderRadius.circular(15),
      value: dropdownProvider.selectedValue,
      items: <String>['Day', 'Week', 'Month']
          .map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          );
        },
      ).toList(),
      onChanged: (String? newValue) {
        dropdownProvider.updateSelectedValue(newValue!);
      },
    );
  },
),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              if (edittask.formKey.currentState!.validate()) {
                Workoutmodel studentmodel = Workoutmodel(
                  id: widget.index,
                  typename: edittask.typenameController.text,
                  weight: edittask.weightController.text,
                  sets: edittask.repsController.text,
                  reps: edittask.setsController.text,
                  date: DateTime.parse(edittask.dateController.text),
                  // duration: edittask.durationController.text,
                 duration: edittask.selectedValue!,
                );

                updateTask(widget.index, studentmodel);
                Navigator.pop(context);
              }
            },
            color: Colors.white,
            child: const Text('UPDATE'),
          )
        ],
      ),
    );
  }
}