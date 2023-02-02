import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_manager/getxController/addProjectController.dart';
import 'package:project_manager/models/projectModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Common/CommonStyles.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  AddProjectController addProjectController = Get.put(AddProjectController());
  // TextEditingController projectName = TextEditingController();
  // TextEditingController teamName = TextEditingController();
  // TextEditingController description = TextEditingController();
  // TextEditingController progress = TextEditingController();

  late SharedPreferences sharedPreferences;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   super.initState();
  //   GetSavedData();
  // }
  //
  // void GetSavedData() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   Map<String, dynamic> jsonData =
  //       jsonDecode(sharedPreferences.getString('projectData')!);
  //   var project = ProjectModel.fromJson(jsonData);
  //   if (jsonData.isNotEmpty) {}
  // }

  void savedData() {
    ProjectModel projectModel = ProjectModel(
        addProjectController.projectName.text,
        addProjectController.description.text,
        addProjectController.teamName.text,
        addProjectController.progress.text);
    String projectData = jsonEncode(projectModel);
    sharedPreferences.setString('projectData', projectData);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: addProjectController.projectName,
              decoration: CommonStyles.textFieldStyle(
                  labelTextStr: "Project Name", content: EdgeInsets.all(12)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: addProjectController.teamName,
              decoration: CommonStyles.textFieldStyle(
                  labelTextStr: "Team", content: EdgeInsets.all(12)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: addProjectController.progress,
              decoration: CommonStyles.textFieldStyle(
                  labelTextStr: "Progress", content: EdgeInsets.all(12)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: addProjectController.description,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: CommonStyles.textFieldStyle(
                labelTextStr: "Description",
                content: EdgeInsets.symmetric(vertical: 40, horizontal: 10.0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                savedData();
              },
              child: Text('Save and Submmit'),
            )
          ],
        ),
      ),
    );
  }
}
