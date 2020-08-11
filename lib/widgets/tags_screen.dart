import 'package:flutter/material.dart';
import '../widgets/entry_list.dart';
import '../models/analysen_filter.dart';
import 'package:provider/provider.dart';
import 'tags_filter_widget.dart';
import '../models/analysen.dart';

class TagScreen extends StatefulWidget {
  TagScreen({Key key}) : super(key: key);
  @override
  TagScreenState createState() => TagScreenState();
}

class TagScreenState extends State<TagScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(
        builder: (ctx, constr) => Column(
          children: <Widget>[
            Container(
              height: constr.maxHeight * 0.15,
              child: TagsFilterWidget( ),
            ),
            Container(
              height: constr.maxHeight * 0.85,
              child: EntryList(GlobalKey(), false,GlobalKey(),GlobalKey()),
            ),
          ],
        ),
      ),
    );
  }
}

