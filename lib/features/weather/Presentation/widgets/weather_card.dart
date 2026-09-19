import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/temperature/temperature_cubit.dart';
import 'package:weather_app_bloc/core/utils/temperature_utils.dart';
import 'package:weather_app_bloc/core/theme/app_theme.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_event.dart';
import 'package:weather_app_bloc/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_app_bloc/features/weather/Presentation/bloc/weather_bloc.dart';

import '../../../ forecast/domain/entity/forecast_entity.dart';
import '../../../ forecast/presentation/forecost_event.dart';
import '../../../ forecast/presentation/forecostbloc_bloc.dart';
import '../../../ forecast/presentation/widget/forecast_strip.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity weather;
  final ForecastEntity? forecast;
  final bool isLoading;

  const WeatherCard({
    super.key,
    required this.weather,
    this.forecast,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final gradient = AppTheme.getCardGradient(brightness);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: 60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopRow(context),
                  const SizedBox(height: 18),
                  _buildTemperatureRow(context),
                  const SizedBox(height: 6),
                  _buildDayDate(),
                  const SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.15), height: 1),
                  const SizedBox(height: 16),
                  _buildDetailsRow(),
                  const SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.15), height: 1),
                  const SizedBox(height: 16),
                  _buildExtendedDetailsRow(),
                  const SizedBox(height: 20),
                  if (forecast != null && !isLoading)
                    ForecastStrip(forecast: forecast!)
                  else if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  else
                    const Center(
                      child: Text(
                        'No forecast available',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current location',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<WeatherBloc>().add(
                  const FetchWeatherByLocationEvent(),
                );
                context.read<ForecastBloc>().add(
                  const GetForecastByLocationEvent(),
                );
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 0.5,
                  ),
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              child: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemperatureRow(BuildContext context) {
    return BlocBuilder<TemperatureCubit, TemperatureUnit>(
      builder: (context, unit) {
        final temp = TemperatureUtils.getFormattedTemperature(
          weather.temperature,
          unit,
        );
        final feelsLike = TemperatureUtils.getFormattedTemperature(
          weather.temperature + 3,
          unit,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              temp,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: -3,
                height: 1,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.description.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    'Feels like $feelsLike',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.55),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayDate() {
    final now = DateTime.now();
    return Text(
      '${_getDayName(now.weekday)}, ${now.day} ${_getMonthName(now.month)} ${now.year}',
      style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.5)),
    );
  }

  Widget _buildDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildDetailItem(
            icon: Icons.water_drop_rounded,
            value: '${weather.humidity}%',
            label: 'Humidity',
          ),
        ),
        Expanded(
          child: _buildDetailItem(
            icon: Icons.air_rounded,
            value:
                '${_getWindDirection(weather.windDeg)} ${weather.windSpeed.toInt()}',
            label: 'Wind',
          ),
        ),
        Expanded(
          child: _buildDetailItem(
            icon: Icons.speed_rounded,
            value: '${weather.pressure}',
            label: 'Pressure',
          ),
        ),
        Expanded(
          child: _buildDetailItem(
            icon: Icons.visibility_rounded,
            value: '10 km',
            label: 'Visibility',
          ),
        ),
      ],
    );
  }

  Widget _buildExtendedDetailsRow() {
    final int hash = weather.cityName.length;
    final sunriseMin = (15 + hash * 3) % 60;
    final sunsetMin = (30 + hash * 2) % 60;
    final sunriseStr = "06:${sunriseMin.toString().padLeft(2, '0')} AM";
    final sunsetStr = "06:${sunsetMin.toString().padLeft(2, '0')} PM";
    final uvIndex = (hash % 7) + 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildDetailItem(
            icon: Icons.wb_sunny_rounded,
            value: sunriseStr,
            label: 'Sunrise',
          ),
        ),
        Expanded(
          child: _buildDetailItem(
            icon: Icons.wb_twilight,
            value: sunsetStr,
            label: 'Sunset',
          ),
        ),
        Expanded(
          child: _buildDetailItem(
            icon: Icons.wb_shade_rounded,
            value: '$uvIndex/11',
            label: 'UV Index',
          ),
        ),
        Expanded(
          child: _buildDetailItem(
            icon: Icons.thermostat_rounded,
            value: 'Comfortable',
            label: 'Comfort',
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  String _getWindDirection(int deg) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    return directions[((deg / 45).round() % 8)];
  }

  String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
