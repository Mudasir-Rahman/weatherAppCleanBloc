import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/core/constants/api_constants.dart';
import 'package:weather_app_bloc/core/error/exceptions.dart';
import '../datasources/weather_remote_data_source.dart';
import '../model/weather_model.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  // For city search (user types city name)
  @override
  Future<WeatherModel> getWeather(String cityName) async {
    final url = '${ApiConstants.baseUrl}${ApiConstants.weatherEndPoint}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric';

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: 'Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: 'Failed to load weather: Network error or invalid response');
    }
  }

  // For GPS location (user clicks "My Location" button)
  @override
  Future<WeatherModel> getWeatherByLocation(double latitude, double longitude) async {
    final url = '${ApiConstants.baseUrl}${ApiConstants.weatherEndPoint}?lat=$latitude&lon=$longitude&appid=${ApiConstants.apiKey}&units=metric';

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: 'Failed to load weather by location: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: 'Failed to load weather by location: Network error');
    }
  }
}