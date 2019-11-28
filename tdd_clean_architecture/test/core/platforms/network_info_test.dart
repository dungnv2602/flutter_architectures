import 'package:tdd_clean_architecture/core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  DataConnectionChecker dataConnectionChecker;
  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(dataConnectionChecker);
  });
  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      when(dataConnectionChecker.hasConnection).thenAnswer((_) async => true);
      final rs = await networkInfo.isConnected;
      verify(dataConnectionChecker.hasConnection);
      expect(rs,true);
    });
  });
}
