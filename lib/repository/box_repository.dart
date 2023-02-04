import 'package:hive/hive.dart';

import '../models/projectModel.dart';

class BoxRepository {
  static const String boxName = "PROJECT";

  static openBox() async => await Hive.openBox<ProjectModel>(boxName);

  static Box getBox() => Hive.box<ProjectModel>(boxName);

  static closeBox() async => await Hive.box(boxName).close();
}
