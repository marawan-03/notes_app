import 'package:flutter/material.dart';

const int cream = 0xFFFFE0A2;
const int whiteCream = 0xFFFFF1D4;
const int black = 0xFF16161A;
const int grey = 0xFF31313A;
const int coral = 0xFFFF6B4A;

ThemeData lightTheme = ThemeData(
  fontFamily: 'Alexandria',
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(whiteCream),
    primary: Color(black),
    secondary: Color(cream),
    tertiary: Color(coral),
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) =>
        const Icon(Icons.arrow_back_ios_new, color: Color(black)),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: 'Alexandria',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color(black),
    primary: Color(cream),
    secondary: Color(grey),
    tertiary: Color(coral),
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) =>
        const Icon(Icons.arrow_back_ios_new, color: Color(cream)),
  ),
);
