import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'analyse.dart';
import 'pair_enum.dart';
import 'analysen_filter.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
class Analysen with ChangeNotifier {
  List<Analyse> analysen = [];

  Analysen(){
    fs.Firestore store = firestore();
  }

  // TODO create some dummy analysen im constructor und danach die filter logik

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase().contains(string2?.toLowerCase());
  }

  List<Analyse> get(AnalyseFilter filter) {
    List<Analyse> result = [];

    if (filter.isPair) {
      result = analysen.where((analyse) {
        return analyse.pair == filter.pair;
      }).toList();
    } else if (filter.isTag) {
      print("tagfilter gefunden");
      if (filter.tags.isNotEmpty) {
        print("tagfilter not empty");
        result = analysen.where((analyse) {
          return filter.tags.every((tag) {
            return analyse.activeTags.contains(tag);
          });
        }).toList();
      } else {
        result = analysen;
      }
    } else {
      result = analysen;
    }

    if (filter.isSearch) {
      print("filter aktiv");
      result = result.where((analyse) {
        return equalsIgnoreCase(analyse.title, filter.word);
      }).toList();
    }
    return result;
  }

  String toString() {
    String result = "";
    analysen.forEach((analyse) {
      result += analyse.toString();
    });
    return result;
  }

  void delete(id) {
    analysen.removeWhere((analyse) {
      return analyse.id == id;
    });
  }

  void add(Analyse analyse) {
    print("add getriggert");

    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection("Analysen");
    ref.add({
      "id":ref.path,
      "title":analyse.title,
      "tags":analyse.activeTags,
      "description":analyse.description,
      "learning":analyse.learning,
      "pair":analyse.pair.toString(),
      "date":analyse.date.millisecondsSinceEpoch,

    });
    analysen.add(analyse);
    notifyListeners();
  }

  void Listen(){

    fs.CollectionReference ref = store.collection("Analysen");

    ref.onSnapshot.listen((querySnapshot) {
      querySnapshot.forEach((document){
        print(document.data().keys);
        print(document.data().values);
        print(document.ref);
      });
    });
  }

  List<Analyse> getPair(PairEnum pair) {
    fs.CollectionReference ref = store.collection("Analysen");
    ref.get().then((snapshot){
      snapshot.forEach((document){
        document.data()["pair"]
      });
    });
    return analysen;
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
    return analysen.firstWhere((analyse) {
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
