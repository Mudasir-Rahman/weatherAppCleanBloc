import 'package:equatable/equatable.dart';

abstract class ForecastEntity extends Equatable {
  final String cityName;
  final List<ForecastItems> forecastList;
  final List<HourlyForecastItem> hourlyList;
  const ForecastEntity({
    required this.cityName,
    required this.forecastList,
    required this.hourlyList,
  });
  @override
  List<Object?> get props => [cityName, forecastList, hourlyList];
}

class ForecastItems extends Equatable {
  final String dayName; // "MON", "TUE"
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String iconCode;
  final String description;
  const ForecastItems({
    required this.dayName,
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.iconCode,
    required this.description,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    dayName,
    date,
    maxTemp,
    minTemp,
    iconCode,
    description,
  ];
}

class HourlyForecastItem extends Equatable {
  final DateTime time;
  final double temperature;
  final String iconCode;
  final String description;

  const HourlyForecastItem({
    required this.time,
    required this.temperature,
    required this.iconCode,
    required this.description,
  });

  @override
  List<Object?> get props => [time, temperature, iconCode, description];
}
