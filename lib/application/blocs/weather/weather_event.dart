import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String cityName;

  const FetchWeather({required this.cityName});

  @override
  List<Object> get props => [cityName];
}

class FetchWeatherByLocation extends WeatherEvent {
  final double latitude;
  final double longitude;

  const FetchWeatherByLocation(
      {required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}

class FetchWeatherCities extends WeatherEvent {
  final String cityName;

  const FetchWeatherCities({required this.cityName});

  @override
  List<Object> get props => [cityName];
}
