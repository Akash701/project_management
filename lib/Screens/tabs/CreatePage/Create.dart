import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/Screens/tabs/CreatePage/Addproject.dart';
import '../../../getxController/addProjectController.dart';
import '../../../widgets/floatingAction.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  AddProjectController addProjectController = Get.put(AddProjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingAction(
        project: () {
          Get.defaultDialog(title: "Add Project", content: AddProject());
        },
        member: () {},
      ),
      body: Column(
        children: [
          Obx(() {
            if (addProjectController.projectList.isEmpty) {
              return Text('Project needs to be added');
            } else {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(addProjectController
                            .projectList[index].projectName),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox();
                  },
                  itemCount: addProjectController.projectList.length);
            }
          })
        ],
      ),
    );
  }
}
