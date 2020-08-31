import 'package:flutter/material.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
    primaryColor: LightColor.primaryColor,
    primaryColorBrightness: Brightness.dark,
    accentColor: LightColor.accentColor,
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: LightColor.background,
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    fontFamily: 'Rubik',
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: LightColor.primaryColor,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        8.0,
      ),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        borderSide: BorderSide(style: BorderStyle.none),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
    ),
  );
}
