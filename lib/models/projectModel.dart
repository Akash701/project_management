class ProjectModel {
  final String projectName;
  final String teamName;
  final String description;
  final String progress;

  ProjectModel(
      this.projectName, this.teamName, this.description, this.progress);

  //constructor that convert json to object instance
  ProjectModel.fromJson(Map<String, dynamic> json)
      : projectName = json['projectNmae'],
        teamName = json['teamName'],
        description = json['description'],
        progress = json['progress'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'name': projectName,
        'email': teamName,
        'phone': description,
        'progress': progress
      };
}
