import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String result;

  const ResultWidget({Key key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      child: Text(
        result ?? 'n/a',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
