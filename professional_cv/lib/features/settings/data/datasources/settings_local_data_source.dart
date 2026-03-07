import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class SettingsLocalDataSource {
  Future<ThemeMode> getThemeMode();
  Future<void> cacheThemeMode(ThemeMode themeMode);
  Future<Locale> getLocale();
  Future<void> cacheLocale(Locale locale);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final Box box;
  static const String themeKey = 'theme_mode';
  static const String localeKey = 'locale';

  SettingsLocalDataSourceImpl({required this.box});

  @override
  Future<ThemeMode> getThemeMode() async {
    final index = box.get(themeKey, defaultValue: ThemeMode.system.index);
    return ThemeMode.values[index];
  }

  @override
  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    await box.put(themeKey, themeMode.index);
  }

  @override
  Future<Locale> getLocale() async {
    final languageCode = box.get(localeKey, defaultValue: 'en');
    return Locale(languageCode);
  }

  @override
  Future<void> cacheLocale(Locale locale) async {
    await box.put(localeKey, locale.languageCode);
  }
}
