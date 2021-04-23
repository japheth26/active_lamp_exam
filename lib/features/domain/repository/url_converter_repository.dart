import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UrlConverterRepository {
  Future<Either<String, UrlEntity>> getShortenUrl(String url);
  Future<Either<String, UrlEntity>> getOriginalUrl(String url);
}
