import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc({required this.repository})
      : super(const SettingsState(themeMode: ThemeMode.system, locale: Locale('en'))) {
    on<LoadSettingsEvent>((event, emit) async {
      final themeMode = await repository.getThemeMode();
      final locale = await repository.getLocale();
      emit(SettingsState(themeMode: themeMode, locale: locale));
    });

    on<ChangeThemeEvent>((event, emit) async {
      await repository.setThemeMode(event.themeMode);
      emit(state.copyWith(themeMode: event.themeMode));
    });

    on<ChangeLocaleEvent>((event, emit) async {
      await repository.setLocale(event.locale);
      emit(state.copyWith(locale: event.locale));
    });
  }
}
