import 'package:flutter/material.dart';

class AnalyseFilter with ChangeNotifier{
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
}
