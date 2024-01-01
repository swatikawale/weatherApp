import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/weather_controller.dart';
import 'views/home_page.dart';
import 'views/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WeatherController(),
        child: Consumer<WeatherController>(
            builder: (context, themeProvider, child) {
          return MaterialApp(
             debugShowCheckedModeBanner: false,
            title: 'Flutter Weather App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
            routes: {
              '/settings': (context) => const SettingsPage(),
            },
          );
        }));
  }
}
