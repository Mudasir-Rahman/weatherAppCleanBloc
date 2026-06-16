import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/entity/forecast_entity.dart';

abstract class GetForecostRepository {
  Future<Either<Failure,ForecastEntity>>getForecostByName(String city);
  Future<Either<Failure,ForecastEntity>>getForecostByLocation({
    required double latitude,
    required double longitude,
});
}