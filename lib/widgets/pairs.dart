import 'package:flutter/material.dart';
import '../models/pair_list.dart';
import 'package:provider/provider.dart';
import 'entry_list.dart';
import '../models/analysen_filter.dart';
import '../models/pair_enum.dart';
class Pairs extends StatefulWidget {

  @override
  _PairsState createState() => _PairsState();
}

class Pair with ChangeNotifier{
  PairEnum pair;
  void change(PairEnum item){
    pair=item;
    notifyListeners();
  }
}

class _PairsState extends State<Pairs> {
  var filterPair;

  List buildPairs(){
    var pairs= PairList.pairs;
    var pairWidgets=[];
    pairs.forEach((pair){
      pairWidgets.add(Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(color: Colors.white)),
        child: InkWell(
            child: Center(child: Text(pair.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
          onTap: (){
              setState(() {
                filterPair.change(pair); //refreshes?
              });
          },
        ),
      )
      );
    });
    return pairWidgets;
  }

  @override
  Widget build(BuildContext context) {
    filterPair=Provider.of<Pair>(context);
    //print("hier gucken"+filterPair.toString());
   // print("build pairs"+filterPair.pair);

    return filterPair.pair==null ?
      Container(
        child: GridView( gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: <Widget>[
          ...buildPairs(),
        ],
      ),
        padding: EdgeInsets.all(20),
      ):EntryList(AnalyseFilter.pairFilter(filterPair.pair),
    );
  }
}
