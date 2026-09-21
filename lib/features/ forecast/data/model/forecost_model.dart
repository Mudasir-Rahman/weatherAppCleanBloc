import '../../domain/entity/forecast_entity.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.cityName,
    required super.forecastList,
    required super.hourlyList,
  });

  factory ForecastModel.fromJson(
    Map<String, dynamic> json, {
    String? cityNameOverride,
  }) {
    final cityName = cityNameOverride ?? json['city']?['name'] ?? '';
    final hourlyList = _parseHourlyItems(json);

    if (json['daily'] is List) {
      return ForecastModel(
        cityName: cityName,
        forecastList: _parseDailyItems(json['daily'] as List),
        hourlyList: hourlyList,
      );
    }

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

      forecastList.add(
        ForecastItems(
          dayName: dayName,
          date: date,
          maxTemp: maxTemp,
          minTemp: minTemp,
          iconCode: iconCode,
          description: description,
        ),
      );
    }

    return ForecastModel(
      cityName: cityName,
      forecastList: forecastList,
      hourlyList: hourlyList,
    );
  }

  static List<HourlyForecastItem> _parseHourlyItems(Map<String, dynamic> json) {
    final items = json['hourly'] is List
        ? json['hourly'] as List
        : json['list'] as List? ?? [];
    return items.take(12).map((item) {
      final time = item['dt'] is num
          ? DateTime.fromMillisecondsSinceEpoch(
              (item['dt'] as num).toInt() * 1000,
              isUtc: true,
            ).toLocal()
          : DateTime.parse(item['dt_txt'] as String);
      return HourlyForecastItem(
        time: time,
        temperature: _temperature(item),
        iconCode: _icon(item),
        description: _description(item),
      );
    }).toList();
  }

  static List<ForecastItems> _parseDailyItems(List items) {
    return items.take(7).map((item) {
      final date = DateTime.fromMillisecondsSinceEpoch(
        (item['dt'] as num).toInt() * 1000,
        isUtc: true,
      ).toLocal();
      final temp = item['temp'] as Map<String, dynamic>? ?? {};
      return ForecastItems(
        dayName: _getDayName(date.weekday),
        date: date,
        maxTemp: (temp['max'] ?? 0).toDouble(),
        minTemp: (temp['min'] ?? 0).toDouble(),
        iconCode: _icon(item),
        description: _description(item),
      );
    }).toList();
  }

  static double _temperature(Map<String, dynamic> item) {
    final main = item['main'] as Map<String, dynamic>?;
    final temp = main?['temp'] ?? item['temp'] ?? 0;
    return (temp as num).toDouble();
  }

  static String _icon(Map<String, dynamic> item) {
    final weather = item['weather'] as List?;
    return weather != null && weather.isNotEmpty
        ? weather.first['icon'] ?? ''
        : '';
  }

  static String _description(Map<String, dynamic> item) {
    final weather = item['weather'] as List?;
    return weather != null && weather.isNotEmpty
        ? weather.first['description'] ?? ''
        : '';
  }

  static String _getDayName(int weekday) {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return days[weekday % 7];
  }
}
