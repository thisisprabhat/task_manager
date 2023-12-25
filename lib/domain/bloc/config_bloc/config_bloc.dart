import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/colored_log.dart';
import '/data/repositories/app_repository.dart';
import '/data/repositories/local/config_repo/config_repo.dart';
import '/presentation/screens/settings/components/theme_switcher.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepository _repo = AppRepository().configRepository;

  ThemeMode themeMode = ThemeMode.light;
  ThemeColor themeColor = ThemeColor.dynamic;

  ConfigBloc() : super(ConfigInitialState()) {
    on<ConfigThemeModeChangeEvent>(_configChangeEvent);
    on<ConfigGetEvent>(_configGetEvent);
  }
  _configGetEvent(ConfigGetEvent event, Emitter<ConfigState> emit) async {
    ColoredLog.yellow('ConfigInitialThemeEvent');
    themeMode = await _repo.getThemeMode();
    themeColor = await _repo.getThemeColor();
    ColoredLog.green(themeMode, name: 'Get ThemeMode form local DB');
    ColoredLog.green(themeMode, name: 'Get ThemeColor form local DB');

    emit(ConfigLoadedState(themeMode: themeMode, themeColor: themeColor));
  }

  _configChangeEvent(
      ConfigThemeModeChangeEvent event, Emitter<ConfigState> emit) async {
    if (event.themeMode != null) {
      themeMode = event.themeMode!;
      await _repo.setThemeMode(themeMode);
    }
    if (event.themeColor != null) {
      themeColor = event.themeColor!;
      await _repo.setThemeColor(themeColor);
    }

    emit(ConfigLoadedState(themeMode: themeMode, themeColor: themeColor));
  }
}
