import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';
import 'package:test/test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  NumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repository);
  });

  test('should get NumberTrivia for the number given to NumberTriviaRepository',
      () async {
    const testNumber = 1;
    const testText = 'one';

    const params = Params(number: testNumber);
    const testNumberTrivia = NumberTrivia(number: testNumber, text: testText);

    when(repository.getConcreteNumberTrivia(params.number))
        .thenAnswer((_) async => Right(testNumberTrivia));

    final rs = await usecase(params);

    expect(rs, Right(testNumberTrivia));

    verify(repository.getConcreteNumberTrivia(params.number)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
