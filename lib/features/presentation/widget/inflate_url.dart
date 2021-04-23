import 'package:active_lamp_exam/core/util/util_widget.dart';
import 'package:flutter/material.dart';

class InflateUrl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FeatureTitle(title: 'Inflate URL'),
              SizedBox(height: 30),
              BodyContent(),
            ],
          ),
        ),
      ),
    );
  }
}

// BODY CONTENT
//
//
class BodyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          FieldLabel(
            icon: Icon(Icons.link),
            label: 'Shortened URL',
          ),
          ExpandableField(
            hint: 'Input your shortened URL',
            textEditingController: null,
          ),
          SizedBox(height: 30),
          FieldLabelCopy(label: 'Original URL', function: () {}),
          Result(result: null),
          SizedBox(height: 30),
          ActionButtons(),
        ],
      ),
    );
  }
}

// ACTION BUTTONS
//
//
class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButtonDesign(
              label: 'Clear',
              function: () {},
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ButtonDesign(
              label: 'Convert',
              function: () {},
            ),
          ),
        ],
      ),
    );
  }
}
