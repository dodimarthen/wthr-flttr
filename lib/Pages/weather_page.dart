import 'package:flutter/material.dart';
import 'package:wppy/services/weather_service.dart';
import 'package:wppy/models/weather_model.dart';
import 'package:wppy/services/api.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } 
    
    catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center( // Wrapping the Column with Center
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centering the content vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Centering the content horizontally
        children: [
          Text(_weather?.cityName ?? "City Undetected"),
          Text('${_weather?.temperature.round()}°C'),
        ],
      ),
    ),
  );
}
}