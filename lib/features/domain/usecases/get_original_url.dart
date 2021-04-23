import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:dartz/dartz.dart';

class GetOriginalUrl {
  final UrlConverterRepository repository;

  GetOriginalUrl(this.repository);

  Future<Either<String, UrlEntity>> call(String url) async {
    return await repository.getOriginalUrl(url);
  }
}
