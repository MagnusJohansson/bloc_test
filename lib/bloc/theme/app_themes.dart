import 'package:flutter/material.dart';

enum AppTheme {
  Green,
  Blue,
  Orange,
  Red,
}

final appThemeData = {
  AppTheme.Green: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
  ),
  AppTheme.Blue: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
  ),
  AppTheme.Orange: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange,
  ),
  AppTheme.Red: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
  ),
};

final appThemeDarkData = {
  AppTheme.Green: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
  ),
  AppTheme.Blue: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
  ),
  AppTheme.Orange: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrange,
  ),
  AppTheme.Red: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
  ),
};



// enum AppTheme {
//   GreenLight,
//   GreenDark,
//   BlueLight,
//   BlueDark,
//   OrangeLight,
//   OrangeDark,
//   RedLight,
//   RedDark,
// }

// final appThemeData = {
//   AppTheme.GreenLight: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.green,
//   ),
//   AppTheme.GreenDark: ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.green[700],
//   ),
//   AppTheme.BlueLight: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.blue,
//   ),
//   AppTheme.BlueDark: ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.blue[700],
//   ),
//   AppTheme.OrangeLight: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.deepOrange,
//   ),
//   AppTheme.OrangeDark: ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.deepOrange[700],
//   ),
//   AppTheme.RedLight: ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.red,
//   ),
//   AppTheme.RedDark: ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.red[700],
//   ),
// };
