import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';
import 'repos/repos.dart';
import 'widgets/widgets.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final weatherRepo = WeatherRepository(
    weatherApiClient: WeatherApiClientImpl(
      httpClient: http.Client(),
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (_) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          builder: (context) => SettingsBloc(),
        ),
      ],
      child: MyApp(weatherRepository: weatherRepo),
    ),
  );
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  final WeatherRepository weatherRepository;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: state.theme,
          home: BlocProvider<WeatherBloc>(
            builder: (_) => WeatherBloc(weatherRepository: weatherRepository),
            child: MyHomePage(),
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Completer<void> _refreshCompleter;

  @override
  void dispose() {
    _refreshCompleter?.complete();
    _refreshCompleter = null;
    super.dispose();
  }

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoaded) {
              BlocProvider.of<ThemeBloc>(context)
                  .add(WeatherChanged(condition: state.weather.condition));

              _refreshCompleter?.complete();
              _refreshCompleter = Completer<void>();
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherEmpty) {
                return Center(child: Text('Please Select a Location'));
              }
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherError) {
                return Text(
                  state.msg,
                  style: TextStyle(color: Colors.red),
                );
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;
                return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return GradientContainer(
                      color: themeState.color,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<WeatherBloc>(context).add(
                            RefreshWeather(city: state.weather.location),
                          );
                          return _refreshCompleter.future;
                        },
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(
                                child: Location(location: weather.location),
                              ),
                            ),
                            Center(
                              child: LastUpdated(dateTime: weather.lastUpdated),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                child: CombinedWeatherTemperature(
                                  weather: weather,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
