part of 'config_bloc.dart';

abstract class ConfigState {
  final ThemeMode themeMode;
  final ThemeColor themeColor;

  ConfigState({required this.themeColor, required this.themeMode});
}

class ConfigInitialState extends ConfigState {
  ConfigInitialState()
      : super(themeColor: ThemeColor.dynamic, themeMode: ThemeMode.system);
}

class ConfigLoadedState extends ConfigState {
  ConfigLoadedState({required super.themeMode, required super.themeColor});
}
