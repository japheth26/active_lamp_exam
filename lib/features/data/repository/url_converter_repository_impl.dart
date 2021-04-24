import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/core/network/network_info.dart';
import 'package:active_lamp_exam/features/data/datasource/url_converter_remote_data_source.dart';
import 'package:active_lamp_exam/features/data/model/url_model.dart';
import 'package:active_lamp_exam/features/domain/entity/url_entity.dart';
import 'package:active_lamp_exam/features/domain/repository/url_converter_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

const String NO_INTERNET_CONNECTION = 'No internet connection.';
const String SERVER_FAILURE = 'Unknown Server Error';
const String SERVER_FAILURE_403 = 'Error[403] Forbidden';
const String SERVER_FAILURE_404 = 'Error[404] Not found';
const String SERVER_FAILURE_500 = 'Error[500] Server internal error';
const String SERVER_FAILURE_503 =
    'Error[503] Server temporarily not available.';

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
      } on ServerException {
        return Left(SERVER_FAILURE);
      } on ServerException403 {
        return Left(SERVER_FAILURE_403);
      } on ServerException404 {
        return Left(SERVER_FAILURE_404);
      } on ServerException500 {
        return Left(SERVER_FAILURE_500);
      } on ServerException503 {
        return Left(SERVER_FAILURE_503);
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
      } on ServerException {
        return Left(SERVER_FAILURE);
      } on ServerException403 {
        return Left(SERVER_FAILURE_403);
      } on ServerException404 {
        return Left(SERVER_FAILURE_404);
      } on ServerException500 {
        return Left(SERVER_FAILURE_500);
      } on ServerException503 {
        return Left(SERVER_FAILURE_503);
      }
    } else {
      return Left(NO_INTERNET_CONNECTION);
    }
  }
}
