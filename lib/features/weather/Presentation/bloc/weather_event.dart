// // import 'package:equatable/equatable.dart';
// //
// // abstract class WeatherEvent extends Equatable{
// //  const  WeatherEvent();
// //  @override
// //   List<Object?> get props => [];
// // }
// // class FetchWeatherEvent extends WeatherEvent{
// //   final String cityName;
// //   const FetchWeatherEvent({required this.cityName});
// //   @override
// //   List<Object?> get props =>[cityName];
// // }
// //
// // class FetchWeatherByLocationEvent extends WeatherEvent {
// //   const FetchWeatherByLocationEvent();
// //
// //   @override
// //   List<Object?> get props => [];
// // }
// import 'package:equatable/equatable.dart';
//
// abstract class WeatherEvent extends Equatable {
//   const WeatherEvent();
//   @override
//   List<Object?> get props => [];
// }
//
// // ✅ Event for city search
// class FetchWeatherEvent extends WeatherEvent {
//   final String cityName;
//   const FetchWeatherEvent({required this.cityName});
//   @override
//   List<Object?> get props => [cityName];
// }
//
// // ✅ Event for GPS location
// class FetchWeatherByLocationEvent extends WeatherEvent {
//   const FetchWeatherByLocationEvent();
//   @override
//   List<Object?> get props => [];
// }
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}

// ✅ Event for city search
class FetchWeatherEvent extends WeatherEvent {
  final String cityName;
  const FetchWeatherEvent({required this.cityName});
  @override
  List<Object?> get props => [cityName];
}

// ✅ Event for GPS location
class FetchWeatherByLocationEvent extends WeatherEvent {
  const FetchWeatherByLocationEvent();
  @override
  List<Object?> get props => [];
}