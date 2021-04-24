import 'dart:convert';

import 'package:active_lamp_exam/core/error/exceptions.dart';
import 'package:active_lamp_exam/features/data/datasource/api_access.dart';
import 'package:active_lamp_exam/features/data/model/url_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class UrlConvertRemoteDataSource {
  Future<UrlModel> getShortUrl(String url);
  Future<UrlModel> getOriginalUrl(String url);
}

class UrlConvertRemoteDataSourceImpl implements UrlConvertRemoteDataSource {
  final http.Client client;

  ApiAccess _api = ApiAccess();

  UrlConvertRemoteDataSourceImpl({@required this.client});
  @override
  Future<UrlModel> getOriginalUrl(String url) async {
    String uri = '${_api.domain}${_api.endpoint_bitlinks}/$url';
    http.Response response = await client.get(Uri.parse(uri), headers: {
      'Authentication': '${_api.token}',
      'Content-Type': 'application/json',
    });

    print('status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UrlModel(
          isSuccess: true, message: 'Success', value: map['long_url']);
    } else {
      _checkException(response);
      return null;
    }
  }

  @override
  Future<UrlModel> getShortUrl(String url) async {
    Map<String, dynamic> data = {'long_url': url};

    String uri = '${_api.domain}${_api.endpoint_shorten}';
    http.Response response = await client.post(Uri.parse(uri),
        headers: {
          'Authentication': '${_api.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UrlModel(isSuccess: true, message: 'Success', value: map['link']);
    } else {
      _checkException(response);
      return null;
    }
  }

  // VALIDATE RESPONSE
  //
  //
  void _checkException(http.Response response) {
    switch (response.statusCode) {
      case 403:
        throw ServerException(ERROR_403);
        break;
      case 404:
        throw ServerException(ERROR_404);
        break;
      case 500:
        throw ServerException(ERROR_500);
        break;
      case 503:
        throw ServerException(ERROR_503);
        break;
      default:
        throw ServerException(ERROR_UNKNOWN);
    }
  }
}
