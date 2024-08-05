import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather_app/presentation/consts/consts.dart';
import 'package:my_weather_app/presentation/widgets/home_widgets/display_details_widget.dart';

import '../../application/blocs/weather/weather_bloc.dart';
import '../../application/blocs/weather/weather_event.dart';
import '../../application/blocs/weather/weather_state.dart';
import '../../domain/model/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/services/location_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherRepository weatherRepository = WeatherRepository();
  final LocationService locationService = LocationService();
  late WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    weatherBloc = WeatherBloc(weatherRepository: weatherRepository);
    _fetchWeatherByLocation();
  }

  void _fetchWeatherByLocation() async {
    try {
      final location = await locationService.getLocation();
      weatherBloc.add(FetchWeatherByLocation(
        latitude: location.latitude!,
        longitude: location.longitude!,
      ));
    } catch (e) {
      weatherBloc.add(FetchWeather(
          cityName:
              'London')); // Fallback to a default city in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => weatherBloc,
      child: Scaffold(
        backgroundColor: black,
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial || state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return _buildWeatherInfo(state.weather);
            } else if (state is WeatherError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(Weather weather) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-3, -0.3),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF673AB7),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -1.2),
            child: Container(
              height: 300,
              width: 600,
              decoration: BoxDecoration(
                color: Color(0xFFFFAB40),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
          SingleChildScrollView(
              child: displayDetailsWidget(context: context, weather: weather))
        ],
      ),
    );
  }

  @override
  void dispose() {
    weatherBloc.close();
    super.dispose();
  }
}
