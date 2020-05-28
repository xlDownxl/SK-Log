import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'dart:math';
import '../models/user_tags.dart';
import 'tags_screen.dart';
import 'package:provider/provider.dart';
import '../models/analyse.dart';

class TagsFilterWidget extends StatefulWidget {
  final List<String> filterTags;
  final Function update;
  TagsFilterWidget(this.filterTags, this.update);

  @override
  _TagsFilterWidgetState createState() => _TagsFilterWidgetState();
}

class _TagsFilterWidgetState extends State<TagsFilterWidget> {
  @override
  Widget build(BuildContext context) {
    var userTags = Provider.of<UserTags>(context);
    var _tags = userTags.getTags(); // TODO tags als provider

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Tags(
          spacing: 4,
          runSpacing: 3,
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
              active: widget.filterTags.contains(_tags[index]),
              onPressed: (item) {
                if (widget.filterTags.contains(item.title)) {
                  widget.filterTags.remove(item.title);
                  widget.update(widget.filterTags);
                } else {
                  widget.filterTags.add(item.title);
                  widget.update(widget.filterTags);
                }
              },
              onRemoved: () {
                setState(() {
                  _tags.removeAt(index);
                  if(widget.filterTags.contains(_tags[index])){
                    widget.filterTags.remove(_tags[index]);
                    widget.update(widget.filterTags);
                  }
                });
                return true;
              },
               removeButton:
              ItemTagsRemoveButton(
              ),// OR null,
            );
          },
        ),
      ),
    );
  }
}
