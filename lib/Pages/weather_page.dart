import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

  String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) return 'assets/clearsky.json';

  switch (mainCondition.toLowerCase()) {
    case 'clear sky':
      return 'assets/clearsky.json';
    case 'few clouds':
      return 'assets/fewclouds.json';
    case 'scattered clouds':
      return 'assets/scattered clouds.json';
    case 'broken clouds':
      return 'assets/broken clouds.json';
    case 'shower rain':
      return 'assets/showerrain.json';
    case 'rain':
      return 'assets/rain.json';
    case 'thunderstorm':
      return 'assets/thunderstorm.json';
    case 'snow':
      return 'assets/snow.json';  
    case 'mist':
      return 'assets/mist.json';
    default:
      return 'assets/clearsky.json';  
    
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

          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          Text('${_weather?.temperature.round()}°C'),

          Text(_weather?.mainCondition ?? "")
        ],
      ),
    ),
  );
}
}