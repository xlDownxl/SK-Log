import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analyse.dart';
import 'pair_enum.dart';
import 'analysen_filter.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:enum_to_string/enum_to_string.dart';

class Analysen with ChangeNotifier {
  List<Analyse> analysen = [];
  List<Analyse> allAnalysen = [];
  fs.Firestore store;
  AnalyseFilter filter = AnalyseFilter.showAll();
  String userId;

  Analysen(){}

  void notify(){
    notifyListeners();
  }

  void reset(){
    analysen = [];
    allAnalysen = [];
    userId="";
    filter = AnalyseFilter.showAll();
  }

  void loadWithId(String id, bool isNew){
    //TODO isnew=true implementation
    this.userId=id;
    store = firestore();
    fs.CollectionReference ref = store.collection("Users");

    ref.doc(userId).collection("analysen").get().then((snapshot) {
      snapshot.forEach((document) {
        allAnalysen.add(Analyse.fromMap(document.data(),document.id));
      });
    }).then((_) {
      analysen = allAnalysen;
      notifyListeners();
    });
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase().contains(string2?.toLowerCase());
  }

  void addSearch(String value) {
    filter.addSearch(value);
    get();
  }

  void get() async {
    List<Analyse> result = [];
    if (filter.isShowAll) {
      analysen = allAnalysen;
    } else {
      //TODO index daten in firebase nach paar,
      // TODO search function can filter locally on the data it already pulled
      //TODO tags erstmal weniger priorität, nach performance gucken
      //TODO für die zukunft: für die entry list nur die 3 infos laden, nur beim drauf klicken den rest nachladen

      if (filter.isPair) {
        analysen = allAnalysen.where((analyse) {
          return analyse.pair == filter.pair;
        }).toList();
      } else if (filter.isTag) {
        if (filter.tags.isNotEmpty) {
          analysen = allAnalysen.where((analyse) {
            return filter.tags.every((tag) {
              return analyse.activeTags.contains(tag);
            });
          }).toList();
        } else {
          analysen = allAnalysen;
        }
      }
    }

    if (filter.isSearch) {
      analysen = analysen.where((analyse) {
        return equalsIgnoreCase(analyse.title, filter.word);
      }).toList();
    }

    notifyListeners();
  }

  void setFilter(AnalyseFilter filter) {
    //check if filter the same
    this.filter = filter;
    get();
  }

  String toString() {
    String result = "";
    analysen.forEach((analyse) {
      result += analyse.toString();
    });
    return result;
  }

  void delete(id) {
    fs.Firestore store = firestore();
    var ref = store.collection("Users").doc(userId).collection("analysen");
    ref.doc(id).delete().then((_){
     analysen.removeWhere((analyse) {
        return analyse.id == id;
      });
     allAnalysen.removeWhere((analyse) {
       return analyse.id == id;
     });
     notifyListeners();
    });
  } //TODO catcherror

  void add(Analyse analyse) {
    fs.Firestore store = firestore();
    var ref = store.collection("Users").doc(userId).collection("analysen");
    ref.add({
      "id": ref.id,
      "title": analyse.title,
      "tags": analyse.activeTags,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": EnumToString.parse(analyse.pair),
      "date": analyse.date.millisecondsSinceEpoch,
    });
    print(analysen.length);
    print(allAnalysen.length);
    print(analyse);

    allAnalysen.add(analyse); //nur ein pointer: analysen liste wird auch geaddet
    print(analysen.length);
    print(allAnalysen.length);
    notifyListeners();
  }

  void update(Analyse analyse) {

    fs.Firestore store = firestore();
    var ref = store.collection("Users").doc(userId).collection("analysen");
    ref.doc(analyse.id).update(data: {
      "id": ref.id,
      "title": analyse.title,
      "tags": analyse.activeTags,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": EnumToString.parse(analyse.pair),
      "date": analyse.date.millisecondsSinceEpoch,
    });

    allAnalysen.removeWhere((anal){
      return anal.id==analyse.id;
    });
    allAnalysen.add(analyse);
    notifyListeners();
  }

  List<Analyse> getTags(List<String> tags) {
    return analysen;
  }

  List<Analyse> getAllSorted() {
    return analysen;
  }

  List<Analyse> searchTitle(String search) {
    return null;
  }

  List<Analyse> searchContent(String search) {
    return null;
  }

  Analyse getAnalyse(String id) {
    return allAnalysen.firstWhere((analyse) {
      return analyse.id == id;
    });
  }

  Analysen.getDummy() {
    var dummy = Analyse();
    dummy.id = "id1";
    dummy.link = "https://www.tradingview.com/x/KgXTpAye/";
    dummy.activeTags = ["Sequenzen", "SL"];
    dummy.title = "Analyse 1";
    dummy.pair = PairEnum.AUDJPY;
    dummy.owner = "me";
    dummy.date = DateTime.now();
    analysen.add(dummy);
    dummy = Analyse();
    dummy.id = "id2";
    dummy.link = "https://www.tradingview.com/x/KgXTpAye/";
    dummy.activeTags = ["Priceaction"];
    dummy.title = "Analyse 2";
    dummy.pair = PairEnum.AUDCHF;
    dummy.owner = "me";
    dummy.date = DateTime.now();
    analysen.add(dummy);
    dummy = Analyse();
    dummy.id = "id3";
    dummy.link = "https://www.tradingview.com/x/KgXTpAye/";
    dummy.title = "Analyse 3";
    dummy.pair = PairEnum.GBPJPY;
    dummy.activeTags = ["TP"];
    dummy.owner = "me";
    dummy.date = DateTime.now();
    analysen.add(dummy);
  }
}
