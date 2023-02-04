import 'package:hive_flutter/adapters.dart';
part 'projectModel.g.dart';

@HiveType(typeId: 0)
class ProjectModel {
  @HiveField(0)
  final String? projectName;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String? teamName;
  ProjectModel({this.projectName, this.description, this.teamName});
}
