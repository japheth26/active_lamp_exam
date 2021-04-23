import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:active_lamp_exam/features/domain/usecases/get_original_url.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUrlConverterRepository extends Mock
    implements UrlConverterRepository {}

main() {
  GetOriginalUrl usecase;
  MockUrlConverterRepository mockUrlConverterRepository;

  setUp(() {
    mockUrlConverterRepository = MockUrlConverterRepository();
    usecase = GetOriginalUrl(mockUrlConverterRepository);
  });

  final String tUrl = 'www.google.com';
  final UrlEntity tUrlEntity =
      UrlEntity(isSuccess: true, message: 'success', value: 'link');

  test('should get url entity from the repository', () async {
    // arrange
    //
    //
    when(mockUrlConverterRepository.getOriginalUrl(any))
        .thenAnswer((_) async => Right(tUrlEntity));

    // act
    //
    //
    final result = await usecase.call(tUrl);

    // assert
    //
    //
    expect(result, Right(tUrlEntity));
    verify(mockUrlConverterRepository.getOriginalUrl(tUrl));
    verifyNoMoreInteractions(mockUrlConverterRepository);
  });
}
