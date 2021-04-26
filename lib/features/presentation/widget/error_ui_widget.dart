import 'package:flutter/material.dart';

class ErrorUiWidget extends StatelessWidget {
  final String message;
  final Function function;

  const ErrorUiWidget(
      {Key key, @required this.message, @required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 80,
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Text(
              '$message',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: ElevatedButton(
              child: Text('Okay'),
              onPressed: function,
            ),
          )
        ],
      ),
    );
  }
}
