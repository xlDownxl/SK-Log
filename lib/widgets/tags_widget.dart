import 'package:flutter/material.dart';
import '../flutter_tags/tag.dart';
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
    Analyse analyse = Provider.of<Analyse>(context);
    UserTags userTags = Provider.of<UserTags>(context);
    List<dynamic> _tags = userTags.getTags();

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
                setState(() {
                  userTags.add(str, context);
                });
              },
            ),
            itemCount: _tags.length,
            itemBuilder: (int index) {
              return ItemTags(
                elevation: 3,
                key: Key(index.toString()),
                index: index,
                border: Border.all(width: 1),
                title: _tags[index],
                textStyle: TextStyle(
                  fontSize: min(14, max((25 - _tags.length), 21)).toDouble(),
                ),
                active: analyse.activeTags.contains(_tags[index]),
                onPressed: (item) {
                  if (!item.active) {
                    analyse.activeTags.remove(item.title);
                  } else {
                    analyse.activeTags.add(item.title);
                  }
                },
                onRemoved: () {
                  setState(() {
                    userTags.delete(_tags[
                        index],context); // does this really remove or do i need to init usertags alone
                  });
                },
                removeButton: ItemTagsRemoveButton(), // OR null,
              );
            },
          ),
        ),
      ),
    );
  }
}
