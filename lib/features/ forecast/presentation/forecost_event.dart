import 'package:equatable/equatable.dart';

abstract class ForecostEvent extends Equatable {
  const ForecostEvent();

  @override
  List<Object?> get props => [];
}

class GetForecastByCityEvent extends ForecostEvent {
  final String cityName;

  const GetForecastByCityEvent({
    required this.cityName,
  });

  @override
  List<Object?> get props => [cityName];
}

class GetForecastByLocationEvent extends ForecostEvent {
  const GetForecastByLocationEvent();

  @override
  List<Object?> get props => [];
}