import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_weather/blocs/blocs.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:flutter_weather/repos/repos.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

/**
 * 
blocTest creates a new bloc-specific test case with the given description. blocTest will handle asserting that the bloc emits the expected states (in order) after act is executed. blocTest also handles ensuring that no additional states are emitted by closing the bloc stream before evaluating the expectation.

build should be used for all bloc initialization and preparation and must return the bloc under test.

act is an optional callback which will be invoked with the bloc under test and should be used to add events to the bloc.

expect is an Iterable<State> which the bloc under test is expected to emit after act is executed. 
 */

class MockWeatherRepo extends Mock implements WeatherRepository {}

void main() {
  group('WeatherBlocWithBlocTest', () {
    WeatherRepository weatherRepository;
    WeatherBloc weatherBloc;

    setUp(() {
      weatherRepository = MockWeatherRepo();
      weatherBloc = WeatherBloc(weatherRepository: weatherRepository);
    });

    group('FetchWeather', () {
      blocTest(
        'emits [WeatherEmpty, WeatherLoading, WeatherLoaded] when FetchWeather is added and getWeather is success',
        build: () {
          when(weatherRepository.getWeather('chicago')).thenAnswer(
            (_) => Future.value(
              Weather(
                temp: 10,
                condition: WeatherCondition.heavyCloud,
              ),
            ),
          );
          return weatherBloc;
        },
        act: (WeatherBloc bloc) async =>
            bloc.add(FetchWeather(city: 'chicago')),
        expect: [
          WeatherEmpty(),
          WeatherLoading(),
          WeatherLoaded(
            weather: Weather(
              temp: 10,
              condition: WeatherCondition.heavyCloud,
            ),
          ),
        ],
      );

      blocTest(
        'emits [WeatherEmpty, WeatherLoading, WeatherError] when FetchWeather is added and getWeather is failure',
        build: () {
          when(weatherRepository.getWeather('chicago')).thenThrow('error');
          return weatherBloc;
        },
        act: (WeatherBloc bloc) async =>
            bloc.add(FetchWeather(city: 'chicago')),
        expect: [
          WeatherEmpty(),
          WeatherLoading(),
          WeatherError(
            msg: 'error',
          ),
        ],
      );
    });
  });
}
