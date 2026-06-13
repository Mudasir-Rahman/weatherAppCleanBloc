import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app_bloc/features/weather/domain/repository/weather_repository.dart';

 class GetCurrentWeather implements  UseCase<WeatherEntity,String>{
  final WeatherRepository repository;
  GetCurrentWeather({required this.repository});
  @override
  Future<Either<Failure,WeatherEntity>>call(String params) async{
    return await repository.getCurrentWeather(params);
  }
}