import 'package:active_lamp_exam/core/util/util_widget.dart';
import 'package:active_lamp_exam/core/util/utility.dart';
import 'package:active_lamp_exam/features/presentation/bloc/inflate_url_bloc/inflate_url_bloc.dart';
import 'package:active_lamp_exam/features/presentation/widget/action_buttons_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/error_ui_widget.dart';
import 'package:active_lamp_exam/features/presentation/widget/loading_ui_widget.dart';
import 'package:active_lamp_exam/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InflateUrl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InflateUrlBloc>(),
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
                FeatureTitle(title: 'Inflate URL'),
                SizedBox(height: 30),
                // Main content

                BlocBuilder<InflateUrlBloc, InflateUrlState>(
                    builder: (context, state) {
                  if (state is InflateUrlLoading) {
                    return LoadingUiWidget();
                  } else if (state is InflateUrlError) {
                    return ErrorUiWidget(
                        message: state.message,
                        function: () => BlocProvider.of<InflateUrlBloc>(context)
                            .add(ClearFieldsForInflateUrlEvent()));
                  } else if (state is InflateUrlSuccess) {
                    return BodyContent(
                      inputUrl: state.inputUrl,
                      outputUrl: state.link,
                    );
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
  final String inputUrl;
  final String outputUrl;

  const BodyContent({Key key, this.inputUrl, this.outputUrl}) : super(key: key);

  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  final TextEditingController inputUrlController = TextEditingController();

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
          FieldLabel(
            icon: Icon(Icons.link),
            label: 'Shortened URL',
          ),
          ExpandableField(
            hint: 'Input your shortened URL',
            textEditingController: inputUrlController,
          ),
          SizedBox(height: 30),
          FieldLabelCopy(
              label: 'Original URL',
              function: () => copyToClip(widget.outputUrl)),
          Result(result: widget.outputUrl),
          SizedBox(height: 30),
          ActionButtonsWidget(
            clear: () {
              setState(() => inputUrlController.text = '');
              BlocProvider.of<InflateUrlBloc>(context)
                  .add(ClearFieldsForInflateUrlEvent());
            },
            convert: () => BlocProvider.of<InflateUrlBloc>(context)
                .add(GetOriginalUrlEvent(url: inputUrlController.text)),
          ),
        ],
      ),
    );
  }
}
