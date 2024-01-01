import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as k;

class WeatherService {
  late var position;
  late LocationPermission permission;

  getCurrentCityWeather() async {
    Geolocator.openLocationSettings();
    permission = await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (position != null) {
      print('Lat:${position.latitude}, Long:${position.longitude}');

      var client = http.Client();
      var uri =
          '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
      print(uri.toString());
      var url = Uri.parse(uri);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var data = response.body;
        print(data);

        return json.decode(response.body);
      } else {
        throw Exception(response.statusCode);
      }
    } else {
      throw Exception('Data unavailable');
    }
  }

  Future<Map<String, dynamic>> getWeatherData(String city) async {
    final response =
        await http.get(Uri.parse('${k.domain}q=$city&appid=${k.apiKey}'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data!');
    }
  }
}
