import 'package:super_enum/super_enum.dart';
import 'package:flutter_weather/models/models.dart';

part 'weather_state.g.dart';

@superEnum
enum _WeatherState {
  @object
  WeatherEmpty,
  @object
  WeatherLoading,
  @Data(fields: [
    DataField('weather', Weather),
  ])
  WeatherLoaded,
  @Data(fields: [
    DataField('msg', String),
  ])
  WeatherError,
}
