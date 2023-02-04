import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import '../Screens/tabs/CreatePage/Addproject.dart';
import 'CommonStyles.dart';

class Utils {
  static showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Please enter the correct credentials.',
          style: TextStyle(letterSpacing: 0.1, fontWeight: FontWeight.w500),
        ),
        content: Text(
          message,
          style: CommonStyles.errorTextStyleStyle(),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }
}
