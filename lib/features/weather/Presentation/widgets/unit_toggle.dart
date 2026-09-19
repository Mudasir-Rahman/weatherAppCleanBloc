import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/core/temperature/temperature_cubit.dart';

class UnitToggle extends StatelessWidget {
  const UnitToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<TemperatureCubit, TemperatureUnit>(
      builder: (context, unit) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.08) : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.12)
                    : Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildButton(
                  context,
                  '°C',
                  TemperatureUnit.celsius,
                  unit,
                  isDark,
                ),
                _buildButton(
                  context,
                  '°F',
                  TemperatureUnit.fahrenheit,
                  unit,
                  isDark,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    TemperatureUnit buttonUnit,
    TemperatureUnit currentUnit,
    bool isDark,
  ) {
    final isSelected = buttonUnit == currentUnit;

    return GestureDetector(
      onTap: () => context.read<TemperatureCubit>().toggleUnit(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B4F8A) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : isDark
                ? Colors.white70
                : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
