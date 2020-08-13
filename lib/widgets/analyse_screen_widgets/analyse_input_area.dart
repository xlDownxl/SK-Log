import 'package:flutter/material.dart';
import 'zefyr_textfield.dart';
import 'tags_widget.dart';
import '../../showcaseview/showcaseview.dart';

class AnalyseInputArea extends StatefulWidget {
  final Key descriptionKey;
  final Key learningKey;
  final Key tagsKey;
  final Key textInputKey;
  final Key learningInputKey;

  AnalyseInputArea(this.descriptionKey, this.learningKey, this.tagsKey,
      this.textInputKey, this.learningInputKey);

  @override
  AnalyseInputAreaState createState() => AnalyseInputAreaState();
}

class AnalyseInputAreaState extends State<AnalyseInputArea> {
  double spaceBetweenInputs = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 7,
          child: ZefyrTextField(
              field: "description", key: widget.descriptionKey),
        ),
        SizedBox(
          height: spaceBetweenInputs,
        ),
        Flexible(
          flex: 4,
          child: ZefyrTextField(
            field: "learning",
            key: widget.learningKey,
          ),
        ),

        Flexible(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(bottom: 30,top: 20),
            child: TagsWidget(),
          ),
        ),
      ],
    );
  }
}
