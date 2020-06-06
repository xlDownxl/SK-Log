import 'pair_enum.dart';

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
    isSearch = true;
    this.word = word;
    print("filter" + word);
  }
}
