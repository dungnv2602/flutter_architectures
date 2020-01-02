// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent(this._type);

  factory WeatherEvent.fetchWeather({@required String city}) = FetchWeather;

  factory WeatherEvent.refreshWeather({@required String city}) = RefreshWeather;

  final _WeatherEvent _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(FetchWeather) fetchWeather,
      @required R Function(RefreshWeather) refreshWeather}) {
    switch (this._type) {
      case _WeatherEvent.FetchWeather:
        return fetchWeather(this as FetchWeather);
      case _WeatherEvent.RefreshWeather:
        return refreshWeather(this as RefreshWeather);
    }
  }

  @override
  List get props => null;
}

@immutable
class FetchWeather extends WeatherEvent {
  const FetchWeather({@required this.city}) : super(_WeatherEvent.FetchWeather);

  final String city;

  @override
  String toString() => 'FetchWeather(city:${this.city})';
  @override
  List get props => [city];
}

@immutable
class RefreshWeather extends WeatherEvent {
  const RefreshWeather({@required this.city})
      : super(_WeatherEvent.RefreshWeather);

  final String city;

  @override
  String toString() => 'RefreshWeather(city:${this.city})';
  @override
  List get props => [city];
}
