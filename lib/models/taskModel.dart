import 'package:hive/hive.dart';
part 'taskModel.g.dart';

@HiveType(typeId: 2)
class TaskModel {
  @HiveField(9)
  final String? taskName;
  @HiveField(10)
  final String? startDate;
  @HiveField(11)
  final String? endDate;
  @HiveField(12)
  final String? progress;

  TaskModel({this.taskName, this.startDate, this.endDate, this.progress});
}
