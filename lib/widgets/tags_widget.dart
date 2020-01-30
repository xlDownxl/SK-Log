import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'dart:math';
import '../models/user_tags.dart';
class TagsWidget extends StatefulWidget {
  @override
  _TagsWidgetState createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {

  var _tags=UserTags().getTags(); // TODO tags als provider


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
