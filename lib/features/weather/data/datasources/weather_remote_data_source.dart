
import 'package:weather_app_bloc/features/weather/data/model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel>getWeather(String cityName);
  Future<WeatherModel> getWeatherByLocation(double latitude, double longitude);
}
