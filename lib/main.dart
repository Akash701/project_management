import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_manager/Screens/login_screen.dart';
import 'package:project_manager/repository/box_repository.dart';
import 'package:project_manager/repository/memberBox_repository.dart';
import 'package:project_manager/repository/taskBox_repository.dart';

import 'models/memberModel.dart';
import 'models/projectModel.dart';
import 'models/taskModel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProjectModelAdapter());
  Hive.registerAdapter(MemberModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  await BoxRepository.openBox();
  await MemberBox.openMemberBox();
  await TaskBox.openTaskBox();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
    );
  }
}
