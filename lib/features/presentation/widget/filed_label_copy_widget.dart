import 'package:active_lamp_exam/features/presentation/widget/field_label_widget.dart';
import 'package:flutter/material.dart';

class FieldLabelCopyWidget extends StatelessWidget {
  final String label;
  final Function function;

  const FieldLabelCopyWidget({
    Key key,
    @required this.label,
    @required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FieldLabelWidget(
          icon: Icon(Icons.short_text),
          label: label,
        ),
        IconButton(icon: Icon(Icons.copy), onPressed: function)
      ],
    );
  }
}
