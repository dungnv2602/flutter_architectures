import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'models.dart';

part 'movies_state.freezed.dart';

@freezed
abstract class MoviesState with _$MoviesState {
  const factory MoviesState.idle() = Idle;
  const factory MoviesState.loading() = Loading;
  const factory MoviesState.loaded(List<Movie> movies) = Loaded;
  const factory MoviesState.error(String msg) = Error;
}
