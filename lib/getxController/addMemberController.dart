import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:project_manager/models/memberModel.dart';
import 'package:project_manager/repository/memberBox_repository.dart';

class AddMemberController extends GetxController {
  TextEditingController memberName = TextEditingController();
  TextEditingController memberEmail = TextEditingController();
  TextEditingController memberDob = TextEditingController();
  TextEditingController memberDesignation = TextEditingController();
  TextEditingController memberSkills = TextEditingController();
  TextEditingController memberGender = TextEditingController();

  List<String> items = ['male', 'female', 'other'].obs;
  RxString dropdownvalue = 'male'.obs;
  List<String> skills = ['Flutter', "Github", "firebase", 'Python'].obs;
  RxString skillvalue = 'Flutter'.obs;

  @override
  void dispose() {
    memberName.dispose();
    memberEmail.dispose();
    memberDob.dispose();
    memberDesignation.dispose();
    memberSkills.dispose();
    memberGender.dispose();
    super.dispose();
  }

  final Box _memberObservableBox = MemberBox.getMemberBox();

  Box get memberObservableBox => _memberObservableBox;

  int get memberCount => _memberObservableBox.length;

  createMember({required MemberModel memberModel}) {
    _memberObservableBox.add(memberModel);
    update();
  }

  updateMember({required int index, required MemberModel memberModel}) {
    _memberObservableBox.putAt(index, memberModel);
    update();
  }

  deleteProject({required int index}) {
    _memberObservableBox.deleteAt(index);

    update();
  }
}
