import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/views/detail_page.dart';
import '../controllers/weather_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  bool isLoaded = false;

  String cityname = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cityname == ''
          ? Provider.of<WeatherController>(context, listen: false)
              .getCurrentCityWeather()
              .onError((error, stackTrace) =>
                  showsnackbar(context, error.toString()))
          : Provider.of<WeatherController>(context, listen: false)
              .getWeatherData(cityname)
              .onError((error, stackTrace) =>
                  showsnackbar(context, error.toString()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late bool isError = false;

  @override
  Widget build(BuildContext context) {
    final weatherController = Provider.of<WeatherController>(context);

    bool isDarkMode =
        Provider.of<WeatherController>(context, listen: false).isDarkMode;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode == true
              ? const Color.fromARGB(255, 42, 41, 41)
              : const Color.fromARGB(255, 44, 82, 148),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
            ),
            child: Center(
              child: TextFormField(
                onFieldSubmitted: (String s) {
                  setState(() {
                    cityname = s.trim();
                    Provider.of<WeatherController>(context, listen: false)
                        .getWeatherData(s)
                        .onError((error, stackTrace) =>
                            showsnackbar(context, error.toString()));
                    isLoaded = false;
                    controller.clear();
                  });
                },
                controller: controller,
                cursorColor: Colors.white,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search city',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 25,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
            child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Column(
                        children: [
                          Image(
                            image:
                                const AssetImage('images/weather-forecast.png'),
                            width: MediaQuery.of(context).size.width * 0.30,
                          ),
                          const Text("Weather", style: TextStyle(fontSize: 30)),
                          Divider(
                            color: isDarkMode == true
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: isDarkMode == true
                                ? Colors.white
                                : Colors.black,
                          ),
                          ListTile(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/settings'),
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.settings),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Settings",
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ))
                        ],
                      )
                    ]))),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Settings',
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
          child: const Icon(Icons.settings, size: 28),
        ),
        body: Container(
            decoration: isDarkMode == true
                ? const BoxDecoration(color: Color.fromARGB(255, 42, 41, 41))
                : const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0.9, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 34, 78, 153),
                        Color.fromARGB(255, 27, 72, 150),
                        Color.fromARGB(255, 2, 51, 135),
                        Color.fromARGB(255, 2, 57, 155),
                        Color.fromARGB(255, 2, 77, 185),
                        Color.fromARGB(108, 1, 1, 218),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                  ),
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: weatherController.weatherData.isEmpty
                      ? Center(
                          child: isError != true
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: isDarkMode == true
                                            ? Colors.transparent
                                                .withOpacity(0.1)
                                            : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent
                                                .withOpacity(0.1),
                                            offset: const Offset(1, 2),
                                            blurRadius: 3,
                                            spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: const Text(
                                        'Give permission to access the device location!',
                                        style: TextStyle(fontSize: 18),
                                      ))))
                      : ListView.builder(
                          itemCount: weatherController.weatherData.length,
                          itemBuilder: (context, index) {
                            final weather =
                                weatherController.weatherData[index];
                            return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 0.0),
                                child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      color: isDarkMode == true
                                          ? Colors.transparent.withOpacity(0.1)
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade900,
                                          offset: const Offset(1, 2),
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: ListTile(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
                                                      weatherdata: weather,
                                                    )),
                                          ),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.pin_drop,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              Text(
                                                weather.cityName.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${weather.temperature.toString().substring(0, 2)}°C',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 34,
                                                      color: isDarkMode == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                '${weather.main}',
                                                style: TextStyle(
                                                  color: isDarkMode == true
                                                      ? Colors.grey
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))));
                          },
                        )),
            ])));
  }

  showsnackbar(context, message) {
    setState(() {
      isError = true;
    });
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(fontSize: 18),
    )));
  }
}
