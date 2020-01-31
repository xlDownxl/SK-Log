import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analyse.dart';
import 'pair.dart';
import 'analysen_filter.dart';

class Analysen with ChangeNotifier {

  List<Analyse> analysen;

  Analysen(){analysen=[];}


  // TODO create some dummy analysen im constructor und danach die filter logik

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