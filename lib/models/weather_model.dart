// models/weather_model.dart
class WeatherModel {
  final dynamic cityName;
  final dynamic temperature;
  final dynamic description;
  final dynamic main;
  final dynamic lat;
  final dynamic feels_like;
  final dynamic temp_min;
  final dynamic temp_max;
  final dynamic pressure;
  final dynamic humidity;
  final dynamic visibility;
  final dynamic speed;
  final dynamic deg;
  final dynamic sunrise;
  final dynamic sunset;
  final dynamic timezone;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.main,
    required this.lat,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.speed,
    required this.deg,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
  });
}
