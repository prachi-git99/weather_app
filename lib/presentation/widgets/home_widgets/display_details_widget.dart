import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/domain/model/weather.dart';

import '../../../application/blocs/auth_bloc/auth_bloc.dart';
import '../../../application/blocs/auth_bloc/auth_event.dart';
import '../../../application/blocs/weather/weather_bloc.dart';
import '../../consts/consts.dart';
import '../../screens/select_location_screen.dart';
import '../common_widgets/custom_sizedbox.dart';
import 'custom_tiles.dart';
import 'getWeatherIcon.dart';

Widget displayDetailsWidget(
    {required BuildContext context,
    required Weather weather,
    required WeatherBloc weatherBloc}) {
  final DateFormat formatter = DateFormat('hh:mm a');
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(appAllPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: white,
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            },
          ),
        ),
        Row(
          children: [
            Text(
              '📍 ${weather.cityName}',
              style: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize: mediumFont),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                  color: white),
              onPressed: () async {
                final cityName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchCityScreen(weatherBloc: weatherBloc),
                  ),
                );
                // if (cityName != null) {
                //   weatherBloc.add(FetchWeather(cityName: cityName));
                // }
              },
            ),
          ],
        ),
        getWeatherIcon(weather.description, size),
        Center(
          child: Text(
            '${weather.temperature.round()}°C',
            style: const TextStyle(
                color: white,
                fontSize: largestFont,
                fontFamily: poppins,
                fontWeight: FontWeight.w600),
          ),
        ),
        Center(
          child: Text(
            weather.description.toUpperCase(),
            style: const TextStyle(
                color: white,
                fontSize: extraLargeFont,
                fontWeight: FontWeight.w500,
                fontFamily: poppins),
          ),
        ),
        largeVerticalSizedBox(),
        customTiles(title: 'Humidity', value: '${weather.humidity}', unit: '%'),
        smallVerticalSizedBox(),
        customTiles(
            title: 'Wind Speed', value: '${weather.windSpeed}', unit: 'm/s'),
        smallVerticalSizedBox(),
        customTiles(
            title: 'Max Temperature', value: '${weather.maxTemp}', unit: '°C'),
        smallVerticalSizedBox(),
        customTiles(
            title: 'Min Temperature', value: '${weather.minTemp}', unit: '°C'),
        smallVerticalSizedBox(),
        customTiles(
            title: 'Sunrise',
            value: formatter.format(weather.sunrise),
            unit: ''),
        smallVerticalSizedBox(),
        customTiles(
            title: 'Sunset', value: formatter.format(weather.sunset), unit: ''),
        largeVerticalSizedBox(),
      ],
    ),
  );
}
