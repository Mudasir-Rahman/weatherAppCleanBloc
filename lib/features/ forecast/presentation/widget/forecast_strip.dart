import 'package:flutter/material.dart';

import '../../domain/entity/forecast_entity.dart';
import 'forecast_item.dart';

class ForecastStrip extends StatelessWidget {
  final ForecastEntity forecast;

  const ForecastStrip({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: forecast.forecastList.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isToday = index == 0;
        return Expanded(
          child: ForecastItem(forecast: item, isToday: isToday),
        );
      }).toList(),
    );
  }
}