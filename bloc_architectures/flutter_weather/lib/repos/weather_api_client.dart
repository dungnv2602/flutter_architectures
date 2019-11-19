import 'package:flutter_weather/models/models.dart';

abstract class WeatherApiClient {
  Future<int> getLocationId(String city);

  Future<Weather> fetchWeather(int locationId);
}
