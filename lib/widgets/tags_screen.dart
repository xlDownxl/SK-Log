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
  List<String> filters = [];

  void update(newList) {
    Provider.of<Analysen>(context, listen: false)
        .setFilter(AnalyseFilter.tagFilter(newList));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: LayoutBuilder(
        builder: (ctx, constr) => Column(
          children: <Widget>[
            Container(
              height: constr.maxHeight * 0.15,
              child: TagsFilterWidget(filters, update),
            ),
            Container(
              height: constr.maxHeight * 0.85,
              child: EntryList(GlobalKey(),AnalyseFilter.tagFilter(filters), false,GlobalKey(),GlobalKey()),
            ),
          ],
        ),
      ),
    );
  }
}
/*
class FilterList with ChangeNotifier {
  List<String> filters=[];

  void reset(){
    filters=[];
    notifyListeners();
  }

  void add(item){
    print("add");
    filters.add(item);
    notifyListeners();
  }
  void delete(item){
    filters.remove(item);
    notifyListeners();
  }
}*/
