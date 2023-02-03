import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/projectModel.dart';

class AddProjectController extends GetxController {
  TextEditingController projectName = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController progress = TextEditingController();
  var projectList = <ProjectModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
