import 'package:flutter/material.dart';
import 'pair_enum.dart';
import 'pair_list.dart';
import '../widgets/tags_screen.dart';
class AnalyseFilter{

  PairEnum pair;
  List<String> tags=[];
  DateTime time;
  String word;

  bool isTag;
  bool isPair;
  bool isSearch;

  AnalyseFilter.pairFilter(PairEnum pair){
    isPair=true;
    isTag=false;
    isSearch=false;
    this.pair=pair;
    //print(this.pair);
  }
  AnalyseFilter.tagFilter(List<String> filterList){
    isPair=false;
    isTag=true;
    isSearch=false;
    this.tags=filterList;
  }

  AnalyseFilter.showAll(){
    isPair=false;
    isTag=false;
    isSearch=false;
  }

  AnalyseFilter.search(String word){
    isPair=false;
    isTag=false;
  }

void addSearch(word){
  isSearch=true;
  this.word=word;
  //print("add search"+word);
}

}