import 'package:weather_app_bloc/features/%20forecast/data/model/forecost_model.dart';

abstract class RemoteDataSourceForecost {
  Future<ForecastModel> getForecostByCity(String cityName);
  Future<ForecastModel> getForecostByLocation(double latitude, double longitude);
}