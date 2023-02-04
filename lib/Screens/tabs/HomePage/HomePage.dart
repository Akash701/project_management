import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../getxController/addProjectController.dart';
import '../../../models/projectModel.dart';
import '../CreatePage/Create.dart';
import 'TaskDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddProjectController addProjectController = Get.put(AddProjectController());
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddProjectController>(
        builder: (cont) => ListView.separated(
            itemCount: cont.projectsCount,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 15,
                ),
            itemBuilder: (context, index) {
              if (cont.projectsCount > 0) {
                ProjectModel? projectModel =
                    addProjectController.observableBox.getAt(index);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${projectModel?.projectName}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Team: ${projectModel?.teamName}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Text("${projectModel?.description}"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.task),
                                  Text(
                                    '3',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => addEditProject(
                                        index: index,
                                        projectModel: projectModel),
                                    child: Text('Update'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent,
                                    ),
                                    onPressed: () =>
                                        cont.deleteProject(index: index),
                                    child: Text("Delete"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("Please add a project"),
                );
              }
            }),
      ),
    );
  }

  addEditProject({
    int? index,
    ProjectModel? projectModel,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          if (projectModel != null) {
            addProjectController.teamName.text =
                projectModel.teamName.toString();
            addProjectController.projectName.text =
                projectModel.projectName.toString();
            addProjectController.description.text =
                projectModel.description.toString();
          } else {
            addProjectController.teamName.clear();
            addProjectController.projectName.clear();
            addProjectController.description.clear();
          }
          return Material(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Project"),
                      controller: addProjectController.projectName,
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
                    TextFormField(
                      decoration: const InputDecoration(hintText: "team name"),
                      controller: addProjectController.teamName,
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
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      controller: addProjectController.description,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bool? isValidated = formKey.currentState?.validate();
                          if (isValidated == true) {
                            String projectText =
                                addProjectController.projectName.text;
                            String descriptionText =
                                addProjectController.description.text;
                            String teamText =
                                addProjectController.teamName.text;

                            if (index != null) {
                              addProjectController.updateProject(
                                  index: index,
                                  projectModel: ProjectModel(
                                      projectName: projectText,
                                      description: descriptionText,
                                      teamName: teamText));
                            } else {
                              addProjectController.createProject(
                                  projectModel: ProjectModel(
                                      projectName: projectText,
                                      description: descriptionText,
                                      teamName: teamText));
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
