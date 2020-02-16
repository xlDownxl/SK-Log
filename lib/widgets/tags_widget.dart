import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../models/user_tags.dart';
import '../models/analyse.dart';

class TagsWidget extends StatefulWidget {
  @override
  _TagsWidgetState createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {


  @override
  Widget build(BuildContext context) {
    var analyse = Provider.of<Analyse>(context);
    var userTags = Provider.of<UserTags>(context);
    var _tags = userTags.getTags(); // TODO tags als provider

    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Tags(
            spacing: 4,
            runSpacing: 3,
            textField: TagsTextField(
              hintText: "Füge einen Tag hinzu", //TODO größe nach unten anpassen
              textStyle: TextStyle(fontSize: 15),
              onSubmitted: (String str) {
                // Add item to the data source.
                setState(() {
                  // required
                  userTags.add(str);
                });
              },
            ),
            itemCount: _tags.length,
            itemBuilder: (int index) {
              return ItemTags(

                elevation: 3,
                key: Key(index.toString()),
                index: index,
                title: _tags[index],
                textStyle: TextStyle(
                  fontSize: min(14, max((25 - _tags.length), 21)).toDouble(),
                ),
                active: analyse.activeTags.contains(_tags[index]),
                onPressed: (item) {
                  if (!item.active) {
                    // is executed after the active change is executed
                    analyse.activeTags.remove(item.title);
                  } else {
                    analyse.activeTags.add(item.title);
                  }
                },

                removeButton: ItemTagsRemoveButton(), // OR null,
                onRemoved: () {
                  setState(() {
                    userTags.delete(_tags[index]); // does this really remove or do i need to init usertags alone
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
