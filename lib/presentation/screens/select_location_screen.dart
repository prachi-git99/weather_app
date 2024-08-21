import 'package:my_weather_app/presentation/consts/consts.dart';
import 'package:my_weather_app/presentation/widgets/common_widgets/custom_sizedbox.dart';

import '../../application/blocs/weather/weather_bloc.dart';
import '../../application/blocs/weather/weather_event.dart';
import '../../domain/model/weather_cities.dart';
import '../../domain/repositories/get_all_cities.dart';
import '../widgets/form_widgets/custom_textfield.dart';

class SearchCityScreen extends StatefulWidget {
  final WeatherBloc weatherBloc;
  final GetAllCities getAllCities;

  SearchCityScreen({
    Key? key,
    required this.weatherBloc,
    required this.getAllCities,
  }) : super(key: key);

  @override
  _SearchCityScreenState createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final TextEditingController _cityController = TextEditingController();
  List<Cities> cities = [];

  void _fetchCities() async {
    if (_cityController.text.isNotEmpty) {
      try {
        final fetchedCities = await widget.getAllCities.fetchAllCities(
          cityName: _cityController.text,
        );
        setState(() {
          cities = fetchedCities;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error fetching cities. Please try again.'),
          ),
        );
      }
    }
  }

  void _onCitySelected(Cities city) {
    widget.weatherBloc
        .add(FetchWeatherByLocation(latitude: city.lat, longitude: city.long));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        iconTheme: const IconThemeData(color: white),
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
            const Text(
              "Enter City Name",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                fontFamily: poppins,
                fontSize: extraLargeFont,
              ),
            ),
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
                icon: const Icon(
                  Icons.search,
                  color: white,
                  size: 30,
                ),
                onPressed: _fetchCities,
              ),
              keyBoardType: TextInputType.text,
            ),
            mediumVerticalSizedBox(),
            if (cities.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      tileColor: white,
                      dense: true,
                      title: Text(
                        '${cities[index].cityName}, ${cities[index].country}, ${cities[index].country}',
                        style:
                            const TextStyle(color: black, fontFamily: poppins),
                      ),
                      onTap: () => _onCitySelected(cities[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
