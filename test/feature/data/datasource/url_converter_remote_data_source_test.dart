import 'dart:convert';

import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/features/data/datasource/api_access.dart';
import 'package:active_lamp_exam/features/data/datasource/url_converter_remote_data_source.dart';
import 'package:active_lamp_exam/features/data/model/url_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart' as matcher;
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  UrlConvertRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = UrlConvertRemoteDataSourceImpl(client: mockHttpClient);
  });

  ApiAccess _api = ApiAccess();

  void _testShortUrlException(int statusCode, String tUrl) {
    // arrange
    //
    //
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer(
            (_) async => http.Response('Something went wrong', statusCode));

    // act
    //
    //
    final call = dataSource.getShortUrl;

    // assert
    //
    //
    expect(() => call(tUrl), throwsA(matcher.TypeMatcher<ServerException>()));
  }

  void _testOriginalUrlException(int statusCode, String tUrl) {
    // arrange
    //
    //
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('something went wrong.', statusCode));

    // act
    //
    //
    final call = dataSource.getOriginalUrl;

    // assert
    //
    //
    expect(() => call(tUrl), throwsA(matcher.TypeMatcher<ServerException>()));
  }

  group('getShortUrl', () {
    final String tUrl = 'https://www.youtube.com/watch?v=NO2typgFCIE';
    final Map data = {'long_url': tUrl};
    final String uri = '${_api.domain}${_api.endpoint_shorten}';

    final UrlModel tUrlModel = UrlModel(
        isSuccess: true, message: 'Success', value: 'https://bit.ly/2QrNptK');

    void _shortUrlRequest200() {
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response(fixture('get_short_200.json'), 200));
    }

    void _shortUrlRequest201() {
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer(
              (_) async => http.Response(fixture('get_short_201.json'), 201));
    }

    test('should perform a POST request when using a shorten endpoint',
        () async {
      // arrange
      //
      //
      _shortUrlRequest200();

      // act
      //
      //
      await dataSource.getShortUrl(tUrl);

      // assert
      //
      //
      verify(mockHttpClient.post(Uri.parse(uri),
          headers: {
            'Authorization': '${_api.token}',
            'Content-Type': 'application/json',
          },
          body: json.encode(data)));
    });

    test('should return UrlModel when the response code is 200 (success)',
        () async {
      // arrange
      //
      //
      _shortUrlRequest200();

      // act
      //
      //
      final result = await dataSource.getShortUrl(tUrl);

      // assert
      //
      //
      expect(result.toJson(), equals(tUrlModel.toJson()));
    });

    test('should return UrlModel when the response code is 201 (created)',
        () async {
      // arrange
      //
      //
      _shortUrlRequest201();

      // act
      //
      //
      final result = await dataSource.getShortUrl(tUrl);

      // assert
      //
      //
      expect(result.toJson(), equals(tUrlModel.toJson()));
    });

    test('should throw Server Exception when response code is 403', () {
      _testShortUrlException(403, tUrl);
    });

    test('should throw Server Exception when response code is 404', () {
      _testShortUrlException(404, tUrl);
    });

    test('should throw Server Exception when response code is 500', () {
      _testShortUrlException(500, tUrl);
    });

    test('should throw Server Exception 503 when response code is 503', () {
      _testShortUrlException(503, tUrl);
    });
  });

  group('getOriginalUrl', () {
    final String tUrl = 'bit.ly/2QrNptK';
    final String uri = '${_api.domain}${_api.endpoint_bitlinks}';

    final UrlModel tUrlModel = UrlModel(
        isSuccess: true,
        message: 'Success',
        value: 'https://www.youtube.com/watch?v=NO2typgFCIE');

    void _originalUrlRequest200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('get_original_200.json'), 200));
    }

    test('should run a GET method when using a bitlinks endpoint', () async {
      // arrange
      //
      //
      _originalUrlRequest200();

      // act
      //
      //
      await dataSource.getOriginalUrl(tUrl);

      // assert
      //
      //
      verify(mockHttpClient.get(Uri.parse('$uri/$tUrl'), headers: {
        'Authorization': _api.token,
        'Content-Type': 'application/json',
      }));
    });

    test('should return UrlModel when response is 200 (success)', () async {
      // arrange
      //
      //
      _originalUrlRequest200();

      // act
      //
      //
      final result = await dataSource.getOriginalUrl(tUrl);

      // assert
      //
      //
      expect(result.toJson(), equals(tUrlModel.toJson()));
    });

    test('should throw Server Exception when response code is 403', () {
      _testOriginalUrlException(403, tUrl);
    });

    test('should throw Server Exception when response code is 404', () {
      _testOriginalUrlException(404, tUrl);
    });

    test('should throw Server Exception when response code is 500', () {
      _testOriginalUrlException(500, tUrl);
    });

    test('should throw Server Exception when response code is 503', () {
      _testOriginalUrlException(503, tUrl);
    });
  });
}
