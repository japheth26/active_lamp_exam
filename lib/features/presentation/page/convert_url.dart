import 'package:active_lamp_exam/core/util/utility.dart';
import 'package:active_lamp_exam/features/presentation/bloc/convert_url_bloc/convert_url_bloc.dart';
import 'package:active_lamp_exam/features/presentation/widget/action_buttons_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/error_ui_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/expandable_field_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/feature_title_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/field_label_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/filed_label_copy_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/loading_ui_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/result_widget.dart';
import 'package:active_lamp_exam/injection_container.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConvertUrl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ConvertUrlBloc>(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                // Title
                FeatureTitleWidget(title: 'Convert URL'),
                SizedBox(height: 30),

                // Main content

                BlocBuilder<ConvertUrlBloc, ConvertUrlState>(
                    builder: (context, state) {
                  if (state is ConvertUrlLoading) {
                    return LoadingUiWidget();
                  } else if (state is ConvertUrlError) {
                    return ErrorUiWidget(
                        message: state.message,
                        function: () {
                          BlocProvider.of<ConvertUrlBloc>(context)
                              .add(ClearFieldsForConvertUrlEvent());
                        });
                  } else if (state is ConvertUrlSuccess) {
                    return BodyContent(
                        inputUrl: state.inputUrl, outputUrl: state.link);
                  } else {
                    return BodyContent();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// BODY CONTENT
//
//
class BodyContent extends StatefulWidget {
  final String outputUrl;
  final String inputUrl;

  const BodyContent({Key key, this.inputUrl, this.outputUrl}) : super(key: key);
  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  TextEditingController inputUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputUrlController.text = widget.inputUrl;
  }

  @override
  void dispose() {
    super.dispose();
    inputUrlController.dispose();
  }

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
          FieldLabelWidget(
            icon: Icon(Icons.link),
            label: 'Long URL',
          ),
          ExpandableFieldWidget(
            hint: 'Input your long URL',
            textEditingController: inputUrlController,
          ),
          SizedBox(height: 30),
          FieldLabelCopyWidget(
              label: 'Shortened URL',
              function: () => copyToClip(widget.outputUrl)),
          ResultWidget(result: widget.outputUrl),
          SizedBox(height: 30),
          ActionButtonsWidget(
            clear: () {
              setState(() => inputUrlController.text = '');
              BlocProvider.of<ConvertUrlBloc>(context)
                  .add(ClearFieldsForConvertUrlEvent());
            },
            convert: () {
              BlocProvider.of<ConvertUrlBloc>(context)
                  .add(GetConvertUrlEvent(url: inputUrlController.text));
            },
          ),
        ],
      ),
    );
  }
}
