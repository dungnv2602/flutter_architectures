import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tdd_clean_architecture/core/core.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';
const String UNEXPECTED_ERROR = 'Unexpected Error';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  })  : assert(getConcreteNumberTrivia != null),
        assert(getRandomNumberTrivia != null),
        assert(inputConverter != null);

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetConcreteNumber) {
      yield* mapGetConcreteNumberEventToState(event);
    }
    if (event is GetRandomNumber) {
      yield* mapGetRandomNumberEventToState();
    }
  }

  Stream<NumberTriviaState> mapGetConcreteNumberEventToState(
      GetConcreteNumber event) async* {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

    yield* inputEither.fold(
      (failure) async* {
        yield const Error(INVALID_INPUT_FAILURE_MESSAGE);
      },
      (integer) async* {
        yield Loading();
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
        yield* _eitherLoadedOrErrorState(failureOrTrivia);
      },
    );
  }

  Stream<NumberTriviaState> mapGetRandomNumberEventToState() async* {
    yield Loading();
    final failureOrTrivia = await getRandomNumberTrivia(const NoParams());
    yield* _eitherLoadedOrErrorState(failureOrTrivia);
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> either,
  ) async* {
    yield either.fold(
      (failure) => Error(_mapFailureToMessage(failure)),
      (trivia) => Loaded(trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}
