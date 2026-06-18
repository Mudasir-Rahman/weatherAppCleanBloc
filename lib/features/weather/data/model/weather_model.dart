import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.description,
    required super.iconCode,
    required super.humidity,
    required super.windSpeed,
    required super.pressure,
    required super.windDeg,
    required super.dayName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      // ✅ FIXED: Temperature is inside the 'main' object
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      description: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['description'] ?? ''
          : '',
      iconCode: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['icon'] ?? ''
          : '',
      humidity: json['main']?['humidity'] ?? 0,
      pressure: json['main']?['pressure'] ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      windDeg: json['wind']?['deg'] ?? 0,
      dayName: '', // Usually handled by the UI or a separate utility
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {
        'temp': temperature,
        'humidity': humidity,
        'pressure': pressure,
      },
      'weather': [
        {'description': description, 'icon': iconCode}
      ],
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
    };
  }
}
