import 'package:equatable/equatable.dart';

import '../domain/entity/forecast_entity.dart';

abstract class ForecostState extends Equatable {
  const ForecostState();

  @override
  List<Object?> get props => [];
}

class ForecostInitial extends ForecostState {}

class ForecostLoading extends ForecostState {}

class ForecostLoaded extends ForecostState {
  final ForecastEntity forecast;

  const ForecostLoaded({
    required this.forecast,
  });

  @override
  List<Object?> get props => [forecast];
}

class ForecostError extends ForecostState {
  final String message;

  const ForecostError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}