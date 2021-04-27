import 'package:flutter/material.dart';

class ExpandableFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;

  const ExpandableFieldWidget({
    Key key,
    @required this.hint,
    @required this.textEditingController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
        ),
        controller: textEditingController,
        autofocus: false,
        maxLines: null,
        keyboardType: TextInputType.text,
      ),
    );
  }
}
