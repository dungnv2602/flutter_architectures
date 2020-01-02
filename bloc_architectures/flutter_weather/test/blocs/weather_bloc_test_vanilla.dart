// import 'package:flutter_weather/blocs/blocs.dart';
// import 'package:flutter_weather/models/models.dart';
// import 'package:flutter_weather/repos/repos.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';

// class MockWeatherRepo extends Mock implements WeatherRepository {}

// main() {
//   group('Weather Bloc', () {
//     MockWeatherRepo weatherRepo;
//     WeatherBloc weatherBloc;

//     setUp(() {
//       weatherRepo = MockWeatherRepo();
//       weatherBloc = WeatherBloc(weatherRepository: weatherRepo);
//     });

//     tearDown(() {
//       weatherBloc?.close();
//     });

//     test('correct initState', () {
//       expect(weatherBloc.initialState, WeatherEmpty());
//     });

//     group('Fetch', () {
//       test(
//           'emit [WeatherEmpty, WeatherLoading, WeatherLoaded] when weather repo returns weather',
//           () {
//         final Weather weather = Weather(
//           condition: WeatherCondition.clear,
//           formattedCondition: 'Clear',
//           minTemp: 15,
//           maxTemp: 20,
//           locationId: 0,
//           location: 'Chicago',
//           lastUpdated: DateTime(2019),
//         );

//         when(weatherRepo.getWeather('chicago'))
//             .thenAnswer((_) => Future.value(weather));

//         expectLater(
//           weatherBloc,
//           emitsInOrder(
//             [
//               WeatherEmpty(),
//               WeatherLoading(),
//               WeatherLoaded(weather: weather),
//             ],
//           ),
//         );
//         weatherBloc.add(FetchWeather(city: 'chicago'));
//       });

//       test(
//           'emit [WeatherEmpty, WeatherLoading, WeatherError] when weather repo throws error',
//           () {
//         final errorMsg = 'Error';

//         when(weatherRepo.getWeather('chicago')).thenThrow(errorMsg);

//         expectLater(
//           weatherBloc,
//           emitsInOrder(
//             [
//               WeatherEmpty(),
//               WeatherLoading(),
//               WeatherError(msg: errorMsg),
//             ],
//           ),
//         );
//         weatherBloc.add(FetchWeather(city: 'chicago'));
//       });
//     });

//     group('Refresh', () {
//       test(
//           'emit [WeatherEmpty, WeatherLoaded] when weather repo returns weather',
//           () {
//         final Weather weather = Weather(
//           condition: WeatherCondition.clear,
//           formattedCondition: 'Clear',
//           minTemp: 15,
//           maxTemp: 20,
//           locationId: 0,
//           location: 'Chicago',
//           lastUpdated: DateTime(2019),
//         );

//         when(weatherRepo.getWeather('chicago'))
//             .thenAnswer((_) => Future.value(weather));

//         expectLater(
//           weatherBloc,
//           emitsInOrder(
//             [
//               WeatherEmpty(),
//               WeatherLoaded(weather: weather),
//             ],
//           ),
//         );
//         weatherBloc.add(RefreshWeather(city: 'chicago'));
//       });

//       test('emit [WeatherEmpty] when weather repo throws error', () {
//         final errorMsg = 'Error';

//         when(weatherRepo.getWeather('chicago')).thenThrow(errorMsg);

//         expectLater(
//           weatherBloc,
//           emitsInOrder(
//             [
//               WeatherEmpty(),
//             ],
//           ),
//         );
//         weatherBloc.add(FetchWeather(city: 'chicago'));
//       });
//     });
//   });
// }
