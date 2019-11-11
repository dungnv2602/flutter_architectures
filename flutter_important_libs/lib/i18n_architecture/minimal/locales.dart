import 'package:flutter/widgets.dart';
import 'package:flutter_architectures/i18n_architecture/minimal/app_localizations.dart';

abstract class LocaleString {
  static const supportedLocales = ['en', 'vi'];
  static const titleSplashPage1 = 'titleSplashPage1';
  static const titleSplashPage2 = 'titleSplashPage2';
  static const titleSplashPage3 = 'titleSplashPage3';
  static const connectSplashButton = 'connectSplashButton';
  static const homePage = 'homePage';
  static const settings = 'settings';
  static const changeLanguage = 'changeLanguage';
  static const english = 'english';
  static const vietnamese = 'vietnamese';
}

String translatableText(BuildContext context, String localeString) {
  return AppLocalizations.of(context).translate(localeString);
}
