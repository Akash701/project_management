import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 0)
class ProjectModel {
  @HiveField(0)
  final String? projectName;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? team;
  ProjectModel({this.projectName, this.description, this.team});
}
