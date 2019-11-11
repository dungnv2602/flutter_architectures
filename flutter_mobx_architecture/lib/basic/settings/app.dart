import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'preference_service.dart';
import 'settings_store.dart';

class App extends StatelessWidget {
  final SharedPreferences _sharedPreferences;

  const App(this._sharedPreferences);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferenceService>(builder: (_) => PreferenceService(_sharedPreferences)),
        ProxyProvider<PreferenceService, SettingStore>(
          builder: (_, preferenceService, __) => SettingStore(preferenceService),
        ),
      ],
      child: Consumer<SettingStore>(
        builder: (_, store, __) => Observer(
          builder: (_) => MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: store.useDarkMode ? Brightness.dark : Brightness.light,
            ),
            home: Home(),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<SettingStore>(
        builder: (_, store, __) => Observer(
          builder: (_) => SwitchListTile(
            value: store.useDarkMode,
            title: const Text('Use dark mode'),
            onChanged: (value) {
              store.setDarkMode(value);
            },
          ),
        ),
      ),
    );
  }
}
