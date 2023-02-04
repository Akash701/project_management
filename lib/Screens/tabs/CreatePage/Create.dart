import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manager/Common/Utils.dart';
import 'package:project_manager/Screens/tabs/CreatePage/Addproject.dart';
import 'package:project_manager/getxController/addMemberController.dart';
import 'package:project_manager/models/projectModel.dart';
import '../../../getxController/addProjectController.dart';
import '../../../models/memberModel.dart';
import '../../../widgets/floatingAction.dart';
import 'package:intl/intl.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  AddProjectController addProjectController = Get.put(AddProjectController());
  AddMemberController addMemberController = Get.put(AddMemberController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingAction(
        project: () {
          addEditProject();
          // Get.defaultDialog(title: "Add Project", content: AddProject());
        },
        member: () {
          addEditMember();
        },
      ),
      body: GetBuilder<AddMemberController>(
          builder: (cont) => ListView.separated(
                itemCount: cont.memberCount,
                itemBuilder: (context, index) {
                  if (cont.memberCount > 0) {
                    MemberModel? memberModel =
                        cont.memberObservableBox.getAt(index);
                    return Card(
                      child: ListTile(
                        title: Text("${memberModel?.memberName}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${memberModel?.gender}"),
                            Text("${memberModel?.designation}"),
                          ],
                        ),
                        leading: IconButton(
                            onPressed: () => addEditMember(
                                index: index, memberModel: memberModel),
                            icon: const Icon(Icons.edit)),
                        trailing: IconButton(
                            onPressed: () => cont.deleteProject(index: index),
                            icon: const Icon(Icons.delete)),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("List is Empty"),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.green,
                    thickness: 2,
                    indent: 50,
                    endIndent: 50,
                  );
                },
              )),
    );
  }

  addEditProject({
    int? index,
    ProjectModel? projectModel,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          if (projectModel != null) {
            addProjectController.teamName.text =
                projectModel.teamName.toString();
            addProjectController.projectName.text =
                projectModel.projectName.toString();
            addProjectController.description.text =
                projectModel.description.toString();
          } else {
            addProjectController.teamName.clear();
            addProjectController.projectName.clear();
            addProjectController.description.clear();
          }
          return Material(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(hintText: "Project"),
                      controller: addProjectController.projectName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: "team name"),
                      controller: addProjectController.teamName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      controller: addProjectController.description,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bool? isValidated = formKey.currentState?.validate();
                          if (isValidated == true) {
                            String projectText =
                                addProjectController.projectName.text;
                            String descriptionText =
                                addProjectController.description.text;
                            String teamText =
                                addProjectController.teamName.text;

                            if (index != null) {
                              addProjectController.updateProject(
                                  index: index,
                                  projectModel: ProjectModel(
                                      projectName: projectText,
                                      description: descriptionText,
                                      teamName: teamText));
                            } else {
                              addProjectController.createProject(
                                  projectModel: ProjectModel(
                                      projectName: projectText,
                                      description: descriptionText,
                                      teamName: teamText));
                            }
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Enter valid values")));
                          }
                        },
                        child: const Text("Save and Submit"))
                  ],
                ),
              ),
            ),
          );
        });
  }

  addEditMember({
    int? index,
    MemberModel? memberModel,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          if (memberModel != null) {
            addMemberController.memberName.text =
                memberModel.memberName.toString();
            addMemberController.memberEmail.text = memberModel.email.toString();
            addMemberController.memberDob.text = memberModel.dob.toString();
            addMemberController.memberDesignation.text =
                memberModel.designation.toString();
            // addMemberController.memberSkills.text =
            //     memberModel.skill.toString();
            // addMemberController.dropdownvalue.value.toString();
            // addMemberController.memberGender.text =
            //     memberModel.gender.toString();
          } else {
            addMemberController.memberName.clear();
            addMemberController.memberEmail.clear();
            addMemberController.memberDob.clear();
            addMemberController.memberDesignation.clear();
            // addMemberController.memberSkills.clear();
            // addMemberController.memberGender.clear();
          }
          return Material(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: Utils().textInputDecoration(
                          'Member Name', "Enter the Member name"),
                      controller: addMemberController.memberName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: addMemberController.memberEmail,
                        decoration: Utils()
                            .textInputDecoration('Email', "Enter your email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if ((val!.isEmpty) &&
                              RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      decoration: Utils().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: addMemberController.memberDob,
                        decoration: Utils().textInputDecoration(
                            'DOB', 'Enter your Date of Birth'),
                        onTap: () async {
                          final initialDate = DateTime.now();
                          final firstDate = DateTime(1900);
                          final lastDate = DateTime.now();
                          final selectedDateOfBirth = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: firstDate,
                              lastDate: lastDate);
                          if (selectedDateOfBirth == null) {
                            Utils.showSnackBar(
                                context: context, text: "DOB is not selected");
                          } else {
                            final formatedDateOfBirth = DateTime(
                                selectedDateOfBirth.year,
                                selectedDateOfBirth.month,
                                selectedDateOfBirth.day);

                            final DateFormat formatter =
                                DateFormat('yyyy-MM-dd');
                            addMemberController.memberDob.text = formatter
                                .format(formatedDateOfBirth)
                                .toString();
                            Utils.showSnackBar(
                                context: context,
                                text:
                                    "Selected DOB is ${addMemberController.memberDob.text}");
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "D.O.B Required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      decoration: Utils().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: Utils().textInputDecoration(
                          'Designation', "Enter the Designation name"),
                      controller: addMemberController.memberDesignation,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: Utils().inputBoxDecorationShaddow(),
                      child: DropdownButtonFormField<String>(
                        decoration: Utils().textInputDecoration(
                            'gender'.tr, 'Enter your Gender'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your Gender";
                          }
                          return null;
                        },
                        // Initial Value
                        value: addMemberController.dropdownvalue.value,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: addMemberController.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          addMemberController.dropdownvalue.value = newValue!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: Utils().textInputDecoration(
                          'Description', "Enter the Description"),
                      controller: addProjectController.description,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: Utils().inputBoxDecorationShaddow(),
                      child: DropdownButtonFormField<String>(
                        decoration: Utils()
                            .textInputDecoration('Skills', 'Enter your Skill'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter your Skill";
                          }
                          return null;
                        },
                        // Initial Value
                        value: addMemberController.skillvalue.value,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: addMemberController.skills.map((String skills) {
                          return DropdownMenuItem(
                            value: skills,
                            child: Text(skills),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          addMemberController.skillvalue.value = newValue!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          bool? isValidated = formKey.currentState?.validate();
                          if (isValidated == true) {
                            String memberText =
                                addMemberController.memberName.text;
                            String emailText =
                                addMemberController.memberEmail.text;
                            String dobText = addMemberController.memberDob.text;
                            String designationText =
                                addMemberController.memberDesignation.text;
                            String skillText =
                                addMemberController.skillvalue.value.toString();
                            String genderText = addMemberController
                                .dropdownvalue.value
                                .toString();

                            if (index != null) {
                              addMemberController.updateMember(
                                  index: index,
                                  memberModel: MemberModel(
                                      memberName: memberText,
                                      email: emailText,
                                      dob: dobText,
                                      designation: designationText,
                                      skill: skillText,
                                      gender: genderText));
                            } else {
                              addMemberController.createMember(
                                  memberModel: MemberModel(
                                      memberName: memberText,
                                      email: emailText,
                                      dob: dobText,
                                      designation: designationText,
                                      skill: skillText,
                                      gender: genderText));
                            }
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Enter valid values"),
                            ));
                          }
                        },
                        child: const Text("Save and Submit"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
