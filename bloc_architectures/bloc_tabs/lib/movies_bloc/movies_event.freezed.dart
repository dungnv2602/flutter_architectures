// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'movies_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

mixin _$MoviesEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result fetchMovies(),
    @required Result fetchMoviesByGenre(Genre genre),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fetchMovies(),
    Result fetchMoviesByGenre(Genre genre),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fetchMovies(FetchMovies value),
    @required Result fetchMoviesByGenre(FetchMoviesByGenre value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fetchMovies(FetchMovies value),
    Result fetchMoviesByGenre(FetchMoviesByGenre value),
    @required Result orElse(),
  });
}

class _$FetchMovies with DiagnosticableTreeMixin implements FetchMovies {
  const _$FetchMovies();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoviesEvent.fetchMovies()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MoviesEvent.fetchMovies'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is FetchMovies);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result fetchMovies(),
    @required Result fetchMoviesByGenre(Genre genre),
  }) {
    assert(fetchMovies != null);
    assert(fetchMoviesByGenre != null);
    return fetchMovies();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fetchMovies(),
    Result fetchMoviesByGenre(Genre genre),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetchMovies != null) {
      return fetchMovies();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fetchMovies(FetchMovies value),
    @required Result fetchMoviesByGenre(FetchMoviesByGenre value),
  }) {
    assert(fetchMovies != null);
    assert(fetchMoviesByGenre != null);
    return fetchMovies(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fetchMovies(FetchMovies value),
    Result fetchMoviesByGenre(FetchMoviesByGenre value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetchMovies != null) {
      return fetchMovies(this);
    }
    return orElse();
  }
}

abstract class FetchMovies implements MoviesEvent {
  const factory FetchMovies() = _$FetchMovies;
}

class _$FetchMoviesByGenre
    with DiagnosticableTreeMixin
    implements FetchMoviesByGenre {
  const _$FetchMoviesByGenre(this.genre) : assert(genre != null);

  @override
  final Genre genre;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoviesEvent.fetchMoviesByGenre(genre: $genre)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MoviesEvent.fetchMoviesByGenre'))
      ..add(DiagnosticsProperty('genre', genre));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is FetchMoviesByGenre &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ genre.hashCode;

  @override
  _$FetchMoviesByGenre copyWith({
    Object genre = freezed,
  }) {
    assert(genre != null);
    return _$FetchMoviesByGenre(
      genre == freezed ? this.genre : genre as Genre,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result fetchMovies(),
    @required Result fetchMoviesByGenre(Genre genre),
  }) {
    assert(fetchMovies != null);
    assert(fetchMoviesByGenre != null);
    return fetchMoviesByGenre(genre);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fetchMovies(),
    Result fetchMoviesByGenre(Genre genre),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetchMoviesByGenre != null) {
      return fetchMoviesByGenre(genre);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fetchMovies(FetchMovies value),
    @required Result fetchMoviesByGenre(FetchMoviesByGenre value),
  }) {
    assert(fetchMovies != null);
    assert(fetchMoviesByGenre != null);
    return fetchMoviesByGenre(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fetchMovies(FetchMovies value),
    Result fetchMoviesByGenre(FetchMoviesByGenre value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fetchMoviesByGenre != null) {
      return fetchMoviesByGenre(this);
    }
    return orElse();
  }
}

abstract class FetchMoviesByGenre implements MoviesEvent {
  const factory FetchMoviesByGenre(Genre genre) = _$FetchMoviesByGenre;

  Genre get genre;

  FetchMoviesByGenre copyWith({Genre genre});
}
