import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_bloc/features/%20forecast/data/model/forecost_model.dart';

void main() {
  test('parses hourly records and seven daily records from One Call data', () {
    final forecast = ForecastModel.fromJson({
      'daily': List.generate(
        8,
        (index) => {
          'dt': 1_700_000_000 + index * 86400,
          'temp': {'min': 8 + index, 'max': 18 + index},
          'weather': [
            {'icon': '01d', 'description': 'clear sky'},
          ],
        },
      ),
      'hourly': List.generate(
        14,
        (index) => {
          'dt': 1_700_000_000 + index * 3600,
          'temp': 15 + index,
          'weather': [
            {'icon': '02d', 'description': 'few clouds'},
          ],
        },
      ),
    }, cityNameOverride: 'London');

    expect(forecast.cityName, 'London');
    expect(forecast.forecastList, hasLength(7));
    expect(forecast.hourlyList, hasLength(12));
    expect(forecast.forecastList.first.maxTemp, 18);
    expect(forecast.hourlyList.first.temperature, 15);
  });

  test('keeps hourly intervals when parsing the legacy forecast response', () {
    final forecast = ForecastModel.fromJson({
      'city': {'name': 'Paris'},
      'list': [
        {
          'dt_txt': '2026-09-21 12:00:00',
          'main': {'temp': 20},
          'weather': [
            {'icon': '10d', 'description': 'light rain'},
          ],
        },
      ],
    });

    expect(forecast.cityName, 'Paris');
    expect(forecast.hourlyList, hasLength(1));
    expect(forecast.hourlyList.first.description, 'light rain');
  });
}
