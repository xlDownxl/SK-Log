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
  AnalyseFilter filter;

  Analysen() {
    print("init");
    store = firestore();
    store = firestore();
    fs.CollectionReference ref = store.collection("Analysen");

    ref.get().then((snapshot) {
      snapshot.forEach((document) {
        allAnalysen.add(Analyse.fromMap(document.data()));
      });
    }).then((_) {
      analysen = allAnalysen;
      notifyListeners();
    });
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase().contains(string2?.toLowerCase());
  }

  void get() async {
    List<Analyse> result = [];
    if (filter == null) {
      analysen = allAnalysen;
      notifyListeners();
    } else {
      //TODO index daten in firebase nach paar,
      // TODO search function can filter locally on the data it already pulled
      //TODO tags erstmal weniger priorität, nach performance gucken
      //TODO für die zukunft: für die entry list nur die 3 infos laden, nur beim drauf klicken den rest nachladen

      if (filter.isPair) {
        analysen = allAnalysen.where((analyse) {
          return analyse.pair == filter.pair;
        }).toList();
        notifyListeners();
      } else if (filter.isTag) {
        if (filter.tags.isNotEmpty) {
          analysen = allAnalysen.where((analyse) {
            return filter.tags.every((tag) {
              return analyse.activeTags.contains(tag);
            });
          }).toList();
          notifyListeners();
        } else {
          print("empty filterlist");
          analysen = allAnalysen;
          notifyListeners();
        }
      }
    }
/*
    if (filter.isSearch) {
      print("filter aktiv");
      result = result.where((analyse) {
        return equalsIgnoreCase(analyse.title, filter.word);
      }).toList();
    }
    analysen = result;

    notifyListeners();*/
  }

  void setFilter(AnalyseFilter filter) {
    //andere logik
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
    analysen.removeWhere((analyse) {
      return analyse.id == id;
    });
  }

  void add(Analyse analyse) {
    print("add getriggert");

    fs.Firestore store = firestore();
    fs.CollectionReference ref = store.collection("Analysen");
    ref.add({
      "id": ref.path,
      "title": analyse.title,
      "tags": analyse.activeTags,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": EnumToString.parse(analyse.pair),
      "date": analyse.date.millisecondsSinceEpoch,
    });
    analysen.add(analyse);
    notifyListeners();
  }

  void Listen() {
    fs.CollectionReference ref = store.collection("Analysen");

    ref.onSnapshot.listen((querySnapshot) {
      querySnapshot.forEach((document) {
        print(document.data().keys);
        print(document.data().values);
        print(document.ref);
      });
    });
  }

  List<Analyse> getPair(PairEnum pair) {
    fs.CollectionReference ref = store.collection("Analysen");
    ref.get().then((snapshot) {
      snapshot.forEach((document) {
        print(document.data()["pair"]);
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
