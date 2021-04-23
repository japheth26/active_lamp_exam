import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:dartz/dartz.dart';

class GetShortUrl {
  final UrlConverterRepository repository;

  GetShortUrl(this.repository);

  Future<Either<String, UrlEntity>> call(String url) async {
    return await repository.getShortenUrl(url);
  }
}
