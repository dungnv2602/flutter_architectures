import 'package:flutter/material.dart';
import 'package:flutter_architectures/i18n_architecture/minimal/locales.dart';
import 'package:flutter_architectures/i18n_architecture/views/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      localeResolutionCallback: (deviceLocale, supportedLocales) {
//        if (this.locale == null) {
//          this.locale = deviceLocale;
//        }
//        return this.locale;
//      },

      // List all of the app's supported locales here
      supportedLocales: LocaleString.supportedLocales.map((language) => Locale(language, '')),
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // Our localization
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization of basic text for Cupertino widgets
        GlobalCupertinoLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          // Check if the current device locale is supported
          if (supportedLocale.countryCode == locale.countryCode && supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      // generate title
      onGenerateTitle: (BuildContext context) => translatableText(context, 'title'),
      // home
      home: SplashScreen(),
    );
  }
}
