import 'package:flutter/material.dart';
import '/presentation/screens/settings/components/theme_switcher.dart';

import '/core/constants/styles.dart';

class AppTheme {
  static ThemeData darkTheme(ThemeColor themeColor) {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: getThemeColor(themeColor),
        brightness: Brightness.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
          padding: const EdgeInsets.all(paddingDefault),
          backgroundColor: getThemeColor(themeColor),
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

  static ThemeData lightTheme(ThemeColor themeColor) {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: getThemeColor(themeColor),
        brightness: Brightness.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadiusDefault),
          padding: const EdgeInsets.all(paddingDefault),
          backgroundColor: getThemeColor(themeColor),
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
