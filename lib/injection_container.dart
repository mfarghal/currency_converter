import 'package:currency_converter_demo/features/exhange/data/datasources/exhange_remote_data_source.dart';
import 'package:currency_converter_demo/features/exhange/data/repositories/exhange_repository_impl.dart';
import 'package:currency_converter_demo/features/exhange/domain/repositories/exhange_repository.dart';
import 'package:currency_converter_demo/features/exhange/domain/usecases/get_convert_rate.dart';
import 'package:currency_converter_demo/features/exhange/presentation/bloc/bloc/exhange_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/countries/data/datasources/local/countries_local_data_source.dart';
import 'features/countries/data/datasources/local/hive/countries_hive_data_source.dart';
import 'features/countries/data/datasources/remote/countries_remote_data_source.dart';
import 'features/countries/data/repositories/countries_repository_impl.dart';
import 'features/countries/domain/repositories/countries_repository.dart';
import 'features/countries/domain/usecases/get_available_countries.dart';
import 'features/countries/presentation/bloc/bloc/countries_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // ! Features
  _initFeatures();
  // ! Core
  await _initCore();
  // ! External
  await _initExternal();
}

void _initFeatures() {
  // Bloc
  sl.registerFactory(() => CountriesBloc(getAvailableCountriesUseCase: sl()));
  sl.registerFactory(() => ExhangeBloc(getConvertRate: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetAvailableCountries(sl()));
  sl.registerLazySingleton(() => GetConvertRate(sl()));

  // Repositories
  sl.registerLazySingleton<CountriesRepository>(
    () => CountriesRepositoryImp(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ExhangeRepository>(
    () => ExhangeRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CountriesLocalDataSource>(
    () => CountriesLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ExhangeRemoteDataSource>(
    () => ExhangeRemoteDataSourceImpl(sl()),
  );
}

Future<void> _initCore() async {
  // db
  sl.registerLazySingleton<CountriesHiveDataSource>(
      () => CountriesHiveDataSource());
  await sl<CountriesHiveDataSource>().init();
}

Future<void> _initExternal() async {
  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  await sl.isReady<SharedPreferences>();
}
