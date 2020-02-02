import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'dart:math';
import '../models/user_tags.dart';
import 'tags_screen.dart';

class TagsFilterWidget extends StatelessWidget {
  final List<String> filterTags;
  final Function update;
  TagsFilterWidget(this.filterTags,this.update);

  var _tags=UserTags().getTags(); // TODO tags als provider

  @override
  Widget build(BuildContext context) {

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
              active: filterTags.contains(_tags[index]),
              onPressed: (item){

                if(filterTags.contains(item.title)){
                  filterTags.remove(item.title);
                  update(filterTags);
                }else{
                  filterTags.add(item.title);
                  update(filterTags);
                }
                //print(filterTags.filters);
              },
              removeButton:
              ItemTagsRemoveButton(), // OR null,
              onRemoved: () {


                  _tags.removeAt(index);
                  if(filterTags.contains(_tags[index])){
                    filterTags.remove(_tags[index]);
                    update(filterTags);
                  }

              },
            );
          },
        ),
      ),
    );
  }
}
