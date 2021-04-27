import 'package:flutter/material.dart';

class FeatureTitleWidget extends StatelessWidget {
  final String title;

  const FeatureTitleWidget({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
