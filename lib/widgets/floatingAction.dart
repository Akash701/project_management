import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project_manager/Common/CommonStyles.dart';

class FloatingAction extends StatelessWidget {
  final VoidCallback project;
  final VoidCallback member;
  const FloatingAction({required this.project, required this.member});
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: Icon(
              Icons.assignment_turned_in,
              color: Colors.white70,
            ),
            backgroundColor: Color(0xFF801E48),
            onTap: project,
            label: 'Project +',
            labelStyle: CommonStyles.floatingButtonStyle(),
            labelBackgroundColor: Color(0xFF801E48)),
        // FAB 2
        SpeedDialChild(
            child: Icon(
              Icons.person,
              color: Colors.white70,
            ),
            backgroundColor: Color(0xFF801E48),
            onTap: member,
            label: 'Member +',
            labelStyle: CommonStyles.floatingButtonStyle(),
            labelBackgroundColor: Color(0xFF801E48))
      ],
    );
  }
}
