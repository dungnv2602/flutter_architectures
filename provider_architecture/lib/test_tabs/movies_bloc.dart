import 'package:flutter/material.dart';

class MoviesBloc extends ChangeNotifier {
  List<Movie> _result;
  BlocState _state = BlocState.idle;
  bool _mounted = true;
  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void _setState(BlocState state) {
    if (!mounted) return;
    _state = state;
    notifyListeners();
  }

  BlocState get state => _state;

  Future<void> getMoviesWithGenre(Genre genre) async {
    print('MoviesBloc - getMoviesWithGenre: ${genre.name}');
    _setState(BlocState.loading);
    await Future.delayed(_delayTime);
    _result = List.generate(
        20, (index) => Movie(id: index + 1, name: (index + 1).toString()));
    _setState(BlocState.loaded);
  }

  List<Movie> get result => _result;

  bool get loading => _state == BlocState.loading;
}

enum BlocState {
  idle,
  loading,
  loaded,
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

const _delayTime = Duration(seconds: 2);
