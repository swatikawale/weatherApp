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

  //  factory WeatherModel.fromJson(Map<String, dynamic> json) {
  //   return WeatherModel(
  //     cityName: json['name'] as String,
  //     temperature: json['temp'] as String,
  //     description:json['description'] as String,
  //   );
  //  }

  // Map<String, dynamic> toJson() =>
  // {
  //       "name": cityName,
  //       "temp": temperature,
  //       "description": description,
  // };
}

// // controllers/weather_controller.dart
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import '../models/weather_model.dart';
// import '../services/weather_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class WeatherController extends ChangeNotifier {
//   final WeatherService _weatherService = WeatherService();

//   List<WeatherModel> weatherData = [];
//    bool _isDarkMode = false;

//   bool get isDarkMode => _isDarkMode;

// String cityname = '';

//   WeatherController() {
//     _loadTheme();
//     _loadcityweather();
//   //  _loadcityweather();
//   }

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }

//   void _loadTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _isDarkMode = prefs.getBool('isDarkMode') ?? false;
//     notifyListeners();
//   }

//   void _saveTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkMode', _isDarkMode);
//   }

//   // List<String> _isLoadedcityweather = [];
//   // List<String> get isLoadedcityweather => _isLoadedcityweather;

//    void _loadcityweather() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//    // _isLoadedcityweather = prefs.getStringList('isLoadedcityweather') ?? [];
//      String getPrefs = prefs.getString('savedata')!;

//     notifyListeners();
//   }

//   // void _savecityweather() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   prefs.setStringList('isLoadedcityweather', _isLoadedcityweather);
//   // }

// WeatherModel userModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

// String userModelToJson(WeatherModel data) => json.encode(data.toJson());

//     Future<WeatherModel> getCurrentCityWeather() async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//     final data = await _weatherService.getCurrentCityWeather();
//     final weatherModel = WeatherModel(
//       cityName: data['name'],
//       temperature: data['main']['temp'],
//       description: data['weather'][0]['description'],
//     );

//     weatherData.add(weatherModel);
//     Map<String, dynamic> dataUser = jsonDecode(userModelToJson(weatherModel));
//         userEncode = jsonEncode(dataUser);

//       prefs.setString('savedata', userEncode);
//       String getPrefs = prefs.getString('savedata')!;
//     notifyListeners();
//     return weatherModel;
//   }

//  dynamic userEncode=[];
//   Future<WeatherModel> getWeatherData(String city) async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//     final data = await _weatherService.getWeatherData(city);
//     final weatherModel = WeatherModel(
//       cityName: data['name'],
//       temperature: data['main']['temp'].toDouble(),
//       description: data['weather'][0]['description'],
//     );
//     // print(data);
//     // weatherData.add(weatherModel);
//     // _isLoadedcityweather=weatherData.cast<String>();
//     // _savecityweather();

//  //WeatherModel userResponse = WeatherModel.fromJson(jsonDecode(data[].toString()));

//      Map<String, dynamic> dataUser = jsonDecode(userModelToJson(weatherModel));
//         userEncode = jsonEncode(dataUser);

//       prefs.setString('savedata', userEncode);
//       // LET'S SEE OUR DATA THAT WE SAVE TO LOCAL STORAGE
//       String getPrefs = prefs.getString('savedata')!;
//     //  log('SAVE TO LOCAL $getPrefs');

//     weatherData.add(weatherModel);
//     // _isLoadedcityweather=weatherData.cast<String>();
//     //     _savecityweather();
//     notifyListeners();
//     return weatherModel;
//   }

// }
