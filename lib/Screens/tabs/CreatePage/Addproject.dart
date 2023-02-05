// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:project_manager/getxController/addProjectController.dart';
// import 'package:project_manager/models/projectModel.dart';
//
// import '../../../Common/CommonStyles.dart';
//
// class AddProject extends StatefulWidget {
//   final int? index;
//   final ProjectModel? projectModel;
//   AddProject({this.projectModel, this.index});
//
//   @override
//   State<AddProject> createState() => _AddProjectState();
// }
//
// class _AddProjectState extends State<AddProject> {
//   AddProjectController addProjectController = Get.put(AddProjectController());
//   // TextEditingController projectName = TextEditingController();
//   // TextEditingController teamName = TextEditingController();
//   // TextEditingController description = TextEditingController();
//
//   final formKey = GlobalKey<FormState>();
//
//   // @override
//   // void dispose() {
//   //   addProjectController.projectName.dispose();
//   //   addProjectController.teamName.dispose();
//   //   addProjectController.description.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 18, right: 18),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               controller: addProjectController.projectName,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the project name';
//                 }
//                 return null;
//               },
//               decoration: CommonStyles.textFieldStyle(
//                   labelTextStr: "Project Name", content: EdgeInsets.all(12)),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: addProjectController.teamName,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter team name';
//                 }
//                 return null;
//               },
//               decoration: CommonStyles.textFieldStyle(
//                   labelTextStr: "Team", content: EdgeInsets.all(12)),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             // TextFormField(
//             //   controller: progress,
//             //   decoration: CommonStyles.textFieldStyle(
//             //       labelTextStr: "Progress", content: EdgeInsets.all(12)),
//             // ),
//             // SizedBox(
//             //   height: 20,
//             // ),
//             TextFormField(
//               controller: addProjectController.description,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter the description';
//                 }
//                 return null;
//               },
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//               decoration: CommonStyles.textFieldStyle(
//                 labelTextStr: "Description",
//                 content: EdgeInsets.symmetric(vertical: 40, horizontal: 10.0),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 bool? isValidated = formKey.currentState?.validate();
//                 if (isValidated == true) {
//                   String projectText = addProjectController.projectName.text;
//                   String descriptionText =
//                       addProjectController.description.text;
//                   String teamText = addProjectController.teamName.text;
//                   if (widget.index != null) {
//                     addProjectController.updateProject(
//                         index: widget.index!,
//                         projectModel: ProjectModel(
//                             teamName: teamText,
//                             projectName: projectText,
//                             description: descriptionText));
//                   } else {
//                     addProjectController.createProject(
//                         projectModel: ProjectModel(
//                             teamName: teamText,
//                             projectName: projectText,
//                             description: descriptionText));
//                   }
//                   Navigator.pop(context);
//                 } else {
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Enter valid values")));
//                 }
//               },
//               child: const Text("Save and Submit"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
