import 'package:flutter/material.dart';
import 'zefyr_textfield.dart';
import 'dart:math';
import 'package:flutter_tags/tag.dart';

class AnalyseInputArea extends StatefulWidget {
  @override
  _AnalyseInputAreaState createState() => _AnalyseInputAreaState();
}

class _AnalyseInputAreaState extends State<AnalyseInputArea> {

  double spaceBetweenInputs = 10;

  List _tags = [
    "Priceaction",
    "Sequenzen",
    "TP",
    "SL",
    "Überschneidungsbereiche",
    "Sequenzpuzzle",
    "Trademanagement",
    "Risikomanagement",
    "Hedging"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        Flexible(
          flex: 7,
          child: ZefyrTextField("Beschreibung"),
        ),
        SizedBox(
          height: spaceBetweenInputs,
        ),
        Flexible(
          flex: 4,
          child: ZefyrTextField("Fehler/Learnings"),
        ),
        Flexible(
          flex: 3,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Tags(
                spacing: 4,
                runSpacing: 3,
                textField: TagsTextField(
                  hintText: "Füge einen Tag hinzu",
                  textStyle: TextStyle(fontSize: 15),
                  onSubmitted: (String str) {
                    // Add item to the data source.
                    setState(() {
                      // required
                      _tags.add(str);
                    });
                  },
                ),
                itemCount: _tags.length,
                itemBuilder: (int index) {
                  return ItemTags(
                    //textScaleFactor: 2,
                    elevation: 3,
                    key: Key(index.toString()),
                    index: index,
                    title: _tags[index],
                    textStyle: TextStyle(
                      fontSize:
                      min(14, max((25 - _tags.length), 21))
                          .toDouble(),
                    ),
                    active: false,

                    removeButton:
                    ItemTagsRemoveButton(), // OR null,
                    onRemoved: () {
                      // print(min(14,max((23-_tags.length),22)).toDouble().toString());
                      // Remove the item from the data source.
                      setState(() {
                        // required
                        _tags.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
