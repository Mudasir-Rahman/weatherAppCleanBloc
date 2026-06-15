import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/core/constants/api_constants.dart';
import 'package:weather_app_bloc/core/error/exceptions.dart';

import '../datasources/weather_remote_data_source.dart';
import '../model/weather_model.dart';



// 2. The Implementation
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  // Inject the HTTP client so we can test it later if we want
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    // 3. Build the URL dynamically using your constants!
    final url = '${ApiConstants.baseUrl}${ApiConstants.weatherEndPoint}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric';

    try {
      // 4. Make the actual network request
      final response = await client.get(Uri.parse(url));

      // 5. Check if the request was successful (HTTP 200 OK)
      if (response.statusCode == 200) {
        // Parse the JSON string into a Map, then into our WeatherModel
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        // If it fails (e.g., 404 City Not Found), throw an Exception!
        throw ServerException(message: 'Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any network errors (like no internet connection)
      // You can't access 'response' here, so provide a generic message
      throw ServerException(message: 'Failed to load weather: Network error or invalid response');
    }
  }
}