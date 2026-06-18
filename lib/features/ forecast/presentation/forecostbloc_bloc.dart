
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';

import '../domain/usecase/get_forecost_by_location.dart';
import '../domain/usecase/get_forecost_by_name.dart';
import 'forecost_event.dart';
import 'forecost_state.dart';

class ForecastBloc extends Bloc<ForecostEvent, ForecostState> {

  final GetForecostByName getForecastByCity;
  final GetForecostByLocation getForecastByLocation;

  ForecastBloc({
    required this.getForecastByCity,
    required this.getForecastByLocation,
  }) : super(ForecostInitial()) {


    on<GetForecastByCityEvent>((event, emit) async {
      emit(ForecostLoading());

      final result = await getForecastByCity(event.cityName);

      result.fold(
            (failure) => emit(ForecostError(message: _mapFailureToMessage(failure))),
            (forecast) => emit(ForecostLoaded(forecast: forecast)),
      );
    });

    // ✅ Event 2: Get forecast by GPS location
    on<GetForecastByLocationEvent>((event, emit) async {
      emit(ForecostLoading());

      final result = await getForecastByLocation(NoParams());

      result.fold(
            (failure) => emit(ForecostError(message: _mapFailureToMessage(failure))),
            (forecast) => emit(ForecostLoaded(forecast: forecast)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailures) {
      return failure.message;
    } else if (failure is NoInternetFailures) {
      return 'No internet connection. Please check your network.';
    } else {
      return 'Unexpected error occurred. Please try again.';
    }
  }
}