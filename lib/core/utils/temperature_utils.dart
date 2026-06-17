
import 'package:weather_app_bloc/core/temperature/temperature_cubit.dart';

/// Utility class for temperature conversions and formatting
class TemperatureUtils {
  /// Convert Celsius to Fahrenheit
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  /// Convert Fahrenheit to Celsius
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  /// Get formatted temperature based on selected unit
  static String getFormattedTemperature(double celsius, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      final fahrenheit = celsiusToFahrenheit(celsius);
      return '${fahrenheit.toInt()}°F';
    } else {
      return '${celsius.toInt()}°C';
    }
  }

  /// Get formatted temperature with + sign for positive values
  static String getFormattedTemperatureWithSign(double celsius, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      final fahrenheit = celsiusToFahrenheit(celsius);
      final value = fahrenheit.toInt();
      return '${value > 0 ? '+' : ''}$value°F';
    } else {
      final value = celsius.toInt();
      return '${value > 0 ? '+' : ''}$value°C';
    }
  }

  /// Get temperature string without degree symbol
  static String getTemperatureValue(double celsius, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      return celsiusToFahrenheit(celsius).toInt().toString();
    } else {
      return celsius.toInt().toString();
    }
  }

  /// Get the degree symbol
  static String getDegreeSymbol(TemperatureUnit unit) {
    return unit == TemperatureUnit.fahrenheit ? '°F' : '°C';
  }

  /// Convert temperature and return as double
  static double convertTemperature(double celsius, TemperatureUnit unit) {
    if (unit == TemperatureUnit.fahrenheit) {
      return celsiusToFahrenheit(celsius);
    } else {
      return celsius;
    }
  }
}