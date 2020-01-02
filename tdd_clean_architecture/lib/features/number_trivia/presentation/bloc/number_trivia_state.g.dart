// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState(this._type);

  factory NumberTriviaState.empty() = Empty;

  factory NumberTriviaState.loading() = Loading;

  factory NumberTriviaState.loaded({@required NumberTrivia trivia}) = Loaded;

  factory NumberTriviaState.error({@required String msg}) = Error;

  final _NumberTriviaState _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(Empty) empty,
      @required R Function(Loading) loading,
      @required R Function(Loaded) loaded,
      @required R Function(Error) error}) {
    switch (this._type) {
      case _NumberTriviaState.Empty:
        return empty(this as Empty);
      case _NumberTriviaState.Loading:
        return loading(this as Loading);
      case _NumberTriviaState.Loaded:
        return loaded(this as Loaded);
      case _NumberTriviaState.Error:
        return error(this as Error);
    }
  }

  @override
  List get props => null;
}

@immutable
class Empty extends NumberTriviaState {
  const Empty._() : super(_NumberTriviaState.Empty);

  factory Empty() {
    _instance ??= Empty._();
    return _instance;
  }

  static Empty _instance;
}

@immutable
class Loading extends NumberTriviaState {
  const Loading._() : super(_NumberTriviaState.Loading);

  factory Loading() {
    _instance ??= Loading._();
    return _instance;
  }

  static Loading _instance;
}

@immutable
class Loaded extends NumberTriviaState {
  const Loaded({@required this.trivia}) : super(_NumberTriviaState.Loaded);

  final NumberTrivia trivia;

  @override
  String toString() => 'Loaded(trivia:${this.trivia})';
  @override
  List get props => [trivia];
}

@immutable
class Error extends NumberTriviaState {
  const Error({@required this.msg}) : super(_NumberTriviaState.Error);

  final String msg;

  @override
  String toString() => 'Error(msg:${this.msg})';
  @override
  List get props => [msg];
}
