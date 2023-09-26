import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fitfolio/helpers/appcolors..dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../controller/taskaddcontroller.dart';

class Textng extends StatelessWidget {
  const Textng({super.key});

  @override
  Widget build(BuildContext context) {
    final addtask = Provider.of<Taskaddingprovider>(context);
    addtask.dropdownController.text = addtask.selectedValue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primarytheme,
        title: const Text('addTask'),
      ),
      body: AlertDialog(
        backgroundColor: colors.secondarytheme,
        content: SizedBox(
          height: double.infinity,
          child: Form(
            key: addtask.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: addtask.typenameController,
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
                    validator: addtask.validateTextField,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: addtask.weightController,
                    maxLength: 3,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
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
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: addtask.repsController,
                    maxLength: 3,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
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
                    validator: addtask.validateTextField,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: addtask.setsController,
                    maxLength: 3,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
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
                    validator: addtask.validateTextField,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: addtask.dateController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'DATE',
                      prefixIcon: const Icon(Icons.calendar_today),
                      filled: true,
                      fillColor: colors.whitetheme,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      addtask.selectDate(context);
                    },
                    validator: addtask.validateTextField,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            elevation: 10,
                            value:
                                addtask.selectedValue, // Current selected value
                            onChanged: (newValue) {
                              // Update the selected value using the provider
                              addtask.updateSelectedValue(newValue!);
                            },
                            items: ['Day', 'Week', 'Month']
                                .map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              addtask.onAddTaskButtonPressed(context);
              addtask.typenameController.clear();
              addtask.weightController.clear();
              addtask.dateController.clear();
              addtask.setsController.clear();
              addtask.repsController.clear();
              addtask.dropdownController.clear();
            },
            color: Colors.white,
            child: const Text('ADD'),
          )
        ],
      ),
    );
  }
}
