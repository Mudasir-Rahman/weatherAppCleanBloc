import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/theme/app_theme.dart';
import 'package:weather_app_bloc/core/theme/theme_cubit.dart';

// ✅ Fixed casing: Use 'Presentation' (uppercase P) to match your directory name and avoid type mismatch errors.
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_event.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_state.dart';

import '../../../ forecast/presentation/forecost_event.dart';
import '../../../ forecast/presentation/forecost_state.dart';
import '../../../ forecast/presentation/forecostbloc_bloc.dart';
import '../widgets/search_bar.dart';
import '../widgets/unit_toggle.dart';
import '../widgets/weather_card.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<WeatherBloc>().add(const FetchWeatherByLocationEvent());
    context.read<ForecastBloc>().add(const GetForecastByLocationEvent());
  }

  void _searchCity(String cityName) {
    if (cityName.isNotEmpty) {
      context.read<WeatherBloc>().add(FetchWeatherEvent(cityName: cityName));
      context.read<ForecastBloc>().add(
        GetForecastByCityEvent(cityName: cityName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradient = AppTheme.getBackgroundGradient(
      isDark ? Brightness.dark : Brightness.light,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 12),
                WeatherSearchBar(onSearch: _searchCity),
                const SizedBox(height: 12),
                const UnitToggle(),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    builder: (context, weatherState) {
                      if (weatherState is WeatherLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (weatherState is WeatherLoaded) {
                        return BlocBuilder<ForecastBloc, ForecostState>(
                          builder: (context, forecastState) {
                            return WeatherCard(
                              weather: weatherState.weather,
                              forecast: forecastState is ForecostLoaded
                                  ? forecastState.forecast
                                  : null,
                              isLoading: forecastState is ForecostLoading,
                            );
                          },
                        );
                      }
                      if (weatherState is WeatherError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: isDark
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                weatherState.message,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: _loadData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1B4F8A),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_queue,
                              size: 64,
                              color: isDark ? Colors.white54 : Colors.grey,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap location button\nfor weather',
                              style: TextStyle(
                                color: isDark ? Colors.white54 : Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SkyCast',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black87,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Live weather dashboard',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : Colors.black54,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.04),
              ),
            ),
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: isDark ? Colors.white : Colors.black87,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}
