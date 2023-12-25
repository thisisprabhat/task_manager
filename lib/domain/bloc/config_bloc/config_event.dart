part of 'config_bloc.dart';

abstract class ConfigEvent {}

class ConfigThemeModeChangeEvent extends ConfigEvent {
  final ThemeMode? themeMode;
  final ThemeColor? themeColor;
  ConfigThemeModeChangeEvent({this.themeMode, this.themeColor});
}

class ConfigGetEvent extends ConfigEvent {}
