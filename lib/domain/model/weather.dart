class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String country;
  final double minTemp; // New field for minimum temperature
  final double maxTemp; // New field for maximum temperature
  final DateTime sunrise; // New field for sunrise
  final DateTime sunset; // New field for sunset

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.country,
    required this.windSpeed,
    required this.description,
    required this.minTemp, // Initialize new field
    required this.maxTemp, // Initialize new field
    required this.sunrise, // Initialize new field
    required this.sunset, // Initialize new field
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['main'],
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      country: json['sys']['country'],
      sunrise:
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {
        'temp': temperature,
        'humidity': humidity,
        'temp_min': minTemp,
        'temp_max': maxTemp,
      },
      'wind': {
        'speed': windSpeed,
      },
      'weather': [
        {'main': description}
      ],
      'sys': {
        'country': country,
        'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
        'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
      },
    };
  }
}
