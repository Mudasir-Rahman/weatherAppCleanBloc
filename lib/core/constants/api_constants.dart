class ApiConstants {
  // 1. The main server address (No keys or routes here)
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  // 2. Your secret password
  static const String apiKey = '3dcbfc90fa47b1d8b4e6470d8fc06e37';

  // 3. The specific routes (Just the paths)
  static const String weatherEndPoint = '/weather';
  static const String forecastEndPoint = '/forecast';
  static const String oneCallBaseUrl =
      'https://api.openweathermap.org/data/3.0';
  static const String oneCallEndPoint = '/onecall';
  static const String geocodingBaseUrl = 'https://api.openweathermap.org';
  static const String geocodingEndPoint = '/geo/1.0/direct';

  // Bonus: Base URL for weather icons
  static const String iconBaseUrl = 'https://openweathermap.org/img/wn';
}
