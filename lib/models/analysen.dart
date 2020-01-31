import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analyse.dart';
import 'pair.dart';
import 'analysen_filter.dart';

class Analysen with ChangeNotifier {

  List<Analyse> analysen=[];



  // TODO create some dummy analysen im constructor und danach die filter logik

  Analysen.getDummy(){
    var dummy=Analyse();
    dummy.id="id1";
    dummy.link="https://www.tradingview.com/x/KgXTpAye/";
    //dummy.description="this is analyse 1";
    dummy.title="Analyse 1";
    //dummy.learning="this is learning of analysis 1";
    dummy.pair=Pair.AUDJPY;
    dummy.owner="me";
    dummy.activeTags=[];
    dummy.date=DateTime.now();
    analysen.add(dummy);
     dummy=Analyse();
    dummy.id="id2";
    dummy.link="https://www.tradingview.com/x/KgXTpAye/";
    //dummy.description="this is analyse 2";
    dummy.title="Analyse 2";
    //dummy.learning="this is learning of analysis 2";
    dummy.pair=Pair.AUDCHF;
    dummy.owner="me";
    dummy.activeTags=[];
    dummy.date=DateTime.now();
    analysen.add(dummy);
    dummy=Analyse();
    dummy.id="id3";
    dummy.link="https://www.tradingview.com/x/KgXTpAye/";
    //dummy.description="this is analyse 3";
    dummy.title="Analyse 3";
    //dummy.learning="this is learning of analysis 3";
    dummy.pair=Pair.GBPJPY;
    dummy.owner="me";
    dummy.activeTags=[];
    dummy.date=DateTime.now();
    analysen.add(dummy);
  }


  //String userid im constructor?

  List<Analyse> getAll(AnalyseFilter filter){
    //TODO filter logik
    return analysen;
  }

  String toString(){
    String result="";
    analysen.forEach((analyse){
      result+=analyse.toString();
    });
    return result;

  }

  void delete(id){}

  void add(Analyse analyse){
    analysen.add(analyse);
    notifyListeners();
  }

  List<Analyse> getPair(Pair pair){return analysen;}

  List<Analyse> getTags(List<String> tags){return analysen;}

  List<Analyse> getAllSorted(){return analysen;}

  List<Analyse> searchTitle(String search){return null;}

  List<Analyse> searchContent(String search){return null;}

  Analyse getAnalyse(String id){
    return analysen.firstWhere((analyse){return analyse.id==id;});
  }



}