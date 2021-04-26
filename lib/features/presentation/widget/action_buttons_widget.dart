import 'package:active_lamp_exam/core/util/util_widget.dart';
import 'package:flutter/material.dart';

class ActionButtonsWidget extends StatelessWidget {
  final Function clear;
  final Function convert;

  const ActionButtonsWidget(
      {Key key, @required this.clear, @required this.convert})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButtonDesign(
              label: 'Clear',
              function: clear,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ButtonDesign(
              label: 'Convert',
              function: convert,
            ),
          ),
        ],
      ),
    );
  }
}
