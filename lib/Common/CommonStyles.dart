import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonStyles {
  static errorTextStyleStyle() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 13,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w400,
    ));
  }

  static floatingButtonStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0);
  }

  static InputDecoration textFieldStyle(
      {String labelTextStr = "",
      String hintTextStr = "",
      required EdgeInsetsGeometry content}) {
    return InputDecoration(
      contentPadding: content,
      labelText: labelTextStr,
      hintText: hintTextStr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static textDataWhite14() {
    return GoogleFonts.montserrat(
        textStyle: const TextStyle(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ));
  }
}
