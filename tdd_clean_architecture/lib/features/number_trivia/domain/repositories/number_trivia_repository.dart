import 'package:dartz/dartz.dart';
import 'package:tdd_clean_architecture/core/core.dart';

import '../domain.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
