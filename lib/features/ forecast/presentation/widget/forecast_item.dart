import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/temperature/temperature_cubit.dart';
import 'package:weather_app_bloc/core/utils/temperature_utils.dart';
import 'package:weather_app_bloc/features/%20forecast/domain/entity/forecast_entity.dart';


class ForecastItem extends StatelessWidget {
  final  ForecastItems forecast;
  final bool isToday;

  const ForecastItem({
    super.key,
    required this.forecast,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: isToday
            ? Colors.white.withOpacity(0.2)
            : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: isToday
            ? Border.all(color: Colors.white.withOpacity(0.3), width: 0.5)
            : null,
      ),
      child: Column(
        children: [
          Text(
            isToday ? 'Today' : forecast.dayName,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 5),
          Image.network(
            'https://openweathermap.org/img/wn/${forecast.iconCode}.png',
            width: 24,
            height: 24,
            color: Colors.white,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.cloud,
                color: Colors.white,
                size: 20,
              );
            },
          ),
          const SizedBox(height: 5),
          BlocBuilder<TemperatureCubit, TemperatureUnit>(
            builder: (context, unit) {
              final temp = TemperatureUtils.getFormattedTemperatureWithSign(
                forecast.maxTemp,
                unit,
              );
              return Text(
                temp,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}