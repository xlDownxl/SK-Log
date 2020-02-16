import 'package:flutter/material.dart';
import 'pair_enum.dart';
import 'pair_list.dart';
import '../widgets/tags_screen.dart';

class AnalyseFilter {
  PairEnum pair;
  List<String> tags = [];
  DateTime time;
  String word;

  bool isTag;
  bool isPair;
  bool isSearch;
  bool isShowAll;

  AnalyseFilter.pairFilter(PairEnum pair) {
    isPair = true;
    isTag = false;
    isSearch = false;
    this.pair = pair;
    isShowAll = false;
    //print(this.pair);
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

  void addSearch(word) {
    print("filter");
    isSearch = true;
    this.word = word;
    print("filter" + word);
  }
}
