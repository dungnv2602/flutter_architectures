import 'package:flutter_weather/models/models.dart';
import 'package:meta/meta.dart';

import 'weather_api_client.dart';

class WeatherRepositoryVanilla {
  WeatherRepositoryVanilla({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  final WeatherApiClient weatherApiClient;

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    final weather = await weatherApiClient.fetchWeather(locationId);
    return weather;
  }
}
