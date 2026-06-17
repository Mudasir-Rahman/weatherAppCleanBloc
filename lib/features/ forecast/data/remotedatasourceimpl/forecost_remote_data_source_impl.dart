import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_bloc/features/%20forecast/data/model/forecost_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../remote_data_source_forecost/remote_data_source_forecost.dart';


 class ForecostRemoteDataSourceImpl implements RemoteDataSourceForecost{
  final http.Client client;
  ForecostRemoteDataSourceImpl({required this.client});
  // for city search user search city forecost
Future<ForecastModel>getForecostByCity(String cityName)async {
  final url = '${ApiConstants.baseUrl}${ApiConstants.forecastEndPoint}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric';
try{
  final response = await client.get(Uri.parse(url));
  if(response.statusCode==200){
    return ForecastModel.fromJson(jsonDecode(response.body));
  }else{
    throw ServerException(message: 'Failed to load forecast: ${response.statusCode}');
  }
}catch(e) {
  throw ServerException(
      message: 'Failed to load forecast: Network error or invalid response');
}}
  @override
  Future<ForecastModel> getForecostByLocation(double latitude, double longitude) async {
    // 🟢 FORECAST URL with latitude and longitude
    final url = '${ApiConstants.baseUrl}${ApiConstants.forecastEndPoint}?lat=$latitude&lon=$longitude&appid=${ApiConstants.apiKey}&units=metric';

    try {
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 200)  {
        return ForecastModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(message: 'Failed to load forecast by location: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: 'Failed to load forecast by location: Network error');
    }
  }
}

