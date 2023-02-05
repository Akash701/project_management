import 'package:hive/hive.dart';
import 'package:project_manager/models/taskModel.dart';

class TaskBox {
  static const String taskBox = 'TASK';

  static openTaskBox() async => await Hive.openBox<TaskModel>(taskBox);

  static Box getTaskBox() => Hive.box<TaskModel>(taskBox);

  static closeTaskBox() async => await Hive.box(taskBox).close();
}
