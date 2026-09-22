import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  static const _favoriteCitiesKey = 'favorite_cities';
  final List<String> _favoriteCities = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadData();
  }

  Future<void> _loadFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    final savedCities = preferences.getStringList(_favoriteCitiesKey);
    if (!mounted) return;

    setState(() {
      _favoriteCities
        ..clear()
        ..addAll(savedCities ?? ['London', 'New York', 'Paris', 'Tokyo']);
    });
  }

  Future<void> _saveFavorites() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_favoriteCitiesKey, _favoriteCities);
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

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, weatherState) {
        // Dynamic background gradient based on weather condition
        LinearGradient gradient = AppTheme.getBackgroundGradient(
          isDark ? Brightness.dark : Brightness.light,
        );
        String currentCity = '';
        if (weatherState is WeatherLoaded) {
          gradient = AppTheme.getWeatherBackgroundGradient(
            weatherState.weather.iconCode,
            isDark ? Brightness.dark : Brightness.light,
          );
          currentCity = weatherState.weather.cityName;
        }

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
                    _buildFavoritesRow(currentCity),
                    const SizedBox(height: 12),
                    const UnitToggle(),
                    const SizedBox(height: 12),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          if (currentCity.isNotEmpty) {
                            _searchCity(currentCity);
                          } else {
                            _loadData();
                          }
                          await Future.delayed(
                            const Duration(milliseconds: 500),
                          );
                        },
                        color: const Color(0xFF1B4F8A),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: _buildMainContent(weatherState, isDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(WeatherState weatherState, bool isDark) {
    if (weatherState is WeatherLoading) {
      return const SizedBox(
        height: 400,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: isDark ? Colors.white70 : Colors.grey.shade600,
              ),
              const SizedBox(height: 8),
              Text(
                weatherState.message,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey.shade600,
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
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
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
              style: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesRow(String currentCity) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isFavorite =
        currentCity.isNotEmpty &&
        _favoriteCities.any(
          (city) => city.toLowerCase() == currentCity.toLowerCase(),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Favorite Cities',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            if (currentCity.isNotEmpty)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isFavorite) {
                      _favoriteCities.removeWhere(
                        (city) =>
                            city.toLowerCase() == currentCity.toLowerCase(),
                      );
                    } else {
                      _favoriteCities.add(currentCity);
                    }
                  });
                  _saveFavorites();
                },
                child: Row(
                  children: [
                    Icon(
                      isFavorite
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isFavorite ? 'Saved' : 'Add to Favorites',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _favoriteCities.length,
            itemBuilder: (context, index) {
              final city = _favoriteCities[index];
              final bool isSelected =
                  currentCity.toLowerCase() == city.toLowerCase();
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(city),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      _searchCity(city);
                    }
                  },
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : Colors.black87),
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  selectedColor: const Color(0xFF1B4F8A),
                  backgroundColor: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.04),
                  checkmarkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
