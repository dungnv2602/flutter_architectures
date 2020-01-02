// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent(this._type);

  factory NumberTriviaEvent.getRandomNumber() = GetRandomNumber;

  factory NumberTriviaEvent.getConcreteNumber({@required String numberString}) =
      GetConcreteNumber;

  final _NumberTriviaEvent _type;

//ignore: missing_return
  R when<R>(
      {@required R Function(GetRandomNumber) getRandomNumber,
      @required R Function(GetConcreteNumber) getConcreteNumber}) {
    switch (this._type) {
      case _NumberTriviaEvent.GetRandomNumber:
        return getRandomNumber(this as GetRandomNumber);
      case _NumberTriviaEvent.GetConcreteNumber:
        return getConcreteNumber(this as GetConcreteNumber);
    }
  }

  @override
  List get props => null;
}

@immutable
class GetRandomNumber extends NumberTriviaEvent {
  const GetRandomNumber._() : super(_NumberTriviaEvent.GetRandomNumber);

  factory GetRandomNumber() {
    _instance ??= GetRandomNumber._();
    return _instance;
  }

  static GetRandomNumber _instance;
}

@immutable
class GetConcreteNumber extends NumberTriviaEvent {
  const GetConcreteNumber({@required this.numberString})
      : super(_NumberTriviaEvent.GetConcreteNumber);

  final String numberString;

  @override
  String toString() => 'GetConcreteNumber(numberString:${this.numberString})';
  @override
  List get props => [numberString];
}
