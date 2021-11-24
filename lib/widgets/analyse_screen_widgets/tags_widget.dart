import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../../models/user_tags.dart';
import '../../models/analyse.dart';
import '../widget_helper.dart';

class TagsWidget extends StatefulWidget {
  @override
  _TagsWidgetState createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  @override
  Widget build(BuildContext context) {
    Analyse analyse = Provider.of<Analyse>(context);
    UserTags userTags = Provider.of<UserTags>(context);
    List<dynamic> _tags = userTags.getTags()!;

    return Padding(
      padding: EdgeInsets.only(top: 3),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Theme(
            data: ThemeData(
                fontFamily: "OpenSans"
            ),
            child: Tags(
              spacing: 4,
              runSpacing: 3,
              textField: TagsTextField(
                hintText: "Füge einen Tag hinzu", //TODO größe nach unten anpassen
                textStyle: TextStyle(fontSize: 15),
                onSubmitted: (String str) {
                  userTags.add(str).catchError((_) {
                    setState(() {
                      userTags.getTags()!.remove(str);
                    });
                    print("Ein Fehler beim hinzufügen des Tags ist aufgetreten");
                  });
                },
              ),
              itemCount: _tags.length,
              itemBuilder: (int index) {
                return ItemTags(
                  color: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
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
                    if (!item.active!) {
                      analyse.activeTags.remove(item.title);
                    } else {
                      analyse.activeTags.add(item.title);
                    }
                  },

                  /*onRemoved: () {
                    if (analyse.activeTags.contains(_tags[index])) {
                      analyse.activeTags.remove(_tags[index]);
                    }
                      userTags.delete(_tags[index]).catchError((_) {
                          userTags.add(_tags[index]);
                        print(  "Ein Fehler beim entfernen des Tags ist aufgetreten");
                      });
                     // does this really remove or do i need to init usertags alone
                  },*/
                  removeButton: ItemTagsRemoveButton(
                      color: Colors.white,backgroundColor: Colors.red,
                  ), // OR null,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
