import 'package:hive/hive.dart';
import 'package:project_manager/models/memberModel.dart';

class MemberBox {
  static const String memberBox = "MEMBER";

  static openMemberBox() async => await Hive.openBox<MemberModel>(memberBox);

  static Box getMemberBox() => Hive.box<MemberModel>(memberBox);

  static closeMemberBox() async => await Hive.box(memberBox).close();
}
