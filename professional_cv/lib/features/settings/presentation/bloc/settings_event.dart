part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class ChangeThemeEvent extends SettingsEvent {
  final ThemeMode themeMode;
  const ChangeThemeEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class ChangeLocaleEvent extends SettingsEvent {
  final Locale locale;
  const ChangeLocaleEvent(this.locale);

  @override
  List<Object> get props => [locale];
}
