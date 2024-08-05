import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather.dart';

class WeatherRepository {
  final String apiKey = '4358ea7b971da34f69107b37d02c9024';

  Future<Weather> fetchWeather(String cityName) async {
    print(cityName);
    final response = await http.get(Uri.parse(
        // "https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=10&appid=$apiKey"
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
    print(response.body);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Weather> fetchWeatherByLocation(
      double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
