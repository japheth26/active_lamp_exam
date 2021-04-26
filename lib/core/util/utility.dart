import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

copyToClip(String url) => Clipboard.setData(new ClipboardData(text: url ?? ''))
    .then((value) => Fluttertoast.showToast(msg: 'Link copied'));

bool isHttp(String url) {
  final String checker = url.substring(0, 4);
  return checker == 'http' ? true : false;
}

String removeHttp(String url) {
  if (url.contains('https://')) {
    return url.replaceFirst('https://', '');
  } else {
    return url.replaceFirst('http://', '');
  }
}
