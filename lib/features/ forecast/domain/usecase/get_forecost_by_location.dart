import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/entity/forecast_entity.dart';

import '../../../../core/error/location_service_exception.dart';
import '../../../../core/utils/location_service.dart';
import '../repository/get_forecost_repository.dart';

class GetForecostByLocation implements UseCase<ForecastEntity, NoParams>{
  final GetForecostRepository repository;
  final LocationService locationService;
  GetForecostByLocation({
  required this.repository,

  required this.locationService
  });
  Future<Either<Failure,ForecastEntity>>call(NoParams params)async{
    try{
      final location = await locationService.getCurrentLocation();
      final latitude = location['latitude']!;
      final longitude = location['longitude']!;
      return await repository.getForecostByLocation(
        latitude: latitude,
        longitude: longitude,
      );

    }
    on LocationServiceException catch (e) {
      return Left(ServerFailures(message: e.message));
    } catch (e) {
      return Left(ServerFailures(message: e.toString()));
    }
  }
}