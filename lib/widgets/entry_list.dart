import 'package:flutter/material.dart';
import '../showcaseview/showcase_widget.dart';
import 'list_element.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analysen_filter.dart';
import '../showcaseview/showcaseview.dart';

class EntryList extends StatefulWidget {
  final AnalyseFilter filter;
  final bool buildSearchField;
  final Key analysenKey;
  final Key searchFieldKey;

  EntryList(key, this.filter, this.buildSearchField, this.analysenKey,
      this.searchFieldKey)
      : super(key: key);

  @override
  EntryListState createState() => EntryListState();
}

class EntryListState extends State<EntryList> {
  GlobalKey _one = GlobalKey();
  var filteredList;
  Analysen analysen;
  AnalyseFilter filter;

  void initState() {
    super.initState();
    filter = widget.filter;
  }

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    analysen = Provider.of<Analysen>(context);
    Widget buildHeadline() {
      return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blueGrey))),
        padding: EdgeInsets.only(bottom: 3),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Center(
                  child: FittedBox(
                child: Text(
                  "Analyse Title",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Center(
                  child: FittedBox(
                child: Text("Paar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              )),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Center(
                  child: FittedBox(
                child: Text("Datum",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              )),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 3,
              child: Center(
                  child: FittedBox(
                child: Text("Tags",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              )),
              fit: FlexFit.tight,
            ),
          ],
        ),
      );
    }

    Widget buildSearchfield() {
      return Showcase(
        key: widget.searchFieldKey,
        description: "Suche hier nach Namen von Analysen",
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        child: LayoutBuilder(
          builder: (_, constraint) => Container(
            //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 1,color: Colors.tealAccent)),
            margin: EdgeInsets.only(bottom: 5),
            width: constraint.maxWidth * 0.25,
            child: TextFormField(
              onChanged: (value) {
                analysen.addSearch(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Suche eine Analyse",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: Showcase(
        key: widget.analysenKey,
        description: "Hier kannst du alle deine angelegten Analysen verwalten",
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            widget.buildSearchField
                ? buildSearchfield()
                : SizedBox(
                    height: 20,
                  ),
            buildHeadline(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (ctx, index) =>
                      ListElement(analysen.analysen[index]),
                  itemCount: analysen.analysen.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
