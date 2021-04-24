import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/core/network/network_info.dart';
import 'package:active_lamp_exam/features/data/datasource/url_converter_remote_data_source.dart';
import 'package:active_lamp_exam/features/data/model/url_model.dart';
import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

const String NO_INTERNET_CONNECTION = 'No internet connection.';

class UrlConverterRepositoryImpl implements UrlConverterRepository {
  final UrlConvertRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UrlConverterRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<String, UrlEntity>> getOriginalUrl(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final UrlModel result = await remoteDataSource.getOriginalUrl(url);
        return Right(result);
      } on ServerException catch (e) {
        return Left(e.message);
      }
    } else {
      return Left(NO_INTERNET_CONNECTION);
    }
  }

  @override
  Future<Either<String, UrlEntity>> getShortenUrl(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final UrlModel result = await remoteDataSource.getShortUrl(url);
        return Right(result);
      } on ServerException catch (e) {
        return Left(e.message);
      }
    } else {
      return Left(NO_INTERNET_CONNECTION);
    }
  }
}
