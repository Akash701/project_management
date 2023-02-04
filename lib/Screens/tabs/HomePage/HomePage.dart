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
  List _items = [];
  Future<void> homeJsonData() async {
    final String response = await rootBundle.loadString('assets/projects.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      homeJsonData();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddProjectController>(
          builder: (cont) => ListView.separated(
                itemCount: cont.projectsCount,
                itemBuilder: (context, index) {
                  if (cont.projectsCount > 0) {
                    ProjectModel? projectModel =
                        cont.observableBox.getAt(index);
                    return Card(
                      child: ListTile(
                        title: Text("${projectModel?.projectName}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${projectModel?.teamName}"),
                            Text("${projectModel?.description}"),
                          ],
                        ),
                        leading: IconButton(
                            onPressed: () => addEditProject(
                                index: index, projectModel: projectModel),
                            icon: const Icon(Icons.edit)),
                        trailing: IconButton(
                            onPressed: () => cont.deleteProject(index: index),
                            icon: const Icon(Icons.delete)),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("List is Empty"),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.green,
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  );
                },
              )),
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
