import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/core.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';
import 'package:tdd_clean_architecture/features/number_trivia/presentation/bloc/bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

void main() {
  group('NumberTriviaBloc', () {
    NumberTriviaBloc bloc;
    GetConcreteNumberTrivia getConcreteNumberTrivia;
    GetRandomNumberTrivia getRandomNumberTrivia;
    InputConverter inputConverter;

    setUp(() {
      getConcreteNumberTrivia = MockGetConcreteNumberTrivia();
      getRandomNumberTrivia = MockGetRandomNumberTrivia();
      inputConverter = InputConverter();

      bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: getConcreteNumberTrivia,
        getRandomNumberTrivia: getRandomNumberTrivia,
        inputConverter: inputConverter,
      );
    });

    test('initState is Empty', () {
      expect(bloc.initialState, equals(Empty()));
    });

    group('GetConcreteNumberTrivia', () {
      const tNumberString = '1';
      const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
      blocTest(
        'should emit [Empty, Error] when the number input is invalid',
        build: () => bloc,
        act: (NumberTriviaBloc bloc) async =>
            bloc.add(const GetConcreteNumber('error')),
        expect: [
          Empty(),
          Error(INVALID_INPUT_FAILURE_MESSAGE),
        ],
      );
      blocTest(
        'should emit [Empty, Loading, Loaded] when GetConcreteNumberTrivia called success',
        build: () {
          when(getConcreteNumberTrivia(any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          return bloc;
        },
        act: (NumberTriviaBloc bloc) async =>
            bloc.add(GetConcreteNumber(tNumberString)),
        expect: [
          Empty(),
          Loading(),
          Loaded(tNumberTrivia),
        ],
      );
      blocTest(
        'should emit [Empty, Loading, Error] when GetConcreteNumberTrivia throws ServerFailue',
        build: () {
          when(getConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (NumberTriviaBloc bloc) async =>
            bloc.add(GetConcreteNumber(tNumberString)),
        expect: [
          Empty(),
          Loading(),
          Error(SERVER_FAILURE_MESSAGE),
        ],
      );
      blocTest(
        'should emit [Empty, Loading, Error] when GetConcreteNumberTrivia throws CacheFailue',
        build: () {
          when(getConcreteNumberTrivia(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          return bloc;
        },
        act: (NumberTriviaBloc bloc) async =>
            bloc.add(GetConcreteNumber(tNumberString)),
        expect: [
          Empty(),
          Loading(),
          Error(CACHE_FAILURE_MESSAGE),
        ],
      );
    });

    group('MockGetRandomNumberTrivia', () {
      const tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
      blocTest(
        'should emit [Empty, Loading, Loaded] when GetRandomNumberTrivia called success',
        build: () {
          when(getRandomNumberTrivia(any))
              .thenAnswer((_) async => Right(tNumberTrivia));
          return bloc;
        },
        act: (NumberTriviaBloc bloc) async => bloc.add(GetRandomNumber()),
        expect: [
          Empty(),
          Loading(),
          Loaded(tNumberTrivia),
        ],
      );
      blocTest(
        'should emit [Empty, Loading, Error] when GetRandomNumberTrivia throws ServerFailue',
        build: () {
          when(getRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return bloc;
        },
        act: (NumberTriviaBloc bloc) async => bloc.add(GetRandomNumber()),
        expect: [
          Empty(),
          Loading(),
          Error(SERVER_FAILURE_MESSAGE),
        ],
      );
      blocTest(
        'should emit [Empty, Loading, Error] when GetRandomNumberTrivia throws CacheFailue',
        build: () {
          when(getRandomNumberTrivia(any))
              .thenAnswer((_) async => Left(CacheFailure()));
          return bloc;
        },
        act: (NumberTriviaBloc bloc) async => bloc.add(GetRandomNumber()),
        expect: [
          Empty(),
          Loading(),
          Error(CACHE_FAILURE_MESSAGE),
        ],
      );
    });
  });
}
