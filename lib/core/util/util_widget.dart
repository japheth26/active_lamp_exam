import 'package:flutter/material.dart';

// TITLE
//
//
class FeatureTitle extends StatelessWidget {
  final String title;

  const FeatureTitle({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

// Field Label
//
//
class FieldLabel extends StatelessWidget {
  final Icon icon;
  final String label;

  const FieldLabel({
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

// Field Label Copy
//
//
class FieldLabelCopy extends StatelessWidget {
  final String label;
  final Function function;

  const FieldLabelCopy({
    Key key,
    @required this.label,
    @required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FieldLabel(
          icon: Icon(Icons.short_text),
          label: label,
        ),
        IconButton(icon: Icon(Icons.copy), onPressed: function)
      ],
    );
  }
}

class Result extends StatelessWidget {
  final String result;

  const Result({Key key, this.result}) : super(key: key);
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

// EXPANDABLE FIELD
//
//
class ExpandableField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;

  const ExpandableField({
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

// OUTLINED BUTTON
//
//
class OutlinedButtonDesign extends StatelessWidget {
  final String label;
  final Function function;

  const OutlinedButtonDesign({
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

// REGULAR BUTTON
//
//
class ButtonDesign extends StatelessWidget {
  final String label;
  final Function function;

  const ButtonDesign({
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
