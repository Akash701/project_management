import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/projectModel.dart';
import '../repository/box_repository.dart';

class AddProjectController extends GetxController {
  TextEditingController projectName = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController progress = TextEditingController();

  // var projectList = <ProjectModel>[].obs;
  @override
  void dispose() {
    projectName.dispose();
    teamName.dispose();
    description.dispose();
    super.dispose();
  }

  final Box _observableBox = BoxRepository.getBox();

  Box get observableBox => _observableBox;

  int get projectsCount => _observableBox.length;

  createProject({required ProjectModel projectModel}) {
    _observableBox.add(projectModel);
    update();
  }

  updateProject({required int index, required ProjectModel projectModel}) {
    _observableBox.putAt(index, projectModel);
    update();
  }

  deleteProject({required int index}) {
    _observableBox.deleteAt(index);

    update();
  }
}
