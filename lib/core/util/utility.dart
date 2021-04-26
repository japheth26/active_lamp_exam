import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

copyToClip(String url) => Clipboard.setData(new ClipboardData(text: url ?? ''))
    .then((value) => Fluttertoast.showToast(msg: 'Link copied'));
