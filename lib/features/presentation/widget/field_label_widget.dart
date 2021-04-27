import 'package:flutter/material.dart';

class FieldLabelWidget extends StatelessWidget {
  final Icon icon;
  final String label;

  const FieldLabelWidget({
    Key key,
    @required this.icon,
    @required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
