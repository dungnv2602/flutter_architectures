import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
  @override
  List<Object> get props => [];
}

class GetRandomNumber extends NumberTriviaEvent {}

class GetConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  const GetConcreteNumber(this.numberString);

  @override
  List<Object> get props => [numberString];
}
