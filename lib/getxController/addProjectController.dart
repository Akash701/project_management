import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../models/projectModel.dart';

class AddProjectController extends GetxController {
  TextEditingController projectName = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController progress = TextEditingController();
  var projectList = <ProjectModel>[].obs;
  late SharedPreferences sharedPreferences;
  @override
  void onInit() {
    GetSavedData();
    // TODO: implement onInit
    super.onInit();
  }

  void GetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonData =
        jsonDecode(sharedPreferences.getString('projectData')!);
    var project = ProjectModel.fromJson(jsonData);
    if (jsonData.isNotEmpty) {
      projectList.assign(project);
    }
  }
}
