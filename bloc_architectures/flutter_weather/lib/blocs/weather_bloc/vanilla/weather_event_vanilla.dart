import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  const FetchWeather({@required this.city}) : assert(city != null);

  final String city;

  @override
  List<Object> get props => [city];
}

class RefreshWeather extends WeatherEvent {
  final String city;

  const RefreshWeather({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
