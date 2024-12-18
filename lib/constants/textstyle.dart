import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';


class MyTextThemes {
  static TextStyle textHeading = const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    decorationStyle: TextDecorationStyle.dashed
  );

  static TextStyle bodyTextStyle = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800
      //fontStyle: FontStyle.normal
  );

  static TextStyle levelTextStyle = TextStyle(
      fontSize: 12,
      color: MyColors.textColors,
      fontStyle: FontStyle.italic);
}