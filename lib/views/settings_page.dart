// views/settings_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/weather_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<WeatherController>(context, listen: false).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode == true
            ? Color.fromARGB(255, 42, 41, 41)
            : Color.fromARGB(255, 44, 82, 148),
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: Provider.of<WeatherController>(context).isDarkMode,
              onChanged: (value) {
                Provider.of<WeatherController>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
