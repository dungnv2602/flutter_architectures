import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_weather/repos/repos.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

/// The principle of using super_enum generated classes is simple
/// replace all if or switch statements by calling the
/// when method on the enum instance directly and
/// use factory constructors of the super type.
///
///
///

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  final WeatherRepository weatherRepository;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield* event.when(
      fetchWeather: (event) => mapFetchWeatherToState(event),
      refreshWeather: (event) => mapRefreshWeatherToState(event),
    );
  }

  Stream<WeatherState> mapFetchWeatherToState(FetchWeather event) async* {
    yield WeatherState.weatherLoading();
    final weather = await weatherRepository.getWeather(event.city);
    yield* weather.fold(
      (exception) async* {
        yield WeatherState.weatherError(msg: exception.toString());
      },
      (weather) async* {
        yield WeatherState.weatherLoaded(weather: weather);
      },
    );
  }

  Stream<WeatherState> mapRefreshWeatherToState(RefreshWeather event) async* {
    final weather = await weatherRepository.getWeather(event.city);
    yield* weather.fold(
      (exception) async* {
        yield state;
      },
      (weather) async* {
        yield WeatherState.weatherLoaded(weather: weather);
      },
    );
  }

  @override
  WeatherState get initialState => WeatherState.weatherEmpty();
}
