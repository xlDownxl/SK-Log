import 'package:flutter/material.dart';
import 'pair_enum.dart';
import 'pair_list.dart';
import '../widgets/tags_screen.dart';
class AnalyseFilter{

  PairEnum pair;
  List<String> tags=[];
  DateTime time;

  bool isTag;
  bool isPair;

  AnalyseFilter.pairFilter(PairEnum pair){
    isPair=true;
    isTag=false;
    this.pair=pair;
    print(this.pair);
  }
  AnalyseFilter.tagFilter(FilterList filterList){
    isPair=false;
    isTag=true;
    this.tags=filterList.filters;
  }

  AnalyseFilter.showAll(){
    isPair=false;
    isTag=false;

  }



}