import 'pair_enum.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class Analyse with ChangeNotifier {
  String id;
  String link;
  var description;
  String title;
  String learning;
  PairEnum pair;
  String owner;
  List<String> activeTags;
  DateTime date;

  Analyse(){
    date=DateTime.now();
    link="";
    id=DateTime.now().toString();
    title="Analysis $id";
    activeTags=[];
   // description="Beschreibung";
    //learning="Learnings";
    title="Analyse Nr. 1";
  }

  Analyse.fromExample(){
    date=DateTime.now();
    link="https://www.tradingview.com/x/L8uGb5au/";
    id=DateTime.now().toString();
    title="Analysis $id";
    pair=PairEnum.AUDCAD;
    owner="sdfsdf";
    activeTags=[];
    //learning="Das habe ich gelernt";
    //description="Das ist der Chart";
  }

  String toString(){
    return "Analyse mit der ID: $id, Titel: $title, Pair: $pair., Tags: $activeTags";
  }

}