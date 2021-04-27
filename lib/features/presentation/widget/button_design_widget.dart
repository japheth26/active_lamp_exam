import 'package:flutter/material.dart';

class ButtonDesignWidget extends StatelessWidget {
  final String label;
  final Function function;

  const ButtonDesignWidget({
    Key key,
    @required this.label,
    @required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Text(label),
    );
  }
}
