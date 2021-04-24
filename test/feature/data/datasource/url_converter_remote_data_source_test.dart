import 'package:active_lamp_exam/features/data/datasource/url_converter_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  UrlConvertRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UrlConvertRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getShortUrl', () {
    test('should perform a POST request with URL as an endpoint', () {
      // arrange
      //
      //
      when(mockHttpClient.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) => null);

      // act
      //
      //

      // assert
      //
      //
    });
  });
}
