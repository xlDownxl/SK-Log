import 'package:flutter/material.dart';

/*class AnalyseFilter with ChangeNotifier{
  String pair;
  List<String> tags = [];
  DateTime time;
  String word;

  bool isTag;
  bool isPair;
  bool isSearch;
  bool isShowAll;

  AnalyseFilter.pairFilter(String pair) {
    isPair = true;
    isTag = false;
    isSearch = false;
    this.pair = pair;
    isShowAll = false;
  }
  AnalyseFilter.tagFilter(List<String> filterList) {
    isPair = false;
    isTag = true;
    isSearch = false;
    isShowAll = false;
    this.tags = filterList;
  }

  AnalyseFilter.showAll() {
    isPair = false;
    isTag = false;
    isSearch = false;
    isShowAll = true;
  }

  void addSearch(String word) {
    if (word == "") {
      isSearch = false;
      this.word = "";
    } else {
      isSearch = true;
      this.word = word;
    }
  }
}*/

class AnalyseFilter with ChangeNotifier{
  String pair;
  List<String> tags = [];
  DateTime time;
  String word;

  bool isTag;
  bool isPair;
  bool isSearch;

  void reset(){
    isPair = false;
    this.pair = "";
    isTag = false;
    this.tags = [];
    isSearch = false;
  }

  void addPairFilter(String pair) {
    if(pair==""){
      isPair = false;
    }
   else{
      isPair = true;
    }
    this.pair = pair;
  }

  void addTagFilter(List<String> filterList) {
    if(filterList.isEmpty){
      isTag = false;
    }
    else{
      isTag = true;
    }
    this.tags = filterList;
  }

  AnalyseFilter() {
    isPair = false;
    pair="";
    isTag = false;
    tags=[];
    isSearch = false;
  }

  void addSearch(String word) {
    if (word == "") {
      isSearch = false;
      this.word = "";
    } else {
      isSearch = true;
      this.word = word;
    }
  }
}
