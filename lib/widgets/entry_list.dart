import 'package:flutter/material.dart';
import 'list_element.dart';


class EntryList extends StatefulWidget {
  final pair;
  EntryList(this.pair);

  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {

  var autoList=["lol","kek"];
  var filteredList;

  TextEditingController editingController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          LayoutBuilder(
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
          ),
          Container(
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
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(child: ListView(
                children: <Widget>[
                  widget.pair==""?ListElement("Falscher TP", "EURUSD", "#TPSetzung"):ListElement("Falscher TP", widget.pair, "#TPSetzung"),
                  widget.pair==""?ListElement("Price Action Analyse", "AUDCAD", "#PriceAction"):ListElement("Price Action Analyse", widget.pair, "#PriceAction"),
                  widget.pair==""?ListElement("Verschachtelte Sequenzen", "GBPUSD", "#Sequenzen #Verschatelung"):ListElement("Verschachtelte Sequenzen", widget.pair, "#Sequenzen #Verschatelung"),
                ],
            ),
            ),
          ),
        ],
      ),
    );
  }
}
