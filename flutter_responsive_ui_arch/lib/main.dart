import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'views/home/home_view.dart';


void main() {
//  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context, nullOk: true);
    return PlatformApp(
      title: 'Flutter Demo',
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.of(context)?.locale,
      supportedLocales: const [
        Locale("en"),
        Locale("fr", "FR"),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      android: (_) => MaterialAppData(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mediaQuery?.platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      ),
      ios: (_) => CupertinoAppData(
        theme: CupertinoThemeData(
          brightness: mediaQuery?.platformBrightness,
        ),
      ),
      home: HomeView(),
    );
  }
}