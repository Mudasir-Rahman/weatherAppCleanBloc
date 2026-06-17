import 'package:equatable/equatable.dart';


 class WeatherEntity extends Equatable{
  final String cityName;
  final double temperature;
  final  String description;
final   String iconCode;
  final int  humidity;
  final double windSpeed;
  final int pressure;
  final int windDeg;
  final String dayName;
  const  WeatherEntity({
    required this.cityName,
     required this.temperature,
     required this.description,
     required this.iconCode,
     required this.humidity,
     required this.windSpeed,
    required this.pressure,
    required this.windDeg,
    required this.dayName,

});
   @override
  List<Object?> get props =>[cityName,temperature,description,iconCode,humidity,windSpeed,pressure,windDeg,dayName];
}