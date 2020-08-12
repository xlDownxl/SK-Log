import 'package:flutter/material.dart';
import '../../flutter_tags/tag.dart';
import 'dart:math';
import '../../models/user_tags.dart';
import 'package:provider/provider.dart';
import '../../models/analysen.dart';
import '../../models/analysen_filter.dart';
class TagsFilterWidget extends StatefulWidget {

  @override
  _TagsFilterWidgetState createState() => _TagsFilterWidgetState();
}

class _TagsFilterWidgetState extends State<TagsFilterWidget> {
  List<String> filterTags = [];

  @override
  Widget build(BuildContext context) {
    var userTags = Provider.of<UserTags>(context);
    var _tags = userTags.getTags();

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
              border: Border.all(width: 1),
              index: index,
              title: _tags[index],
              textStyle: TextStyle(
                fontSize: min(14, max((25 - _tags.length), 21)).toDouble(),
              ),
              active: filterTags.contains(_tags[index]),
              onPressed: (item) {
                if (filterTags.contains(item.title)) {
                  filterTags.remove(item.title);
                  Provider.of<AnalyseFilter>(context, listen: false).addTagFilter(filterTags);
                  Provider.of<Analysen>(context, listen: false)
                      .setFilter(Provider.of<AnalyseFilter>(context, listen: false));
                } else {
                  filterTags.add(item.title);
                  Provider.of<AnalyseFilter>(context, listen: false).addTagFilter(filterTags);
                  Provider.of<Analysen>(context, listen: false)
                      .setFilter(Provider.of<AnalyseFilter>(context, listen: false));
                }
              },
              onRemoved: () {
                setState(() {
                  _tags.removeAt(index);
                  if (filterTags.contains(_tags[index])) {
                    filterTags.remove(_tags[index]);
                    Provider.of<AnalyseFilter>(context, listen: false).addTagFilter(filterTags);
                    Provider.of<Analysen>(context, listen: false)
                        .setFilter(Provider.of<AnalyseFilter>(context, listen: false));
                  }
                });
                return true;
              },
              removeButton: ItemTagsRemoveButton(), // OR null,
            );
          },
        ),
      ),
    );
  }
}
