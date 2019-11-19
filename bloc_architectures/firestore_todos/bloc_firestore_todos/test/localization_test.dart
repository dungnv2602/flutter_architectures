import 'package:bloc_firestore_todos/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterBlocLocalizations', () {
    FlutterBlocLocalizations localizations;
    FlutterBlocLocalizationsDelegate delegate;

    setUp(() {
      localizations = FlutterBlocLocalizations();
      delegate = FlutterBlocLocalizationsDelegate();
    });

    test('App Title is correct', () {
      expect(localizations.appTitle, 'Flutter Todos');
    });

    test('shouldReload returns false', () {
      expect(delegate.shouldReload(null), false);
    });

    test('isSupported returns true for english', () {
      expect(delegate.isSupported(Locale('en', 'US')), true);
    });
    test('isSupported returns false for french', () {
      expect(delegate.isSupported(Locale('fr', 'FR')), false);
    });
  });
}
