import 'package:flutter/material.dart';

class color {
  static Color primaryColor = Colors.cyan;
  static Color hintColor = Colors.red;
  static Color textColor = Colors.red;
  static Color btnTextColor = Colors.white;

  static Color darkAppBar = Colors.grey;
  static Color darkCard = Colors.grey;
  static Color darkBackground = Colors.black87;
  static Color testCircleColor = Colors.black54;
  static Color darkText = Colors.white;
  static Color lightText = Colors.black87;

  static String accountCardColor = '#e9f7f5';
  static Color colorConvert(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      return Color(int.parse("0x" + color));
    }
  }
}
