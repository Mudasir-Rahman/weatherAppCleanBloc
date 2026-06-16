import 'package:dartz/dartz.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/entity/forecast_entity.dart';

import '../repository/get_forecost_repository.dart';

class GetForecostByName implements UseCase<ForecastEntity , String>{
  final GetForecostRepository repository;
 const  GetForecostByName({required this.repository});
  Future<Either<Failure,ForecastEntity>>call(String params)async{
    try{
      return await repository.getForecostByName(params);
    }catch(e){
      return Left(ServerFailures(message: e.toString()));
    }
  }
}