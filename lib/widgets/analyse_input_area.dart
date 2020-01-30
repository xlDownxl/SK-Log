import 'package:flutter/material.dart';
import 'zefyr_textfield.dart';
import 'tags_widget.dart';


class AnalyseInputArea extends StatefulWidget {
  final descriptionKey;
  final learningKey;
  AnalyseInputArea(this.descriptionKey,this.learningKey);
  @override
  _AnalyseInputAreaState createState() => _AnalyseInputAreaState();
}

class _AnalyseInputAreaState extends State<AnalyseInputArea> {

  double spaceBetweenInputs = 10;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Flexible(
          flex: 7,
          child: ZefyrTextField(field:"description",key:widget.descriptionKey),
        ),
        SizedBox(
          height: spaceBetweenInputs,
        ),
        Flexible(
          flex: 4,
          child: ZefyrTextField(field:"learning",key:widget.learningKey),
        ),
        Flexible(
          flex: 3,
          child: TagsWidget(),
        ),
      ],
    );
  }
}
