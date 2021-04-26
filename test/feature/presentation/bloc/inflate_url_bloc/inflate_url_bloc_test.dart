import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_original_url.dart';
import 'package:active_lamp_exam/features/presentation/bloc/inflate_url_bloc/inflate_url_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetOriginalUrl extends Mock implements GetOriginalUrl {}

main() {
  InflateUrlBloc bloc;
  MockGetOriginalUrl mockGetOriginalUrl;

  setUp(() {
    mockGetOriginalUrl = MockGetOriginalUrl();
    bloc = InflateUrlBloc(inflateUrl: mockGetOriginalUrl);
  });

  test('initial state should be InflateUrlInitial', () {
    // assert
    //
    //
    expect(bloc.state, equals(InflateUrlInitial()));
  });

  group('getOriginalUrl', () {
    final String tUrl = 'www.google.com';
    final String tWhiteSpace = '     ';
    final UrlEntity tUrlEntitySuccess =
        UrlEntity(isSuccess: true, message: 'Success', value: 'link');
    final UrlEntity tUrlEntityFailure =
        UrlEntity(isSuccess: false, message: 'Something went wrong');
    test('should emit [LOADING, ERROR] when response is a failure', () {
      // arrange
      //
      //
      when(mockGetOriginalUrl.call(any))
          .thenAnswer((_) async => Right(tUrlEntityFailure));

      // assert later
      //
      //
      final expected = [
        InflateUrlLoading(),
        InflateUrlError(message: tUrlEntityFailure.message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetOriginalUrlEvent(url: tUrl));
    });

    test('should emit [LOADING, SUCCESS] when response is success', () {
      // arrange
      //
      //
      when(mockGetOriginalUrl.call(any))
          .thenAnswer((_) async => Right(tUrlEntitySuccess));

      // assert later
      //
      //
      final expected = [
        InflateUrlLoading(),
        InflateUrlSuccess(inputUrl: tUrl, link: tUrlEntitySuccess.value),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetOriginalUrlEvent(url: tUrl));
    });

    test('should emit [LOADING, ERROR] when it has server failure', () {
      // arrange
      //
      //
      when(mockGetOriginalUrl.call(any))
          .thenAnswer((_) async => Left(ERROR_UNKNOWN));
      // assert later
      //
      //
      final expected = [
        InflateUrlLoading(),
        InflateUrlError(message: ERROR_UNKNOWN),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetOriginalUrlEvent(url: tUrl));
    });

    test('should emit [ERROR] when url is empty', () {
      // assert later
      //
      //
      final expected = [
        InflateUrlError(message: INVALID_INPUT),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetOriginalUrlEvent(url: ''));
    });

    test('should emit [ERROR] when url has white space', () {
      // assert later
      //
      //
      final expected = [
        InflateUrlError(message: INVALID_INPUT),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetOriginalUrlEvent(url: tWhiteSpace));
    });

    test('should emit [LOADING, INITIAL] when clearing fields', () {
      // act
      //
      //
      bloc.add(ClearFieldsForInflateUrlEvent());

      // assert
      //
      //
      final expected = [
        InflateUrlLoading(),
        InflateUrlInitial(),
      ];
      expect(bloc.stream, emitsInOrder(expected));
    });
  });
}
