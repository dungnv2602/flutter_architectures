import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/core.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';
import 'package:test/test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  NumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repository);
  });

  test('should get NumberTrivia for the number given to NumberTriviaRepository',
      () async {
    const testNumberTrivia = NumberTrivia(number: 1, text: 'one');

    when(repository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(testNumberTrivia));

    final rs = await usecase(const NoParams());

    expect(rs, Right(testNumberTrivia));

    verify(repository.getRandomNumberTrivia()).called(1);

    verifyNoMoreInteractions(repository);
  });
}
