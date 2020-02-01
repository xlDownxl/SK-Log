import 'package:flutter/material.dart';
import 'list_element.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analyse.dart';
import '../models/analysen_filter.dart';
class EntryList extends StatefulWidget {
  final AnalyseFilter filter;

  EntryList(this.filter);

  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {

  var filteredList;
  Analysen analysen;

  TextEditingController editingController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    //print("build entry list");
    //widget.filter.write();

    analysen=Provider.of<Analysen>(context);

    Widget buildHeadline(){
      return Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blueGrey))),
        padding: EdgeInsets.only(bottom: 3),
        child: Row(children: <Widget>[
          Flexible(
            child: Center(
                child: Text("Analyse Title",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Center(
                child: Text("Paar",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Center(
                child: Text("Tags",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,))),
            fit: FlexFit.tight,
          ),
        ],),
      );
    }

    Widget buildSearchfield(){
      return LayoutBuilder(
        builder:(_,constraint)=> Container(
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 1,color: Colors.tealAccent)),
          margin: EdgeInsets.only(bottom: 5),
          width: constraint.maxWidth*0.25,
          child: TextFormField(
            onChanged: (value) {},

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

    //print(analysen.toString());

    //if filter
    var lel=analysen.get(widget.filter); //TODO rename

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          buildSearchfield(),
          buildHeadline(),
          SizedBox(height: 10,),
          Expanded(
            child: Container(child: ListView.builder(
                itemBuilder:(ctx,index)=> ListElement(lel[index]),
              itemCount: lel.length,

            ),
            ),
          ),
        ],
      ),
    );
  }
}
