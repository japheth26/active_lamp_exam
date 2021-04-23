import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_short_url.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUrlConverterRepository extends Mock
    implements UrlConverterRepository {}

void main() {
  GetShortUrl usecase;
  MockUrlConverterRepository mockUrlConverterRepository;

  setUp(() {
    mockUrlConverterRepository = MockUrlConverterRepository();
    usecase = GetShortUrl(mockUrlConverterRepository);
  });

  final String tUrl = 'www.google.com';
  final UrlEntity tUrlEntity =
      UrlEntity(isSuccess: true, message: 'success', value: 'link');

  test('should get url entity from the repository', () async {
    //  arrange
    //
    //
    when(mockUrlConverterRepository.getShortenUrl(any))
        .thenAnswer((_) async => Right(tUrlEntity));

    // act
    //
    //
    final result = await usecase.call(tUrl);

    // assert
    //
    //
    expect(result, Right(tUrlEntity));
    verify(mockUrlConverterRepository.getShortenUrl(tUrl));
    verifyNoMoreInteractions(mockUrlConverterRepository);
  });
}
