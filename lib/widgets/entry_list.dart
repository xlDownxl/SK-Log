import 'package:flutter/material.dart';
import 'list_element.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analyse.dart';
import '../models/analysen_filter.dart';

class EntryList extends StatefulWidget {
  final AnalyseFilter filter;
  final bool buildSearchField;

  EntryList(this.filter, this.buildSearchField);

  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
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
                  child: Text(
                "Analyse Title",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Center(
                  child: Text("Paar",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Center(
                  child: Text("Datum",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 3,
              child: Center(
                  child: Text("Tags",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ))),
              fit: FlexFit.tight,
            ),
          ],
        ),
      );
    }

    Widget buildSearchfield() {
      return LayoutBuilder(
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
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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
    );
  }
}
