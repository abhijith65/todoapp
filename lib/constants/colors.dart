import 'package:flutter/material.dart';

class MyColors {
  static Color basicColor = const Color(0xB52C940E);
  static Color textColors = const Color(0xFF0F2902);
  static Color textwhite = Colors.white;

  static Color high = Colors.redAccent.withOpacity(.6);
  static Color medium = Colors.orangeAccent.withOpacity(.6);
  static Color low = Colors.yellowAccent.withOpacity(.6);
  static Map<String, Color> lvlcolor={
    'low':low,
  'medium':medium,
  "high":high
  };
}