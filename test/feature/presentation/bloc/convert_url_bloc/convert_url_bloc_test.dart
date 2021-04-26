import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_short_url.dart';
import 'package:active_lamp_exam/features/presentation/bloc/convert_url_bloc/convert_url_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetShortUrl extends Mock implements GetShortUrl {}

main() {
  ConvertUrlBloc bloc;
  MockGetShortUrl mockGetShortUrl;

  setUp(() {
    mockGetShortUrl = MockGetShortUrl();
    bloc = ConvertUrlBloc(shortUrl: mockGetShortUrl);
  });

  test('initial state should be ConvertUrlInitial', () {
    // assert
    //
    //
    expect(bloc.state, equals(ConvertUrlInitial()));
  });

  group('getShortUrl', () {
    final String tUrl = 'www.google.com';
    final UrlEntity tUrlEntitySuccess =
        UrlEntity(isSuccess: true, message: 'Success', value: 'link');
    final UrlEntity tUrlEntityFail =
        UrlEntity(isSuccess: false, message: 'Something went wrong');

    test('should emit [LOADING, ERROR] when response is a failure', () async {
      // arrange
      //
      //
      when(mockGetShortUrl.call(any))
          .thenAnswer((_) async => Right(tUrlEntityFail));

      // assert later
      //
      //
      final expected = [
        ConvertUrlLoading(),
        ConvertUrlError(message: tUrlEntityFail.message),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetConvertUrlEvent(url: tUrl));
    });

    test('should emit [LOADING, SUCCESS] when response is success', () async {
      // arrange
      //
      //
      when(mockGetShortUrl.call(any))
          .thenAnswer((_) async => Right(tUrlEntitySuccess));

      // assert later
      //
      //
      final expected = [
        ConvertUrlLoading(),
        ConvertUrlSuccess(inputUrl: tUrl, link: tUrlEntitySuccess.value),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetConvertUrlEvent(url: tUrl));
    });

    test('should emit [LOADING, ERROR] when it has server failure', () async {
      // arrange
      //
      //
      when(mockGetShortUrl.call(any))
          .thenAnswer((_) async => Left(ERROR_UNKNOWN));

      // assert later
      //
      //
      final expected = [
        ConvertUrlLoading(),
        ConvertUrlError(message: ERROR_UNKNOWN),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      //
      //
      bloc.add(GetConvertUrlEvent(url: tUrl));
    });

    test('should emit [LOADING, INITIAL] when clearing fields', () {
      // act
      //
      //
      bloc.add(ClearFieldsForConvertUrlEvent());

      // assert
      //
      //
      final expected = [
        ConvertUrlLoading(),
        ConvertUrlInitial(),
      ];
      expect(bloc.stream, emitsInOrder(expected));
    });
  });
}
