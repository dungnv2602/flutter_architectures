import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_architecture/core/core.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/data.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSource dataSource;
  SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreference();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final jsonString = fixture('trivia_cached.json');
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(jsonString));
    test('should return NumberTrivia from SharedPreference when cached existed',
        () async {
      when(sharedPreferences.getString(CACHED_NUMBER_TRIVIA))
          .thenReturn(jsonString);
      final rs = await dataSource.getLastNumberTrivia();
      verify(sharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(rs, tNumberTriviaModel);
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      when(sharedPreferences.getString(CACHED_NUMBER_TRIVIA)).thenReturn(null);
      expect(() => dataSource.getLastNumberTrivia(),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final jsonString = fixture('trivia_cached.json');
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(jsonString));
    test('should call SharedPreference to cache the data', () {
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(sharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedJsonString));
    });
  });
}
