class ProjectModel {
  final String taskName;
  final String createdDate;
  final String endDate;
  final int progress;

  ProjectModel(this.taskName, this.createdDate, this.endDate, this.progress);

  //constructor that convert json to object instance
  ProjectModel.fromJson(Map<String, dynamic> json)
      : taskName = json['name'],
        createdDate = json['email'],
        endDate = json['phone'],
        progress = json['progress'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'name': taskName,
        'email': createdDate,
        'phone': endDate,
        'progress': progress
      };
}
