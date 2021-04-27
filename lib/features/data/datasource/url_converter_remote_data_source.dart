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
      'Authorization': '${_api.token}',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UrlModel(
          isSuccess: true, message: 'Success', value: map['long_url']);
    } else {
      throw _checkException(response);
    }
  }

  @override
  Future<UrlModel> getShortUrl(String url) async {
    Map data = {'long_url': url};

    String uri = '${_api.domain}${_api.endpoint_shorten}';
    http.Response response = await client.post(Uri.parse(uri),
        headers: {
          'Authorization': '${_api.token}',
          'Content-Type': 'application/json',
        },
        body: json.encode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return UrlModel(isSuccess: true, message: 'Success', value: map['link']);
    } else {
      throw _checkException(response);
    }
  }

  // VALIDATE RESPONSE
  //
  //
  ServerException _checkException(http.Response response) {
    print('check status code: ${response.statusCode}');
    switch (response.statusCode) {
      case 400:
        return ServerException(ERROR_400);
        break;
      case 403:
        return ServerException(ERROR_403);
        break;
      case 404:
        return ServerException(ERROR_404);
        break;
      case 500:
        return ServerException(ERROR_500);
        break;
      case 503:
        return ServerException(ERROR_503);
        break;
      default:
        return ServerException(ERROR_UNKNOWN);
    }
  }
}
