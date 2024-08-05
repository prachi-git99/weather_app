import 'package:flutter/material.dart';

Widget getWeatherIcon(String code, var size) {
  Map<String, String> iconMap = {
    "Thunderstorm": "assets/images/thunder.png",
    "Rain": "assets/images/rainy.png",
    "Snow": "assets/images/snow.png",
    "Mist": "assets/images/humidity.png",
    "Haze": "assets/images/humidity.png",
    "Smoke": "assets/images/humidity.png",
    "Clear": "assets/images/sunny.png",
    "Few Clouds": "assets/images/cloudy.png",
    "Scattered Clouds": "assets/images/cloudy.png",
    "Clouds": "assets/images/cloudy.png",
  };

  String defaultIconPath = "assets/images/clear.png";

  return Center(
      child: SizedBox(
          height: size.height * 0.27,
          child: Image.asset(iconMap[code] ?? defaultIconPath)));
}
