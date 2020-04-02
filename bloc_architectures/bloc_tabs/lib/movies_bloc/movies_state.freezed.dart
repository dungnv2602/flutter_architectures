// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'movies_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

mixin _$MoviesState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idle(),
    @required Result loading(),
    @required Result loaded(List<Movie> movies),
    @required Result error(String msg),
  });

  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idle(),
    Result loading(),
    Result loaded(List<Movie> movies),
    Result error(String msg),
    @required Result orElse(),
  });

  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idle(Idle value),
    @required Result loading(Loading value),
    @required Result loaded(Loaded value),
    @required Result error(Error value),
  });

  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idle(Idle value),
    Result loading(Loading value),
    Result loaded(Loaded value),
    Result error(Error value),
    @required Result orElse(),
  });
}

class _$Idle with DiagnosticableTreeMixin implements Idle {
  const _$Idle();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoviesState.idle()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MoviesState.idle'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Idle);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idle(),
    @required Result loading(),
    @required Result loaded(List<Movie> movies),
    @required Result error(String msg),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return idle();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idle(),
    Result loading(),
    Result loaded(List<Movie> movies),
    Result error(String msg),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idle(Idle value),
    @required Result loading(Loading value),
    @required Result loaded(Loaded value),
    @required Result error(Error value),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return idle(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idle(Idle value),
    Result loading(Loading value),
    Result loaded(Loaded value),
    Result error(Error value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class Idle implements MoviesState {
  const factory Idle() = _$Idle;
}

class _$Loading with DiagnosticableTreeMixin implements Loading {
  const _$Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoviesState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MoviesState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idle(),
    @required Result loading(),
    @required Result loaded(List<Movie> movies),
    @required Result error(String msg),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idle(),
    Result loading(),
    Result loaded(List<Movie> movies),
    Result error(String msg),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idle(Idle value),
    @required Result loading(Loading value),
    @required Result loaded(Loaded value),
    @required Result error(Error value),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idle(Idle value),
    Result loading(Loading value),
    Result loaded(Loaded value),
    Result error(Error value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements MoviesState {
  const factory Loading() = _$Loading;
}

class _$Loaded with DiagnosticableTreeMixin implements Loaded {
  const _$Loaded(this.movies) : assert(movies != null);

  @override
  final List<Movie> movies;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoviesState.loaded(movies: $movies)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MoviesState.loaded'))
      ..add(DiagnosticsProperty('movies', movies));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loaded &&
            (identical(other.movies, movies) ||
                const DeepCollectionEquality().equals(other.movies, movies)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ movies.hashCode;

  @override
  _$Loaded copyWith({
    Object movies = freezed,
  }) {
    assert(movies != null);
    return _$Loaded(
      movies == freezed ? this.movies : movies as List<Movie>,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idle(),
    @required Result loading(),
    @required Result loaded(List<Movie> movies),
    @required Result error(String msg),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(movies);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idle(),
    Result loading(),
    Result loaded(List<Movie> movies),
    Result error(String msg),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(movies);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idle(Idle value),
    @required Result loading(Loading value),
    @required Result loaded(Loaded value),
    @required Result error(Error value),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idle(Idle value),
    Result loading(Loading value),
    Result loaded(Loaded value),
    Result error(Error value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements MoviesState {
  const factory Loaded(List<Movie> movies) = _$Loaded;

  List<Movie> get movies;

  Loaded copyWith({List<Movie> movies});
}

class _$Error with DiagnosticableTreeMixin implements Error {
  const _$Error(this.msg) : assert(msg != null);

  @override
  final String msg;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoviesState.error(msg: $msg)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MoviesState.error'))
      ..add(DiagnosticsProperty('msg', msg));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error &&
            (identical(other.msg, msg) ||
                const DeepCollectionEquality().equals(other.msg, msg)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ msg.hashCode;

  @override
  _$Error copyWith({
    Object msg = freezed,
  }) {
    assert(msg != null);
    return _$Error(
      msg == freezed ? this.msg : msg as String,
    );
  }

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result idle(),
    @required Result loading(),
    @required Result loaded(List<Movie> movies),
    @required Result error(String msg),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return error(msg);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result idle(),
    Result loading(),
    Result loaded(List<Movie> movies),
    Result error(String msg),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(msg);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result idle(Idle value),
    @required Result loading(Loading value),
    @required Result loaded(Loaded value),
    @required Result error(Error value),
  }) {
    assert(idle != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result idle(Idle value),
    Result loading(Loading value),
    Result loaded(Loaded value),
    Result error(Error value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements MoviesState {
  const factory Error(String msg) = _$Error;

  String get msg;

  Error copyWith({String msg});
}
