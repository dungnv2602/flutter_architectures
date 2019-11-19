import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_weather/repos/repos.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  final WeatherRepository weatherRepository;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (error) {
        yield WeatherError(msg: error.toString());
      }
    }
    if (event is RefreshWeather) {
      try {
        final weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (error) {
        yield state;
      }
    }
  }

  @override
  WeatherState get initialState => WeatherEmpty();
}
