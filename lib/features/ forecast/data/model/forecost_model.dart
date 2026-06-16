
import '../../domain/entity/forecast_entity.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.cityName,
    required super.forecastList,
  });

  // This factory converts API JSON response to our ForecastModel
  // Works for BOTH city search AND location search
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    // Extract city name (works for both city and location API calls)
    final cityName = json['city']['name'];

    // STEP 1: Group forecast items by day
    // API returns data every 3 hours (8 items per day)
    final Map<String, List<dynamic>> groupedByDay = {};

    for (var item in json['list']) {
      final date = DateTime.parse(item['dt_txt']);
      final dayKey = '${date.year}-${date.month}-${date.day}';

      if (!groupedByDay.containsKey(dayKey)) {
        groupedByDay[dayKey] = [];
      }
      groupedByDay[dayKey]!.add(item);
    }

    // STEP 2: Convert grouped data to daily forecast list
    final forecastList = <ForecastItems>[];
    final days = groupedByDay.keys.toList().take(7); // Max 7 days

    for (var dayKey in days) {
      final items = groupedByDay[dayKey]!;

      // STEP 3: Calculate min and max temperature for the day
      double minTemp = double.infinity;
      double maxTemp = double.negativeInfinity;
      String iconCode = '';
      String description = '';

      for (var item in items) {
        final temp = item['main']['temp'].toDouble();
        final icon = item['weather'][0]['icon'];
        final desc = item['weather'][0]['description'];

        if (temp < minTemp) minTemp = temp;
        if (temp > maxTemp) maxTemp = temp;
        iconCode = icon;
        description = desc;
      }

      // STEP 4: Get date and day name
      final date = DateTime.parse(items[0]['dt_txt']);
      final dayName = _getDayName(date.weekday);

      // STEP 5: Create daily forecast item
      forecastList.add(ForecastItems(
        dayName: dayName,
        date: date,
        maxTemp: maxTemp,
        minTemp: minTemp,
        iconCode: iconCode,
        description: description,
      ));
    }

    return ForecastModel(
      cityName: cityName,
      forecastList: forecastList,
    );
  }

  // Helper method to convert weekday number to short name
  static String _getDayName(int weekday) {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return days[weekday - 1];
  }
}