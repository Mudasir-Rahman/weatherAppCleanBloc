import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

import '../../../../core/error/location_service_exception.dart';
import '../../../../core/utils/location_service.dart';
import '../repository/weather_repository.dart';

class GetWeatherByLocation implements UseCase<WeatherEntity ,NoParams>{
  final WeatherRepository repository;
  final LocationService locationService;
 const   GetWeatherByLocation({
    required this.repository,
    required this.locationService,
});
 @override
  Future<Either<Failure,WeatherEntity>>call(NoParams params)async{
   try {
     // Get location from GPS (NO parameter needed here)
     final location = await locationService.getCurrentLocation();
     final latitude = location['latitude']!;
     final longitude = location['longitude']!;

     // Pass coordinates to repository
     return await repository.getCurrentWeatherByLocation(
         latitude: latitude,
         longitude: longitude,
     );
 }on LocationServiceException catch (e) {
     return Left(ServerFailures(message: e.message));
   } catch (e) {
     return Left(ServerFailures(message: e.toString()));
   }
 }
}