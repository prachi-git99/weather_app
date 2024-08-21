import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/model/weather.dart';
import '../../../domain/repositories/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation);
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeather(event.cityName);

      await _saveWeatherToLocal(weather);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      final weather = await _loadWeatherFromLocal();
      if (weather != null) {
        emit(WeatherLoaded(weather: weather));
      } else {
        emit(WeatherError(message: e.toString()));
      }
    }
  }

  @override
  void onChange(Change<WeatherState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(state);
  }

  void _onFetchWeatherByLocation(
      FetchWeatherByLocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.fetchWeatherByLocation(
          event.latitude, event.longitude);
      await _saveWeatherToLocal(weather);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      final weather = await _loadWeatherFromLocal();
      if (weather != null) {
        emit(WeatherLoaded(weather: weather));
      } else {
        emit(WeatherError(message: e.toString()));
      }
    }
  }

  Future<void> _saveWeatherToLocal(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('weather', jsonEncode(weather.toJson()));
  }

  Future<Weather?> _loadWeatherFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final weatherString = prefs.getString('weather');
    if (weatherString != null) {
      return Weather.fromJson(jsonDecode(weatherString));
    }
    return null;
  }
}
