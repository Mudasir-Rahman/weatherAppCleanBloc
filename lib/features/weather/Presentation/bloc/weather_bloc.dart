// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:weather_app_bloc/features/weather/presentation/bloc/weather_event.dart';
// import 'package:weather_app_bloc/features/weather/presentation/bloc/weather_state.dart';
//
// import '../../domain/usecase/get_current_weather.dart';
//
// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   // 1. Inject the UseCase
//   final GetCurrentWeather getCurrentWeather;
//
//   WeatherBloc({required this.getCurrentWeather}) : super(WeatherInitial()) {
//     // 2. Listen specifically to FetchWeatherEvent
//     on<FetchWeatherEvent>(_onFetchWeather);
//   }
//
//   // 3. The Logic
//   Future<void> _onFetchWeather(FetchWeatherEvent event, Emitter<WeatherState> emit) async {
//     // Step A: Tell the UI to show a loading spinner
//     emit(WeatherLoading());
//
//     // Step B: Ask the Domain layer for the weather data
//     final result = await getCurrentWeather(event.cityName);
//
//     // Step C: Handle the Either<Failure, WeatherEntity> result
//     result.fold(
//       // If it's a Left (Failure), emit the Error state
//           (failure) => emit(WeatherError(message: failure.message)),
//
//       // If it's a Right (Success), emit the Loaded state with the data
//           (weather) => emit(WeatherLoaded(weather: weather)),
//     );
//   }
// }