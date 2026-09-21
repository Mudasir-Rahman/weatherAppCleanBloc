import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/temperature/temperature_cubit.dart';
import 'package:weather_app_bloc/core/utils/temperature_utils.dart';
import '../../domain/entity/forecast_entity.dart';

class HourlyForecastStrip extends StatelessWidget {
  final ForecastEntity forecast;

  const HourlyForecastStrip({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    if (forecast.hourlyList.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.hourlyList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = forecast.hourlyList[index];
          return Container(
            width: 72,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
              color: index == 0
                  ? Colors.white.withOpacity(0.2)
                  : Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: index == 0
                  ? Border.all(color: Colors.white.withOpacity(0.3))
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  index == 0 ? 'Now' : _formatTime(item.time),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${item.iconCode}.png',
                  width: 30,
                  height: 30,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.cloud_outlined,
                    color: Colors.white70,
                    size: 24,
                  ),
                ),
                BlocBuilder<TemperatureCubit, TemperatureUnit>(
                  builder: (context, unit) => Text(
                    TemperatureUtils.getFormattedTemperatureWithSign(
                      item.temperature,
                      unit,
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour == 0
        ? 12
        : time.hour > 12
        ? time.hour - 12
        : time.hour;
    final suffix = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour $suffix';
  }
}
