import 'package:flutter_bloc/flutter_bloc.dart';

/// Enum for temperature units
enum TemperatureUnit { celsius, fahrenheit }

/// Cubit to manage temperature unit state
class TemperatureCubit extends Cubit<TemperatureUnit> {
  TemperatureCubit() : super(TemperatureUnit.celsius);

  /// Toggle between Celsius and Fahrenheit
  void toggleUnit() {
    emit(state == TemperatureUnit.celsius
        ? TemperatureUnit.fahrenheit
        : TemperatureUnit.celsius);
  }

  /// Set to Celsius
  void setCelsius() {
    emit(TemperatureUnit.celsius);
  }

  /// Set to Fahrenheit
  void setFahrenheit() {
    emit(TemperatureUnit.fahrenheit);
  }

  /// Check if current unit is Celsius
  bool get isCelsius => state == TemperatureUnit.celsius;

  /// Check if current unit is Fahrenheit
  bool get isFahrenheit => state == TemperatureUnit.fahrenheit;
}