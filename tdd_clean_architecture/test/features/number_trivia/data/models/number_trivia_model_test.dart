import 'dart:convert';

import 'package:tdd_clean_architecture/features/number_trivia/data/data.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/domain.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('NumberTriviaModel', () {
    test('should be a subclass of NumberTrivia entity', () async {
      const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'one');
      expect(testNumberTriviaModel, isA<NumberTrivia>());
    });

    test('should return a valid model when from JSON', () async {
      final Map<String, dynamic> map = json.decode(fixture('trivia.json'));
      const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'one');
      final rs = NumberTriviaModel.fromJson(map);
      expect(rs, testNumberTriviaModel);
    });

    test(
        'should return a valid model when from JSON with number value is a double',
        () async {
      final Map<String, dynamic> map =
          json.decode(fixture('trivia_double.json'));
      const testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'one');
      final rs = NumberTriviaModel.fromJson(map);
      expect(rs, testNumberTriviaModel);
    });

    test('should return a JSON map containing the proper data', () async {
      const tNumber = 1;
      const tText = 'one';
      const testNumberTriviaModel =
          NumberTriviaModel(number: tNumber, text: tText);
      final result = testNumberTriviaModel.toJson();
      final expectedJsonMap = {
        'text': tText,
        'number': tNumber,
      };
      expect(result, expectedJsonMap);
    });
  });
}
