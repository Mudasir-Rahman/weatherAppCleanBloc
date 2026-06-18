import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/temperature/temperature_cubit.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_event.dart';
import 'package:weather_app_bloc/features/weather/Presentation/widgets/weather_forecast_screen.dart';
import 'features/ forecast/presentation/forecostbloc_bloc.dart';
import 'features/ forecast/presentation/forecost_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => TemperatureCubit()),
        BlocProvider(
          create: (context) => di.sl<WeatherBloc>()
            ..add(const FetchWeatherByLocationEvent()),
        ),
        BlocProvider(
          create: (context) => di.sl<ForecastBloc>()
            ..add(const GetForecastByLocationEvent()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Weather App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: const WeatherForecastScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
