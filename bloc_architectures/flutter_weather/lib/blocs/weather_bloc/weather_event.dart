import 'package:super_enum/super_enum.dart';

part 'weather_event.g.dart';

@superEnum
enum _WeatherEvent {
  @Data(fields: [
    DataField('city', String),
  ])
  FetchWeather,
  @Data(fields: [
    DataField('city', String),
  ])
  RefreshWeather,
}
