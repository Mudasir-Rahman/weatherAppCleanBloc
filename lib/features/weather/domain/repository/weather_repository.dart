import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure,WeatherEntity>>getCurrentWeather(String city);
}