import 'package:flutter/material.dart';

import '/presentation/screens/settings/components/theme_switcher.dart';

abstract class ConfigRepository {
  ///It gives the persisted [dark_mode] or [light_mode] of the app
  Future<ThemeMode> getThemeMode();

  ///It helps in persisting [dark_mode] or [light_mode] of the app
  Future<void> setThemeMode(ThemeMode themeMode);

  ///It gives persisted themeColorMode for the app;
  Future<ThemeColor> getThemeColor();

  ///It helps in persisting ThemeColor of the app
  Future<void> setThemeColor(ThemeColor type);
}
