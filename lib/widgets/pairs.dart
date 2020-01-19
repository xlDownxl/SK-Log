import 'package:flutter/material.dart';

class Pairs extends StatelessWidget {
  final changeMode;
  final changePair;
  Pairs(this.changeMode,this.changePair);


  List buildPairs(){
    var pairs=["AUD/USD","AUD/CAD","AUD/JPY","AUD/CHF","AUD/NZD","CAD/CHF","CAD/JPY","CHF/JPY","EUR/AUD","EUR/CAD","EUR/CHF","EUR/GBP","EUR/JPY","EUR/NZD","EUR/USD","GBP/AUD","GBP/CAD","GBP/CHF","GBP/JPY","GBP/NZD","GBP/USD","NZD/CAD","NZD/CHF","NZD/JPY","NZD/USD","USD/CAD","USD/CHF","USD/JPY"];
    var pairWidgets=[];
    pairs.forEach((pair){
      pairWidgets.add(InkWell(
        onTap: (){
          changePair(pair);
          changeMode(0);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black),
          ),
          child: Center(child: Text(pair),),
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
        crossAxisCount: 10,
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
