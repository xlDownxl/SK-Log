import 'package:flutter/material.dart';
import 'list_element.dart';
class EntryList extends StatefulWidget {
  final int mode;

  EntryList(this.mode);

  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black))),
            child: Row(children: <Widget>[
              Flexible(child: Center(child: Text("Analyse Title",style: TextStyle(fontWeight: FontWeight.bold),)),fit: FlexFit.tight,),
              Flexible(child: Center(child: Text("Paar",style: TextStyle(fontWeight: FontWeight.bold))),fit: FlexFit.tight,),
              Flexible(child: Center(child: Text("Tags",style: TextStyle(fontWeight: FontWeight.bold))),fit: FlexFit.tight,),
        ],),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(child: ListView.builder(
                itemBuilder: (ctx,index){

              return ListElement();
            },
            itemCount: 4,

            ),
            ),
          ),
        ],
      ),
    );
  }
}
