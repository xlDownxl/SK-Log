import 'package:flutter/material.dart';
import '../models/pair_list.dart';
import 'package:provider/provider.dart';
import 'entry_list.dart';
import '../models/analysen_filter.dart';
import '../models/pair_enum.dart';
class Pairs extends StatefulWidget {
  Pairs({Key key}):super (key:key);

  @override
  PairsState createState() => PairsState();
}

class Pair with ChangeNotifier{
  PairEnum pair;
  bool isActive=false;

  void change(PairEnum item){
    isActive=true;
    pair=item;
    print("inchange:");
    print(pair);
    notifyListeners();
  }

  void resetPair(){
   // isActive=false;
    //notifyListeners();
  }
}



class PairsState extends State<Pairs> {
  var filterPair;

  List buildPairs(){
    var pairs= PairList.pairs;
    var pairWidgets=[];
    pairs.forEach((pair){
      pairWidgets.add(Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(color: Colors.white)),
        child: InkWell(
            child: Center(child: Text(pair.toString().split('.')[1],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
          onTap: (){
              setState(() {
                filterPair=pair; //refreshes?
              });
          },
        ),
      )
      );
    });
    return pairWidgets;
  }

  void resetPair(){
    setState(() {
      filterPair=null;
    });

    print("reset pair");
  }

  @override
  Widget build(BuildContext context) {

    return filterPair==null ?
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
      ):EntryList(AnalyseFilter.pairFilter(filterPair),false);
  }
}
