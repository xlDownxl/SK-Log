import 'package:flutter/material.dart';
import '../models/user_tags.dart';
import '../widgets/entry_list.dart';
import '../models/analysen_filter.dart';
import 'tags_widget.dart';
import 'package:provider/provider.dart';
import 'tags_filter_widget.dart';
class TagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("tagsscreen wird neu gebuilded");

    var filters=Provider.of<FilterList>(context);

    //show all tags und mach die clickable und darunter/daneben die liste wie sie liv eimmer kleiner wird so mehr man anklickt
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(
        builder:(ctx,constr)=> Column(children: <Widget>[
          Container(
            height: constr.maxHeight*0.15,

            child: TagsFilterWidget(),
          ),
          Container(
            height: constr.maxHeight*0.85,

              child: EntryList(AnalyseFilter.tagFilter(filters),false),
          ),
        ],),
      ),
    );
  }
}

class FilterList with ChangeNotifier {
  List<String> filters=[];

  void add(item){
    filters.add(item);
    notifyListeners();
  }
  void delete(item){
    filters.remove(item);
    notifyListeners();
  }
}