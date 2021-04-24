import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/core/network/network_info.dart';
import 'package:active_lamp_exam/features/data/datasource/url_converter_remote_data_source.dart';
import 'package:active_lamp_exam/features/data/model/url_model.dart';
import 'package:active_lamp_exam/features/data/repository/url_converter_repository_impl.dart';
import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements UrlConvertRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  UrlConverterRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UrlConverterRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  final String tUrl = 'www.google.com';
  final UrlModel tUrlModel =
      UrlModel(isSuccess: true, message: 'Success', value: 'link');
  final UrlEntity tUrlEntity = tUrlModel;

  group('getShortUrl', () {
    runTestsOnline(() {
      test(
          'should return data when the call to remote data source is successful',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(tUrl))
            .thenAnswer((_) async => tUrlModel);

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getShortUrl(tUrl));
        expect(result, equals(Right(tUrlEntity)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(any))
            .thenThrow(ServerException());

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getShortUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException403',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(any))
            .thenThrow(ServerException403());

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getShortUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_403)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException404',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(any))
            .thenThrow(ServerException404());

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getShortUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_404)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException500',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(any))
            .thenThrow(ServerException500());

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getShortUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_500)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException503',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(any))
            .thenThrow(ServerException503());

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getShortUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_503)));
      });
    });

    runTestsOffline(() {
      test(
          'should return error message when device is not connected to internet',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getShortUrl(any))
            .thenAnswer((_) async => tUrlModel);

        // act
        //
        //
        final result = await repository.getShortenUrl(tUrl);

        // assert
        //
        //
        expect(result, equals(Left(NO_INTERNET_CONNECTION)));
      });
    });
  });

  group('getOriginalUrl', () {
    runTestsOnline(() {
      test(
          'should return data when the call to remote data source is successful',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenAnswer((_) async => tUrlModel);

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getOriginalUrl(tUrl));
        expect(result, equals(Right(tUrlEntity)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenThrow(ServerException());

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getOriginalUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException403',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenThrow(ServerException403());

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getOriginalUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_403)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException404',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenThrow(ServerException404());

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getOriginalUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_404)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException500',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenThrow(ServerException500());

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getOriginalUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_500)));
      });

      test(
          'should return error message when the call to remote data source thrown ServerException503',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenThrow(ServerException503());

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        verify(mockRemoteDataSource.getOriginalUrl(tUrl));
        expect(result, equals(Left(SERVER_FAILURE_503)));
      });
    });

    runTestsOffline(() {
      test(
          'should return error message when device is not connected to internet',
          () async {
        // arrange
        //
        //
        when(mockRemoteDataSource.getOriginalUrl(any))
            .thenAnswer((_) async => tUrlModel);

        // act
        //
        //
        final result = await repository.getOriginalUrl(tUrl);

        // assert
        //
        //
        expect(result, equals(Left(NO_INTERNET_CONNECTION)));
      });
    });
  });
}
