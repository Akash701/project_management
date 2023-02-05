import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_manager/getxController/addTaskController.dart';
import '../../../Common/Utils.dart';
import '../../../models/taskModel.dart';
import '../../../widgets/title_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskDetails extends StatefulWidget {
  int index;
  TaskDetails(this.index);
  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  AddTaskController addTaskController = Get.put(AddTaskController());
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEditTask();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Project Details"),
      ),
      body: GetBuilder<AddTaskController>(
          builder: (cont) => ListView.separated(
              itemCount: cont.taskCount,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.green,
                  thickness: 2,
                  indent: 50,
                  endIndent: 50,
                );
              },
              itemBuilder: (context, index) {
                if (cont.taskCount > 0) {
                  TaskModel? taskModel =
                      addTaskController.taskObservableBox.getAt(index);
                  return Card(
                    child: ListTile(
                      title: Text('${taskModel?.taskName}'),
                      subtitle: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('Start Date'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("${taskModel?.startDate}"),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Text('End Date'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("${taskModel?.endDate}"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[300],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                ),
                                onPressed: () {
                                  addEditTask(
                                      index: index, taskModel: taskModel);
                                },
                                child: Text('Edit'),
                              ),
                              TextButton(
                                onPressed: () {
                                  cont.deleteTask(index: index);
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      leading: CircularPercentIndicator(
                        radius: 27.0,
                        lineWidth: 5.0,
                        percent:
                            addTaskController.slider.value.toDouble() / 100,
                        center: Text("${taskModel?.progress}%"),
                        progressColor: Colors.green,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Please insert Task Details"),
                  );
                }
              })),
    );
  }

  addEditTask({
    int? index,
    TaskModel? taskModel,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          if (taskModel != null) {
            addTaskController.taskName.text = taskModel.taskName.toString();
            addTaskController.endDate.text = taskModel.endDate.toString();
            addTaskController.startDate.text = taskModel.startDate.toString();
            addTaskController.progress.text = taskModel.progress.toString();
          } else {
            addTaskController.taskName.clear();
            addTaskController.endDate.clear();
            addTaskController.startDate.clear();
            addTaskController.progress.clear();
          }
          return Material(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: Utils().textInputDecoration(
                          'Task Name', "Enter the Task name"),
                      controller: addTaskController.taskName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: addTaskController.startDate,
                        decoration: Utils().textInputDecoration(
                            'Start Date', 'Enter the starting date'),
                        onTap: () async {
                          final initialDate = DateTime.now();
                          final firstDate = DateTime(1900);
                          final lastDate = DateTime.now();
                          final selectedDateOfBirth = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: firstDate,
                              lastDate: lastDate);
                          if (selectedDateOfBirth == null) {
                            Utils.showSnackBar(
                                context: context,
                                text: "Starting Date is not selected");
                          } else {
                            final formatedDateOfBirth = DateTime(
                                selectedDateOfBirth.year,
                                selectedDateOfBirth.month,
                                selectedDateOfBirth.day);

                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            addTaskController.startDate.text = formatter
                                .format(formatedDateOfBirth)
                                .toString();
                            Utils.showSnackBar(
                                context: context,
                                text:
                                    "Selected date is ${addTaskController.startDate.text}");
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "D.O.B Required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      decoration: Utils().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: TextFormField(
                        controller: addTaskController.endDate,
                        decoration: Utils().textInputDecoration(
                            'End Date', 'Enter the ending date'),
                        onTap: () async {
                          final initialDate = DateTime.now();
                          final firstDate = DateTime(1900);
                          final lastDate = DateTime.now();
                          final selectedDateOfBirth = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: firstDate,
                              lastDate: lastDate);
                          if (selectedDateOfBirth == null) {
                            Utils.showSnackBar(
                                context: context,
                                text: "Ending Date is not selected");
                          } else {
                            final formatedDateOfBirth = DateTime(
                                selectedDateOfBirth.year,
                                selectedDateOfBirth.month,
                                selectedDateOfBirth.day);

                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            addTaskController.endDate.text = formatter
                                .format(formatedDateOfBirth)
                                .toString();
                            Utils.showSnackBar(
                                context: context,
                                text:
                                    "Selected date is ${addTaskController.endDate.text}");
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "D.O.B Required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      decoration: Utils().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Color(0xFFFFFFFF),
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 15,
                          ),
                          overlayShape: RoundSliderOverlayShape(
                            overlayRadius: 30,
                          ),
                        ),
                        child: StatefulBuilder(builder: (context, state) {
                          return Column(
                            children: [
                              Text(
                                  'Progress: ${addTaskController.slider.value.toString()}%'),
                              Slider(
                                  value:
                                      addTaskController.slider.value.toDouble(),
                                  min: 0,
                                  max: 100,
                                  //activeColor: Color(0xFFEB1555),
                                  inactiveColor: Color(0xFF8D8F98),
                                  onChanged: (newValue) {
                                    state(() {
                                      addTaskController.slider.value =
                                          newValue.round();
                                    });
                                  }),
                            ],
                          );
                        })),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bool? isValidated = formKey.currentState?.validate();
                          if (isValidated == true) {
                            String taskText = addTaskController.taskName.text;
                            String startText = addTaskController.startDate.text;
                            String endText = addTaskController.endDate.text;
                            String progressText =
                                addTaskController.slider.toString();

                            if (index != null) {
                              addTaskController.updateTask(
                                index: index,
                                taskModel: TaskModel(
                                  taskName: taskText,
                                  startDate: startText,
                                  endDate: endText,
                                  progress: progressText,
                                ),
                              );
                            } else {
                              addTaskController.createTask(
                                  taskModel: TaskModel(
                                      taskName: taskText,
                                      startDate: startText,
                                      endDate: endText,
                                      progress: progressText));
                            }
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter valid values")));
                          }
                        },
                        child: const Text("Save and Submit"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
