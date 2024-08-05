import 'package:my_weather_app/presentation/consts/consts.dart';
import 'package:my_weather_app/presentation/widgets/common_widgets/custom_sizedbox.dart';

import '../../application/blocs/weather/weather_bloc.dart';
import '../../application/blocs/weather/weather_event.dart';
import '../widgets/form_widgets/custom_textfield.dart';

class SearchCityScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();
  final WeatherBloc weatherBloc;
  SearchCityScreen({super.key, required this.weatherBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        iconTheme: IconThemeData(color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(appAllPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/world_map_bg.png",
              color: white,
            ),
            mediumVerticalSizedBox(),
            const Text("Enter City Name",
                style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w600,
                    fontFamily: poppins,
                    fontSize: extraLargeFont)),
            largeVerticalSizedBox(),
            customTextField(
                controller: _cityController,
                hintText: 'Location',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: white,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      weatherBloc
                          .add(FetchWeather(cityName: _cityController.text));
                      Navigator.pop(context); // Close the search screen
                    }
                  },
                ),
                keyBoardType: TextInputType.text),
            mediumVerticalSizedBox(),

          ],
        ),
      ),
    );
  }
}
