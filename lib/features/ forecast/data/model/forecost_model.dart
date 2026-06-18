import '../../domain/entity/forecast_entity.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.cityName,
    required super.forecastList,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final cityName = json['city']?['name'] ?? '';
    final Map<String, List<dynamic>> groupedByDay = {};

    if (json['list'] != null) {
      for (var item in json['list']) {
        final date = DateTime.parse(item['dt_txt']);
        final dayKey = '${date.year}-${date.month}-${date.day}';

        if (!groupedByDay.containsKey(dayKey)) {
          groupedByDay[dayKey] = [];
        }
        groupedByDay[dayKey]!.add(item);
      }
    }

    final forecastList = <ForecastItems>[];
    final days = groupedByDay.keys.toList().take(7);

    for (var dayKey in days) {
      final items = groupedByDay[dayKey]!;

      double minTemp = double.infinity;
      double maxTemp = double.negativeInfinity;
      String iconCode = '';
      String description = '';

      for (var item in items) {
        // ✅ Use .toDouble() safely on num
        final temp = (item['main']?['temp'] ?? 0).toDouble();
        final icon = (item['weather'] != null && item['weather'].isNotEmpty)
            ? item['weather'][0]['icon'] ?? ''
            : '';
        final desc = (item['weather'] != null && item['weather'].isNotEmpty)
            ? item['weather'][0]['description'] ?? ''
            : '';

        if (temp < minTemp) minTemp = temp;
        if (temp > maxTemp) maxTemp = temp;
        iconCode = icon;
        description = desc;
      }

      final date = DateTime.parse(items[0]['dt_txt']);
      final dayName = _getDayName(date.weekday);

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

  static String _getDayName(int weekday) {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[weekday % 7];
  }
}
