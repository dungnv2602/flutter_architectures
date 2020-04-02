import 'package:flutter/material.dart';

typedef BlocFuncion<T> = Future<T> Function();

class Bloc<T> extends ChangeNotifier {
  T _result;
  BlocState _state = BlocState.idle;

  Future<void> invokeFunction(BlocFuncion<T> func) async {
    if (!loading) {
      _setState(BlocState.loading);
      _result = await func();
      _setState(BlocState.loaded);
    }
  }

  T get result => _result;

  bool get loading => _state == BlocState.loading;

  BlocState get state => _state;

  void _setState(BlocState state) {
    _state = state;
    notifyListeners();
  }
}

enum BlocState {
  idle,
  loading,
  loaded,
}

Future<List<Movie>> mockMovie() async {
  await Future.delayed(_delayTime);
  return List.generate(
      20, (index) => Movie(id: index + 1, name: (index + 1).toString()));
}

class Movie {
  Movie({
    this.id,
    this.name,
  });

  num id;
  String name;
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  num id;
  String name;
}

List<Genre> genres = List.generate(
    20, (index) => Genre(id: index + 1, name: (index + 1).toString()));

const _delayTime = Duration(seconds: 2);
