import 'package:flutter/material.dart';
import '../models/user_tags.dart';
import '../widgets/entry_list.dart';
import '../models/analysen_filter.dart';

class Tags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //show all tags und mach die clickable und darunter/daneben die liste wie sie liv eimmer kleiner wird so mehr man anklickt
    return LayoutBuilder(
      builder:(ctx,constr)=> Column(children: <Widget>[
        Container(
          height: constr.maxHeight*0.2,
          child: GridView(
             gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: <Widget>[Text("lel"),],
      ),
        ),
        Container(
          height: constr.maxHeight*0.8,
            child: EntryList(AnalyseFilter()),
        ),
      ],),
    );
  }
}
