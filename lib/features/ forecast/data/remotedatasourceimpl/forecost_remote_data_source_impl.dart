import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/features/%20forecast/data/model/forecost_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../remote_data_source_forecost/remote_data_source_forecost.dart';

class ForecostRemoteDataSourceImpl implements RemoteDataSourceForecost {
  final http.Client client;
  ForecostRemoteDataSourceImpl({required this.client});
  Future<ForecastModel> getForecostByCity(String cityName) async {
    try {
      final geoUrl =
          '${ApiConstants.geocodingBaseUrl}${ApiConstants.geocodingEndPoint}?q=${Uri.encodeQueryComponent(cityName)}&limit=1&appid=${ApiConstants.apiKey}';
      final geoResponse = await client.get(Uri.parse(geoUrl));
      if (geoResponse.statusCode == 200) {
        final locations = jsonDecode(geoResponse.body) as List;
        if (locations.isNotEmpty) {
          return _getOneCall(
            (locations.first['lat'] as num).toDouble(),
            (locations.first['lon'] as num).toDouble(),
            cityName,
          );
        }
      }
    } catch (_) {}
    return _getFiveDayByCity(cityName);
  }

  @override
  Future<ForecastModel> getForecostByLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      return await _getOneCall(latitude, longitude, '');
    } catch (_) {
      return _getFiveDayByLocation(latitude, longitude);
    }
  }

  Future<ForecastModel> _getOneCall(
    double latitude,
    double longitude,
    String cityName,
  ) async {
    final url =
        '${ApiConstants.oneCallBaseUrl}${ApiConstants.oneCallEndPoint}?lat=$latitude&lon=$longitude&exclude=minutely,alerts&appid=${ApiConstants.apiKey}&units=metric';
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200)
      throw ServerException(message: 'Seven-day forecast unavailable');
    return ForecastModel.fromJson(
      jsonDecode(response.body),
      cityNameOverride: cityName.isEmpty ? null : cityName,
    );
  }

  Future<ForecastModel> _getFiveDayByCity(String cityName) async {
    final url =
        '${ApiConstants.baseUrl}${ApiConstants.forecastEndPoint}?q=${Uri.encodeQueryComponent(cityName)}&appid=${ApiConstants.apiKey}&units=metric';
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200)
      throw ServerException(
        message: 'Failed to load forecast: ${response.statusCode}',
      );
    return ForecastModel.fromJson(jsonDecode(response.body));
  }

  Future<ForecastModel> _getFiveDayByLocation(
    double latitude,
    double longitude,
  ) async {
    final url =
        '${ApiConstants.baseUrl}${ApiConstants.forecastEndPoint}?lat=$latitude&lon=$longitude&appid=${ApiConstants.apiKey}&units=metric';
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200)
      throw ServerException(
        message: 'Failed to load forecast by location: ${response.statusCode}',
      );
    return ForecastModel.fromJson(jsonDecode(response.body));
  }
}
