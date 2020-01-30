import 'package:flutter/material.dart';
import 'pair.dart';
import 'pair_list.dart';
class AnalyseFilter{

  Map<String,bool> pairs ={};
  List<String> tags=[];
  DateTime time;

  AnalyseFilter(){
    /*PairList.pairs.forEach((pair){
      pairs.addAll({pair:true});
    });
    PairList.pairs.forEach((pair){
      pairs.addAll({pair:false});
    });*/

    time=DateTime.now();
  }
}