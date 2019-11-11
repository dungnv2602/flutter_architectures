import 'package:flutter/material.dart';
import 'package:flutter_architectures/generated/i18n.dart';
import 'package:flutter_architectures/i18n_architecture/views/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // Our localization
        S.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // List all of the app's supported locales here
      supportedLocales: S.delegate.supportedLocales,
      // Returns a locale which will be used by the app
      localeResolutionCallback: S.delegate.resolution(fallback: const Locale('en', ''), withCountry: false),
      // generate title
      onGenerateTitle: (BuildContext context) => S.of(context).title,
      // home
      home: SplashScreen(),
    );
  }
}
