import 'dart:async';

import 'package:bloc/bloc.dart';

import './blocs.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  @override
  MoviesState get initialState => Idle();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    yield* event.map(
      fetchMovies: (event) => fetchMovies(event),
      fetchMoviesByGenre: (event) => fetchMoviesByGenre(event),
    );
  }

  Stream<MoviesState> fetchMoviesByGenre(FetchMoviesByGenre event) async* {
    yield Loading();
    final movies = await mockMovies(event.genre);
    yield Loaded(movies);
  }

  Stream<MoviesState> fetchMovies(FetchMovies event) async* {
    yield Loading();
    await Future.delayed(const Duration(seconds: 1));
    yield Error('not supported');
  }
}
