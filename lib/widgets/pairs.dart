import 'package:flutter/material.dart';

class Pairs extends StatelessWidget {
  final changeMode;
  final changePair;
  Pairs(this.changeMode,this.changePair);


  List buildPairs(){
    var pairs=["AUD/USD","AUD/CAD","AUD/JPY","AUD/CHF","AUD/NZD","CAD/CHF","CAD/JPY","CHF/JPY","EUR/AUD","EUR/CAD","EUR/CHF","EUR/GBP","EUR/JPY","EUR/NZD","EUR/USD","GBP/AUD","GBP/CAD","GBP/CHF","GBP/JPY","GBP/NZD","GBP/USD","NZD/CAD","NZD/CHF","NZD/JPY","NZD/USD","USD/CAD","USD/CHF","USD/JPY","XAUUSD"];
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
