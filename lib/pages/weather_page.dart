import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/weather_model.dart';
import '../service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('742fc8e5371aaddd5992db497605e448');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      Weather weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/weather_sunny.json';
    }

    switch (mainCondition) {
      case "clouds":
        return 'assets/weather_cloudy.json';
      case "mist":
        return 'assets/cloudy.json';
      case "smoke":
        return 'assets/cloudy.json';
      case "haze":
        return 'assets/cloudy.json';
      case "dust":
        return 'assets/cloudy.json';
      case "fog":
        return 'assets/cloudy.json';
      case "rain":
        return 'assets/rainy.json';
      case "drizzle":
        return 'assets/rainy.json';
      case "shower rain":
        return 'assets/rainy.json';
      case "thunderstorm":
        return 'assets/weather_thunder.json';
      case "clear":
        return 'assets/weather_sunny.json';
      default:
        return 'assets/weather_sunny.json';
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
      backgroundColor: const Color(0xFFFAF9F6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 0),
            Text(
              _weather?.cityName ?? "Loading city...",
              style: GoogleFonts.ubuntu(
                color: const Color(0xFF757575),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            Text(
              '${_weather?.temperature.round()}°',
              style: GoogleFonts.ubuntu(
                color: const Color(0xFF4A4A4A),
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
