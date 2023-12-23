import 'package:flutter/material.dart';

import '/core/constants/styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.yellow.shade800,
      brightness: Brightness.dark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
        padding: const EdgeInsets.all(paddingDefault),
        backgroundColor: Colors.yellow.shade800,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: borderRadiusDefault,
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.yellow.shade800,
      brightness: Brightness.light,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
        padding: const EdgeInsets.all(paddingDefault),
        backgroundColor: Colors.yellow.shade800,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: borderRadiusDefault,
      ),
    ),
  );
}
