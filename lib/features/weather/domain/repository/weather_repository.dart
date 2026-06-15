import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

abstract class WeatherRepository {
  // Existing: Get weather by city name (NEEDS parameter)
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);

  // NEW: Get weather by coordinates (NO parameter needed from UI - uses GPS)
  Future<Either<Failure, WeatherEntity>> getCurrentWeatherByLocation({
    required double latitude,
    required double longitude,
  });
}