import 'package:flutter/material.dart';

import '../../domain/entity/forecast_entity.dart';
import 'forecast_item.dart';

class ForecastStrip extends StatelessWidget {
  final ForecastEntity forecast;

  const ForecastStrip({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.forecastList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) => SizedBox(
          width: 70,
          child: ForecastItem(
            forecast: forecast.forecastList[index],
            isToday: index == 0,
          ),
        ),
      ),
    );
  }
}
