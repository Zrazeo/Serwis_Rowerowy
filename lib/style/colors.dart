import 'package:flutter/material.dart';

abstract class AppTheme implements AppColorBase {}

abstract class AppColorBase {
  late Color backgroundColor;
  late Color highlightColor;
  late Color unselectedColor;
  late Color accentColor;
  late Color textDarkColor;
  late Color textLightColor;
}

class AppStandardsColors {
  static const Color backgroundColor = Color(0xFF7C9A9A);
  static const Color highlightColor = Color(0xFF8CA7A2);
  static const Color unselectedColor = Color(0xFF68837E);
  static const Color accentColor = Color(0xFFDABBA7);
  static const Color textDarkColor = Color(0xFF5E5E5E);
  static const Color textLightColor = Color(0xFFC4C4C4);
}
