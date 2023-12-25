import 'package:flutter/material.dart';

import '/core/constants/styles.dart';

class AppTheme {
  static ThemeData darkTheme(Color themeColor) {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: themeColor,
        brightness: Brightness.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
          padding: const EdgeInsets.all(paddingDefault),
          backgroundColor: themeColor,
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

  static ThemeData lightTheme(Color themeColor) {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: themeColor,
        brightness: Brightness.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
          padding: const EdgeInsets.all(paddingDefault),
          backgroundColor: themeColor,
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
}
