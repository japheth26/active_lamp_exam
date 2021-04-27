import 'package:flutter/material.dart';

class OutlinedButtonDesignWidget extends StatelessWidget {
  final String label;
  final Function function;

  const OutlinedButtonDesignWidget({
    Key key,
    @required this.label,
    @required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Colors.white;
        }),
      ),
      onPressed: function,
      child: Text(
        label,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}
