import 'package:flutter_weather/models/models.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'failure.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  final WeatherApiClient weatherApiClient;

  Future<Either<Exception, Weather>> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    try {
      final weather = await weatherApiClient.fetchWeather(locationId);
      return Right(weather);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
