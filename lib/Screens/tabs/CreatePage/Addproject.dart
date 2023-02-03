import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_manager/getxController/addProjectController.dart';
import 'package:project_manager/models/projectModel.dart';

import '../../../Common/CommonStyles.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  AddProjectController addProjectController = Get.put(AddProjectController());

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
                Get.back();
              },
              child: Text('Save and Submmit'),
            )
          ],
        ),
      ),
    );
  }
}
