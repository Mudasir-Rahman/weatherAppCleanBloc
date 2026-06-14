
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

class WeatherModel extends WeatherEntity{

 const  WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.description,
  required super.iconCode,
    required super.humidity,
    required super.windSpeed,
  });

// Convert from JSON (API response)
//now create constructor
factory WeatherModel.fromJson(Map<String,dynamic>json){
  return WeatherModel(
cityName: json['city_name']?? json['name'] ?? '',
    temperature: (json['temperature'] ?? json['temp'] ?? 0).toDouble(),
    description: json['description'] ?? json['weather'][0]['description'] ?? '',
    iconCode: json['icon_code'] ?? json['weather'][0]['icon'] ?? '',
    humidity: json['humidity'] ?? json['main']['humidity'] ?? 0,
    windSpeed: (json['wind_speed'] ?? json['wind']['speed'] ?? 0).toDouble(),

  );}
  // convert to json
Map<String , dynamic> toJson(){
  return {
    'city_name': cityName,
    'temperature': temperature,
    'description': description,
    'icon_code': iconCode,
    'humidity': humidity,
    'wind_speed': windSpeed,

  };
  }

}

