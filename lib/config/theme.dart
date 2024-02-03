import 'package:flutter/material.dart';

Color _primaryColor = Colors.amber;
Color _secondaryColor = Colors.amberAccent;
Color _tertiaryColor = Colors.black87;
Color _errorColor = Colors.red;

ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
      primary: _primaryColor,
      secondary: _secondaryColor,
      tertiary: _tertiaryColor,
      error: _errorColor,
      seedColor: _primaryColor,
      brightness: Brightness.light),
  inputDecorationTheme: InputDecorationTheme(),
  textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
      displayMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
);
