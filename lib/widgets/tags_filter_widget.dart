import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'dart:math';
import '../models/user_tags.dart';
import 'tags_screen.dart';

import 'package:provider/provider.dart';
class TagsFilterWidget extends StatefulWidget {

  @override
  _TagsFilterWidgetState createState() => _TagsFilterWidgetState();
}

class _TagsFilterWidgetState extends State<TagsFilterWidget> {

  var _tags=UserTags().getTags(); // TODO tags als provider
  FilterList filterTags;

  @override
  Widget build(BuildContext context) {
    print("tags filter widget wid gerebuilded");
    filterTags= Provider.of<FilterList>(context);


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
                fontSize:
                min(14, max((25 - _tags.length), 21))
                    .toDouble(),
              ),
              active: filterTags.filters.contains(_tags[index]),
              onPressed: (item){

                if(filterTags.filters.contains(item.title)){
                  filterTags.delete(item.title);
                }else{
                  filterTags.add(item.title);
                }
                print(filterTags.filters);
              },
              removeButton:
              ItemTagsRemoveButton(), // OR null,
              onRemoved: () {
                // print(min(14,max((23-_tags.length),22)).toDouble().toString());
                // Remove the item from the data source.
                setState(() {
                  // required
                  print(_tags[index]+"<- das ist das was deleted werden soll ");
                  if(filterTags.filters.contains(_tags[index])){
                    filterTags.filters.remove(_tags[index]);
                  }
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
