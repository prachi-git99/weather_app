// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../application/blocs/auth_bloc/auth_bloc.dart';
// // import '../../application/blocs/auth_bloc/auth_event.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Home'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.exit_to_app),
// //             onPressed: () {
// //               BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
// //             },
// //           ),
// //         ],
// //       ),
// //       body: const Text("W E A T H E R   H O M E",
// //           style: TextStyle(
// //               color: Colors.blueAccent, fontSize: 40, fontFamily: "Poppins")),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../application/blocs/weather/weather_bloc.dart';
// import '../../application/blocs/weather/weather_event.dart';
// import '../../application/blocs/weather/weather_state.dart';
// import '../../domain/model/weather.dart';
// import '../../domain/repositories/weather_repository.dart';
// import '../../domain/services/location_service.dart';
//
// class HomeScreen extends StatelessWidget {
//   final WeatherRepository weatherRepository = WeatherRepository();
//   final LocationService locationService = LocationService();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => WeatherBloc(weatherRepository: weatherRepository),
//       child: Scaffold(
//         appBar: AppBar(title: Text('Weather App')),
//         body: BlocBuilder<WeatherBloc, WeatherState>(
//           builder: (context, state) {
//             if (state is WeatherInitial) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () async {
//                         final location = await locationService.getLocation();
//                         BlocProvider.of<WeatherBloc>(context)
//                             .add(FetchWeatherByLocation(
//                           latitude: location.latitude!,
//                           longitude: location.longitude!,
//                         ));
//                       },
//                       child: Text('Fetch Weather by Location'),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is WeatherLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is WeatherLoaded) {
//               return _buildWeatherInfo(state.weather);
//             } else if (state is WeatherError) {
//               return Center(child: Text(state.message));
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWeatherInfo(Weather weather) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('City: ${weather.cityName}', style: TextStyle(fontSize: 20)),
//           Text('Temperature: ${weather.temperature}°C',
//               style: TextStyle(fontSize: 20)),
//           Text('Humidity: ${weather.humidity}%',
//               style: TextStyle(fontSize: 20)),
//           Text('Wind Speed: ${weather.windSpeed} m/s',
//               style: TextStyle(fontSize: 20)),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/blocs/auth_bloc/auth_bloc.dart';
import '../../application/blocs/auth_bloc/auth_event.dart';
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
        appBar: AppBar(
          title: const Text('W E A T H E R'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
              },
            ),
          ],
        ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('City: ${weather.cityName}', style: TextStyle(fontSize: 20)),
          Text('Temperature: ${weather.temperature}°C',
              style: TextStyle(fontSize: 20)),
          Text('Humidity: ${weather.humidity}%',
              style: TextStyle(fontSize: 20)),
          Text('Wind Speed: ${weather.windSpeed} m/s',
              style: TextStyle(fontSize: 20)),
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
