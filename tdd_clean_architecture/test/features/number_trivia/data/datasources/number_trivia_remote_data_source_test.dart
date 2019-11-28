import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/core.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/data.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSource dataSource;
  http.Client client;

  setUp(() {
    client = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client);
  });

  final jsonString = fixture('trivia.json');
  final tNumberTriviaModel =
      NumberTriviaModel.fromJson(json.decode(jsonString));

  const headers = {'Content-Type': 'application/json'};
  const errorMsg = 'Something went wrong';

  void setUpMockHttpClientSuccess200(String url) {
    when(client.get(url, headers: headers)).thenAnswer(
      (_) async => http.Response(jsonString, 200),
    );
  }

  void setUpMockHttpClientFailure404(String url) {
    when(client.get(url, headers: headers)).thenAnswer(
      (_) async => http.Response(errorMsg, 404),
    );
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const url = 'http://numbersapi.com/$tNumber';
    test(
        'should preform a GET request and return NumberTriviaModel on a URL with number being the endpoint and with application/json header',
        () async {
      setUpMockHttpClientSuccess200(url);
      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(client.get(url, headers: headers));
      expect(result, equals(tNumberTriviaModel));
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404(url);
        // assert
        expect(() => dataSource.getConcreteNumberTrivia(tNumber),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    const url = 'http://numbersapi.com/random';

    test(
      'should preform a GET request and return NumberTrivia on a URL with *random* endpoint with application/json header',
      () async {
        //arrange
        setUpMockHttpClientSuccess200(url);
        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        verify(client.get(url, headers: headers));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404(url);
        // act
        final call = dataSource.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
