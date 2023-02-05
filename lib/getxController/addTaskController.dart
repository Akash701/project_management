import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_manager/models/taskModel.dart';
import 'package:project_manager/repository/taskBox_repository.dart';

class AddTaskController extends GetxController {
  TextEditingController taskName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  // TextEditingController progress = TextEditingController();
  RxInt slider = 10.obs;

  @override
  void dispose() {
    taskName.dispose();
    startDate.dispose();
    endDate.dispose();
    // progress.dispose();
    super.dispose();
  }

  final Box _taskObservableBox = TaskBox.getTaskBox();

  Box get taskObservableBox => _taskObservableBox;

  int get taskCount => _taskObservableBox.length;

  createTask({required TaskModel taskModel}) {
    _taskObservableBox.add(taskModel);
    update();
  }

  updateTask({required int index, required TaskModel taskModel}) {
    _taskObservableBox.putAt(index, taskModel);
    update();
  }

  deleteTask({required int index}) {
    _taskObservableBox.deleteAt(index);

    update();
  }
}
