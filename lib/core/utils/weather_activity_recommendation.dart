import 'package:flutter/material.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

class WeatherActivityRecommendation {
  final IconData icon;
  final String title;
  final String message;
  final String action;

  const WeatherActivityRecommendation({
    required this.icon,
    required this.title,
    required this.message,
    required this.action,
  });

  factory WeatherActivityRecommendation.fromWeather(WeatherEntity weather) {
    final description = weather.description.toLowerCase();
    final isRainy =
        description.contains('rain') ||
        description.contains('drizzle') ||
        weather.iconCode.startsWith('09') ||
        weather.iconCode.startsWith('10');
    final isStormy =
        description.contains('thunder') || weather.iconCode.startsWith('11');
    final isSnowy =
        description.contains('snow') || weather.iconCode.startsWith('13');
    final isWindy = weather.windSpeed >= 9;
    final isHot = weather.temperature >= 30;
    final isCold = weather.temperature <= 5;

    if (isStormy) {
      return const WeatherActivityRecommendation(
        icon: Icons.thunderstorm_outlined,
        title: 'Stay weather-ready',
        message:
            'Thunderstorms are active. Choose an indoor plan and avoid exposed areas.',
        action: 'Indoor plans',
      );
    }
    if (isRainy) {
      return const WeatherActivityRecommendation(
        icon: Icons.umbrella_outlined,
        title: 'Rain is on the way',
        message:
            'A walk can still work with waterproof layers, but keep an indoor backup nearby.',
        action: 'Bring an umbrella',
      );
    }
    if (isSnowy || isCold) {
      return const WeatherActivityRecommendation(
        icon: Icons.ac_unit,
        title: 'Bundle up outside',
        message:
            'Cold conditions call for warm layers and shorter outdoor sessions.',
        action: 'Wear warm layers',
      );
    }
    if (isWindy) {
      return const WeatherActivityRecommendation(
        icon: Icons.air,
        title: 'A breezy day',
        message:
            'Pick a sheltered route and skip activities with loose equipment.',
        action: 'Choose a sheltered route',
      );
    }
    if (isHot) {
      return const WeatherActivityRecommendation(
        icon: Icons.wb_sunny_outlined,
        title: 'Good for an early outing',
        message: 'Enjoy the outdoors before peak heat and take water with you.',
        action: 'Carry water',
      );
    }
    return const WeatherActivityRecommendation(
      icon: Icons.directions_walk_outlined,
      title: 'Great for getting outside',
      message:
          'Comfortable conditions make this a good time for a walk, run, or café stop.',
      action: 'Plan an outdoor activity',
    );
  }
}
