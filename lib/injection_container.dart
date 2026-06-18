import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/core/utils/location_service.dart';
import 'package:weather_app_bloc/features/%20forecast/data/remote_data_source_forecost/remote_data_source_forecost.dart';
import 'package:weather_app_bloc/features/%20forecast/data/remotedatasourceimpl/forecost_remote_data_source_impl.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/repository/get_forecost_repository.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/usecase/get_forecost_by_location.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/usecase/get_forecost_by_name.dart';
import 'package:weather_app_bloc/features/%20forecast/data/repository_impl/forecost_repository_impl.dart';

// Weather Imports
import 'package:weather_app_bloc/features/weather/data/RemoteDataSourceImpl/WeatherRemoteDataSourceImpl.dart';
import 'package:weather_app_bloc/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app_bloc/features/weather/domain/usecase/getWeatherByLocation.dart';
import 'package:weather_app_bloc/features/weather/domain/usecase/get_current_weather.dart';
import 'package:weather_app_bloc/features/weather/data/repositories/weather_repository_impl.dart';

import 'features/ forecast/presentation/forecostbloc_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ==================== CORE ====================
  sl.registerLazySingleton(() => LocationService());

  // ==================== WEATHER FEATURE ====================

  // BLoC
  sl.registerFactory(() => WeatherBloc(
    getCurrentWeather: sl(),
    getWeatherByLocation: sl(),
  ));

  // Use Cases
  sl.registerLazySingleton(() => GetCurrentWeather(repository: sl()));
  sl.registerLazySingleton(() => GetWeatherByLocation(
    repository: sl(),
    locationService: sl(),
  ));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
    remoteDataSource: sl(),
  ));

  // Remote Data Source
  sl.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(
    client: sl(),
  ));

  // ==================== FORECAST FEATURE ====================

  // BLoC
  sl.registerFactory(() => ForecastBloc(
    getForecastByCity: sl(),
    getForecastByLocation: sl(),
  ));

  // Use Cases
  sl.registerLazySingleton(() => GetForecostByName(repository: sl()));
  sl.registerLazySingleton(() => GetForecostByLocation(
    repository: sl(),
    locationService: sl(),
  ));

  // Repository
  sl.registerLazySingleton<GetForecostRepository>(() => ForecostRepositoryImpl(
    remoteDataSource: sl(),
  ));

  // Remote Data Source
  sl.registerLazySingleton<RemoteDataSourceForecost>(() => ForecostRemoteDataSourceImpl(
    client: sl(),
  ));

  // ==================== EXTERNAL ====================
  sl.registerLazySingleton(() => http.Client());
}
