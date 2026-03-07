import 'package:flutter/material.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<ThemeMode> getThemeMode() => localDataSource.getThemeMode();

  @override
  Future<void> setThemeMode(ThemeMode themeMode) => localDataSource.cacheThemeMode(themeMode);

  @override
  Future<Locale> getLocale() => localDataSource.getLocale();

  @override
  Future<void> setLocale(Locale locale) => localDataSource.cacheLocale(locale);
}
