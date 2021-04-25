import 'package:active_lamp_exam/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('should return bool value from DataConnectionChecker.hasConnection',
        () {
      // arrange
      //
      //
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      // act
      //
      //
      final result = networkInfoImpl.isConnected;

      // assert
      //
      //
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, equals(tHasConnectionFuture));
    });
  });
}
