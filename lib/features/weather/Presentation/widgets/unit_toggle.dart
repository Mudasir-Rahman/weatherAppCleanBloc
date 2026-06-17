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
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildButton(
              context,
              '°C',
              TemperatureUnit.celsius,
              unit,
              isDark,
            ),
            const SizedBox(width: 6),
            _buildButton(
              context,
              '°F',
              TemperatureUnit.fahrenheit,
              unit,
              isDark,
            ),
          ],
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1B4F8A)
              : isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1B4F8A)
                : isDark
                ? Colors.white.withOpacity(0.2)
                : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? Colors.white
                : isDark
                ? Colors.white70
                : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}