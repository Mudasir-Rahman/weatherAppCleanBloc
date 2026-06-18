import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/error/exceptions.dart';
import 'package:weather_app_bloc/features/%20forecast/data/remote_data_source_forecost/remote_data_source_forecost.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/entity/forecast_entity.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/repository/get_forecost_repository.dart';

class ForecostRepositoryImpl implements GetForecostRepository {
  final RemoteDataSourceForecost remoteDataSource;

  ForecostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ForecastEntity>> getForecostByName(String city) async {
    try {
      final remoteForecast = await remoteDataSource.getForecostByCity(city);
      return Right(remoteForecast);
    } on ServerException catch (e) {
      return Left(ServerFailures(message: e.message));
    } catch (e) {
      return Left(ServerFailures(message: 'An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, ForecastEntity>> getForecostByLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final remoteForecast = await remoteDataSource.getForecostByLocation(latitude, longitude);
      return Right(remoteForecast);
    } on ServerException catch (e) {
      return Left(ServerFailures(message: e.message));
    } catch (e) {
      return Left(ServerFailures(message: 'An unexpected error occurred'));
    }
  }
}
