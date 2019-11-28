import 'package:dartz/dartz.dart';

import '../errors/errors.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String number) {
    try {
      final integer = int.parse(number);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
