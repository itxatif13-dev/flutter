import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/cv/data/datasources/cv_local_data_source.dart';
import 'features/cv/data/repositories/cv_repository_impl.dart';
import 'features/cv/domain/repositories/cv_repository.dart';
import 'features/cv/presentation/bloc/cv_bloc.dart';
import 'features/settings/data/datasources/settings_local_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  final settingsBox = await Hive.openBox('settings');

  // Features - CV
  // Bloc
  sl.registerFactory(() => CVBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<CVRepository>(
    () => CVRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CVLocalDataSource>(
    () => CVLocalDataSourceImpl(),
  );

  // Features - Settings
  // Bloc
  sl.registerFactory(() => SettingsBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(box: settingsBox),
  );
}
