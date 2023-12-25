import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/domain/bloc/config_bloc/config_bloc.dart';
import '/core/utils/colored_log.dart';
import '/data/repositories/local/config_repo/config_repo.dart';

class HiveConfigRepository implements ConfigRepository {
  static const configBox = 'configs';

  @override
  Future<ThemeColor> getThemeColor() async {
    var box = Hive.box(configBox);
    String? themeColorString = await box.get('themeColor');
    ColoredLog(themeColorString, name: 'ThemeColor');

    if (themeColorString == null || themeColorString == '') {
      return ThemeColor.dynamic;
    } else {
      return ThemeColor.values.firstWhere((e) => e.name == themeColorString);
    }
  }

  @override
  Future<void> setThemeColor(ThemeColor themeColor) async {
    var box = Hive.box(configBox);
    box.put('themeColor', themeColor.name);
    ColoredLog.blue(themeColor, name: 'setThemeColor');
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      var box = Hive.box(configBox);
      String theme;

      if (themeMode == ThemeMode.light) {
        theme = 'light';
      } else if (themeMode == ThemeMode.dark) {
        theme = 'dark';
      } else {
        theme = 'system';
      }
      ColoredLog.yellow(theme, name: 'setTheme');

      await box.put('theme', theme);
    } catch (e) {
      ColoredLog.red(e, name: 'SetThemeMode');
    }
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    var box = Hive.box(configBox);
    String? theme = await box.get('theme');
    ColoredLog(theme, name: 'getTheme');

    if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'system') {
      return ThemeMode.system;
    } else {
      return ThemeMode.dark;
    }
  }
}
