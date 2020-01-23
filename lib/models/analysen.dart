import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analyse.dart';
import 'pair.dart';

class Analysen with ChangeNotifier {

  List<Analyse> analysen;

  //String userid im constructor?

  List<Analyse> getAll(){
    return analysen;
  }

  void delete(id){}

  void add(Analyse analyse){}

  List<Analyse> getPair(Pair pair){return analysen;}

  List<Analyse> getTags(List<String> tags){return analysen;}

  List<Analyse> getAllSorted(){return analysen;}

  List<Analyse> searchTitle(String search){return null;}

  List<Analyse> searchContent(String search){return null;}

  Analyse getAnalyse(String id){
    return analysen[0];
  }



}