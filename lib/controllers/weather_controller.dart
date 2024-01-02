import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherController extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  List<WeatherModel> weatherData = [];
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  String cityame = '';

  WeatherController() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    prefs.setString('cityName', cityame);
  }

  Future<void> getCurrentCityWeather() async {
    final data = await _weatherService.getCurrentCityWeather();
    final weatherModel = WeatherModel(
      cityName: data['name'],
      temperature: data['main']['temp'].toDouble() - 273,
      description: data['weather'][0]['description'],
      main: data['weather'][0]['main'],
      lat: data['coord']['lat'],
      feels_like: data['main']['feels_like'].toDouble() - 273,
      temp_min: data['main']['temp_min'],
      temp_max: data['main']['temp_max'],
      pressure: data['main']['pressure'],
      humidity: data['main']['humidity'],
      visibility: data['main']['visibility'],
      speed: data['wind']['speed'],
      deg: data['wind']['deg'],
      sunrise: data['sys']['sunrise'].toInt(),
      sunset: data['sys']['sunset'],
      timezone: data['timezone'],
    );
    weatherData.add(weatherModel);
    notifyListeners();
  }

  Future<void> getWeatherData(String city) async {
    final data = await _weatherService.getWeatherData(city);
    final weatherModel = WeatherModel(
      cityName: data['name'],
      temperature: data['main']['temp'].toDouble() - 273,
      description: data['weather'][0]['description'],
      main: data['weather'][0]['main'],
      lat: data['coord']['lat'],
      feels_like: data['main']['feels_like'].toDouble() - 273,
      temp_min: data['main']['temp_min'].toDouble() - 273,
      temp_max: data['main']['temp_max'].toDouble() - 273,
      pressure: data['main']['pressure'],
      humidity: data['main']['humidity'],
      visibility: data['visibility'].toDouble() / 1000,
      speed: data['wind']['speed'],
      deg: data['wind']['deg'],
      sunrise: data['sys']['sunrise'].toInt(),
      sunset: data['sys']['sunset'],
      timezone: data['timezone'],
    );
    print(data);
    weatherData.add(weatherModel);
    notifyListeners();
  }
}
