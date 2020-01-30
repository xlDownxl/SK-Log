import 'package:flutter/material.dart';
import '../models/pair_list.dart';
class Pairs extends StatelessWidget {
  final changeMode;
  final changePair;
  Pairs(this.changeMode,this.changePair);


  List buildPairs(){
    var pairs= PairList.pairs;
    var pairWidgets=[];
    pairs.forEach((pair){
      pairWidgets.add(Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(color: Colors.white)),
        child: InkWell(
            child: Center(child: Text(pair,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
          onTap: (){
            changePair(pair);
            changeMode(0);
          },
        ),
      )
      );
    });

    return pairWidgets;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
