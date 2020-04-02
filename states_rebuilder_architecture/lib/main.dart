import 'package:flutter/material.dart';
import 'data/data.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'pages/weather_search_page.dart';
import 'state/weather_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Injector(
        inject: [
          Inject<WeatherStore>(() => WeatherStore(FakeWeatherRepository())),
        ],
        builder: (_) => WeatherSearchPage(),
      ),
    );
  }
}
