import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../env.dart';
import '../model/weather_cities.dart';

class GetAllCities {
  GetAllCities();

  final String? apiKey = WEATHER_MAP_API_KEY;

  Future<List<Cities>> fetchAllCities({required String cityName}) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=10&appid=$apiKey'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((city) => Cities.fromJson(city)).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
