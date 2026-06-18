// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_event.dart';
// // import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_state.dart';
// // import 'package:weather_app_bloc/features/weather/domain/usecase/get_current_weather.dart';
// // import '../../../../core/usecase/usecase.dart';
// // import '../../domain/usecase/getWeatherByLocation.dart';
// //
// // class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
// //   final GetCurrentWeather getCurrentWeather;
// //   final GetWeatherByLocation getWeatherByLocation;
// //
// //   WeatherBloc({
// //     required this.getCurrentWeather,
// //     required this.getWeatherByLocation,
// //   }) : super(WeatherInitial()) {
// //
// //     // Event 1: Search by city name
// //     on<FetchWeatherEvent>((event, emit) async {
// //       emit(WeatherLoading());
// //       final failureOrWeather = await getCurrentWeather(event.cityName);
// //       failureOrWeather.fold(
// //             (failure) => emit(WeatherError(message: failure.message)),
// //             (weather) => emit(WeatherLoaded(weather: weather)),
// //       );
// //     });
// //
// //     // Event 2: Get weather by GPS location
// //     on<FetchWeatherByLocationEvent>((event, emit) async {
// //       emit(WeatherLoading());
// //       final failureOrWeather = await getWeatherByLocation(NoParams());
// //       failureOrWeather.fold(
// //             (failure) => emit(WeatherError(message: failure.message)),
// //             (weather) => emit(WeatherLoaded(weather: weather)),
// //       );
// //     });
// //   }
// // }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:weather_app_bloc/core/error/failures.dart';
// import 'package:weather_app_bloc/core/usecase/usecase.dart';
// import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';
//
// import '../../domain/usecase/getWeatherByLocation.dart';
// import '../../domain/usecase/get_current_weather.dart';
// import 'weather_event.dart';
// import 'weather_state.dart';
//
// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   final GetCurrentWeather getCurrentWeather;
//   final GetWeatherByLocation getWeatherByLocation;
//
//   WeatherBloc({
//     required this.getCurrentWeather,
//     required this.getWeatherByLocation,
//   }) : super(WeatherInitial()) {
//
//     // ✅ Event 1: Get weather by city name
//     on<FetchWeatherEvent>((event, emit) async {
//       emit(WeatherLoading());
//
//       final result = await getCurrentWeather(event.cityName);
//
//       result.fold(
//             (failure) => emit(WeatherError(message: _mapFailureToMessage(failure))),
//             (weather) => emit(WeatherLoaded(weather: weather)),
//       );
//     });
//
//     // ✅ Event 2: Get weather by GPS location
//     on<FetchWeatherByLocationEvent>((event, emit) async {
//       emit(WeatherLoading());
//
//       final result = await getWeatherByLocation(NoParams());
//
//       result.fold(
//             (failure) => emit(WeatherError(message: _mapFailureToMessage(failure))),
//             (weather) => emit(WeatherLoaded(weather: weather)),
//       );
//     });
//   }
//
//   String _mapFailureToMessage(Failure failure) {
//     if (failure is ServerFailures) {
//       return failure.message;
//     } else if (failure is NoInternetFailures) {
//       return 'No internet connection. Please check your network.';
//     } else {
//       return 'Unexpected error occurred. Please try again.';
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/error/failures.dart';
import 'package:weather_app_bloc/core/usecase/usecase.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';

import '../../domain/usecase/getWeatherByLocation.dart';
import '../../domain/usecase/get_current_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetWeatherByLocation getWeatherByLocation;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getWeatherByLocation,
  }) : super(WeatherInitial()) {

    // ✅ Event 1: Get weather by city name
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());

      final result = await getCurrentWeather(event.cityName);

      result.fold(
            (failure) => emit(WeatherError(message: _mapFailureToMessage(failure))),
            (weather) => emit(WeatherLoaded(weather: weather)),
      );
    });

    // ✅ Event 2: Get weather by GPS location
    on<FetchWeatherByLocationEvent>((event, emit) async {
      emit(WeatherLoading());

      final result = await getWeatherByLocation(NoParams());

      result.fold(
            (failure) => emit(WeatherError(message: _mapFailureToMessage(failure))),
            (weather) => emit(WeatherLoaded(weather: weather)),
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