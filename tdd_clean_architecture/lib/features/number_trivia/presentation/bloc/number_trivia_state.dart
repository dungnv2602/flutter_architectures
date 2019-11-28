import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded(this.trivia);
  
  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String msg;

  const Error(this.msg);

  @override
  List<Object> get props => [msg];
}
