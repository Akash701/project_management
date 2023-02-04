import 'package:hive/hive.dart';
part 'memberModel.g.dart';

@HiveType(typeId: 1)
class MemberModel {
  @HiveField(3)
  final String? memberName;
  @HiveField(4)
  final String? email;
  @HiveField(5)
  final String? dob;
  @HiveField(6)
  final String? designation;
  @HiveField(7)
  final String? gender;
  @HiveField(8)
  final String? skill;

  MemberModel(
      {this.memberName,
      this.email,
      this.dob,
      this.designation,
      this.gender,
      this.skill});
}
