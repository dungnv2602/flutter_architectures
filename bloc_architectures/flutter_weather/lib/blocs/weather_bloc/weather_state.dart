import 'package:equatable/equatable.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  const WeatherError({@required this.msg}) : assert(msg != null);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  final Weather weather;

  @override
  List<Object> get props => [weather];
}
