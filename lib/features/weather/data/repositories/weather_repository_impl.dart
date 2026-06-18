import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/error/exceptions.dart';
import 'package:weather_app_bloc/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app_bloc/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final remoteWeather = await remoteDataSource.getWeather(city);
      return Right(remoteWeather);
    } on ServerException catch (e) {
      return Left(ServerFailures(message: e.message));
    } catch (e) {
      return Left(ServerFailures(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeatherByLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final remoteWeather = await remoteDataSource.getWeatherByLocation(latitude, longitude);
      return Right(remoteWeather);
    } on ServerException catch (e) {
      return Left(ServerFailures(message: e.message));
    } catch (e) {
      return Left(ServerFailures(message: 'An unexpected error occurred'));
    }
  }
}
