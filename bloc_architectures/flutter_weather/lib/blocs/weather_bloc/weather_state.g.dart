// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState(this._type);

  factory WeatherState.weatherEmpty() = WeatherEmpty;

  factory WeatherState.weatherLoading() = WeatherLoading;

  factory WeatherState.weatherLoaded({@required Weather weather}) =
      WeatherLoaded;

  factory WeatherState.weatherError({@required String msg}) = WeatherError;

  final _WeatherState _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(WeatherEmpty) weatherEmpty,
      @required R Function(WeatherLoading) weatherLoading,
      @required R Function(WeatherLoaded) weatherLoaded,
      @required R Function(WeatherError) weatherError}) {
    switch (this._type) {
      case _WeatherState.WeatherEmpty:
        return weatherEmpty(this as WeatherEmpty);
      case _WeatherState.WeatherLoading:
        return weatherLoading(this as WeatherLoading);
      case _WeatherState.WeatherLoaded:
        return weatherLoaded(this as WeatherLoaded);
      case _WeatherState.WeatherError:
        return weatherError(this as WeatherError);
    }
  }

  @override
  List get props => null;
}

@immutable
class WeatherEmpty extends WeatherState {
  const WeatherEmpty._() : super(_WeatherState.WeatherEmpty);

  factory WeatherEmpty() {
    _instance ??= WeatherEmpty._();
    return _instance;
  }

  static WeatherEmpty _instance;
}

@immutable
class WeatherLoading extends WeatherState {
  const WeatherLoading._() : super(_WeatherState.WeatherLoading);

  factory WeatherLoading() {
    _instance ??= WeatherLoading._();
    return _instance;
  }

  static WeatherLoading _instance;
}

@immutable
class WeatherLoaded extends WeatherState {
  const WeatherLoaded({@required this.weather})
      : super(_WeatherState.WeatherLoaded);

  final Weather weather;

  @override
  String toString() => 'WeatherLoaded(weather:${this.weather})';
  @override
  List get props => [weather];
}

@immutable
class WeatherError extends WeatherState {
  const WeatherError({@required this.msg}) : super(_WeatherState.WeatherError);

  final String msg;

  @override
  String toString() => 'WeatherError(msg:${this.msg})';
  @override
  List get props => [msg];
}
