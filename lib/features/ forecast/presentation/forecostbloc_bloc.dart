import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/usecase/get_forecost_by_location.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/usecase/get_forecost_by_name.dart';


import 'forecost_event.dart';
import 'forecost_state.dart';

class ForecastBloc extends Bloc<ForecostEvent, ForecostState> {
  final GetForecostByName getForecastByCity;
  final GetForecostByLocation getForecastByLocation;

  ForecastBloc({
    required this.getForecastByCity,
    required this.getForecastByLocation,
  }) : super(ForecostInitial()) {
    on<GetForecastByCityEvent>(_onGetForecastByCity);

    on<GetForecastByLocationEvent>(_onGetForecastByLocation);
  }

  Future<void> _onGetForecastByCity(
      GetForecastByCityEvent event,
      Emitter<ForecostState> emit,
      ) async {
    emit(ForecostLoading());

    final result = await getForecastByCity(event.cityName);

    result.fold(
          (failure) => emit(
        ForecostError(message: failure.message),
      ),
          (forecast) => emit(
        ForecostLoaded(forecast: forecast),
      ),
    );
  }

  Future<void> _onGetForecastByLocation(
      GetForecastByLocationEvent event,
      Emitter<ForecostState> emit,
      ) async {
    emit(ForecostLoading());

    final result = await getForecastByLocation(NoParams());

    result.fold(
          (failure) => emit(
        ForecostError(message: failure.message),
      ),
          (forecast) => emit(
        ForecostLoaded(forecast: forecast),
      ),
    );
  }
}