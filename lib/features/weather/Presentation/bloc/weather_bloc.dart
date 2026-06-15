import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_event.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_state.dart';
import 'package:weather_app_bloc/features/weather/domain/usecase/get_current_weather.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecase/getWeatherByLocation.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;
  final GetWeatherByLocation getWeatherByLocation;

  WeatherBloc({
    required this.getCurrentWeather,
    required this.getWeatherByLocation,
  }) : super(WeatherInitial()) {

    // Event 1: Search by city name
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      final failureOrWeather = await getCurrentWeather(event.cityName);
      failureOrWeather.fold(
            (failure) => emit(WeatherError(message: failure.message)),
            (weather) => emit(WeatherLoaded(weather: weather)),
      );
    });

    // Event 2: Get weather by GPS location
    on<FetchWeatherByLocationEvent>((event, emit) async {
      emit(WeatherLoading());
      final failureOrWeather = await getWeatherByLocation(NoParams());
      failureOrWeather.fold(
            (failure) => emit(WeatherError(message: failure.message)),
            (weather) => emit(WeatherLoaded(weather: weather)),
      );
    });
  }
}