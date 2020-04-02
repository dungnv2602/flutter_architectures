import 'dart:math';

Future<List<Movie>> mockMovies(Genre genre) async {
  await Future.delayed(_delayTime);
  return List.generate(
    Random().nextInt(20),
    (index) => Movie(id: index + 1, name: (index + 1).toString(), genre: genre),
  );
}

class Movie {
  Movie({
    this.id,
    this.name,
    this.genre,
  });

  num id;
  String name;
  Genre genre;
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

const _delayTime = Duration(seconds: 1);
