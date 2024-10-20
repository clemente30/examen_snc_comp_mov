import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: const Color.fromARGB(2255, 23, 235, 168),
      brightness: Brightness.light,
      fontFamily: "Roboto",
      appBarTheme: const AppBarTheme(color: Color.fromARGB(2255, 23, 235, 168)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(2255, 23, 235, 168))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 23, 235, 168)));
}
