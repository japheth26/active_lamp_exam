import 'package:active_lamp_exam/features/data/model/url_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class UrlConvertRemoteDataSource {
  Future<UrlModel> getShortUrl(String url);
  Future<UrlModel> getOriginalUrl(String url);
}

class UrlConvertRemoteDataSourceImpl implements UrlConvertRemoteDataSource {
  final http.Client client;

  UrlConvertRemoteDataSourceImpl({@required this.client});
  @override
  Future<UrlModel> getOriginalUrl(String url) {
    // TODO: implement getOriginalUrl
    throw UnimplementedError();
  }

  @override
  Future<UrlModel> getShortUrl(String url) {
    // TODO: implement getShortUrl
    throw UnimplementedError();
  }
}
