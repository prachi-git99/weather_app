class Cities {
  final String cityName;
  final double lat;
  final double long;
  final String country;
  final String state;

  Cities({
    required this.cityName,
    required this.lat,
    required this.long,
    required this.country,
    required this.state,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      cityName: json['name'],
      lat: json['lat'].toDouble(),
      long: json['lon'].toDouble(),
      country: json['country'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": cityName,
      "lat": lat,
      "lon": long,
      "country": country,
      "state": state
    };
  }
}
