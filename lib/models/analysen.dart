import 'dart:collection';

import 'package:flutter/material.dart';
import 'analyse.dart';
import 'analysen_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_pairs.dart';
import 'package:firebase_core/firebase_core.dart';

class Analysen with ChangeNotifier {
  LinkedHashMap<String, Analyse> analysen = LinkedHashMap();
  Map<String, Analyse> allAnalysen = LinkedHashMap();
  Firestore store;
  AnalyseFilter filter = AnalyseFilter.showAll();
  String userId;
  UserPairs userPairs = UserPairs();

  Analysen();

  void notify() {
    notifyListeners();
  }

  void reset() {
    analysen = LinkedHashMap();
    allAnalysen = {};
    userId = "";
    filter = AnalyseFilter.showAll();
  }

  Future loadWithId(String id, bool isNew) {
    //TODO isnew=true implementation
    if (!isNew) {
      this.userId = id;

      return Firestore.instance
          .collection("Users")
          .document(userId)
          .collection("analysen")
          .orderBy("date", descending: false)
          .getDocuments()
          .then((snapshot) {
        snapshot.documents.forEach((document) {
          allAnalysen[document.documentID] =
              (Analyse.fromMap(document.data, document.documentID));
          userPairs.add(document.data["pair"]);
        });
      }).then((_) {
        analysen = allAnalysen;
        notifyListeners();
      });
    }
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
        analysen = LinkedHashMap();
        allAnalysen.values.forEach((analyse) {
          if (analyse.pair == filter.pair) {
            analysen[analyse.id] = analyse;
          }
        });
      } else if (filter.isTag) {
        if (filter.tags.isNotEmpty) {
          analysen = LinkedHashMap();
          allAnalysen.values.forEach((analyse) {
            if (filter.tags.every((tag) {
              return analyse.activeTags.contains(tag);
            })) {
              analysen[analyse.id] = analyse;
            }
          });
        } else {
          analysen = allAnalysen;
        }
      }
    }

    if (filter.isSearch) {
      analysen = LinkedHashMap();
      analysen.values.forEach((analyse) {
        if (equalsIgnoreCase(analyse.title, filter.word)) {
          analysen[analyse.id] = analyse;
        }
      });
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
    analysen.values.forEach((analyse) {
      result += analyse.toString();
    });
    return result;
  }

  void delete(id) {
    var ref = Firestore.instance
        .collection("Users")
        .document(userId)
        .collection("analysen");
    ref.document(id).delete().then((_) {
      allAnalysen.removeWhere((key, analyse) {
        //TODO check if both analysen+allanalysen deleted werden
        return key == id;
      });
      notifyListeners();
    });
  } //TODO catcherror

  void add(Analyse analyse, bool ascending) {
    var ref = Firestore.instance
        .collection("Users")
        .document(userId)
        .collection("analysen");
    ref.add({
      "title": analyse.title,
      "link": analyse.links.toList(),
      "tags": analyse.activeTags,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": analyse.pair,
      "date": analyse.date.millisecondsSinceEpoch,
    }).then((val) {
      analyse.id = val.documentID;
      if (!ascending) {
        allAnalysen[analyse.id] = analyse;
      } else {
        allAnalysen[analyse.id] = analyse; //TODO sort
      }
      userPairs.add(analyse.pair);
      notifyListeners();
    });
  }

  void update(Analyse analyse) {
    var ref = Firestore.instance
        .collection("Users")
        .document(userId)
        .collection("analysen");
    ref.document(analyse.id).updateData({
      "title": analyse.title,
      "tags": analyse.activeTags,
      "link": analyse.links,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": analyse.pair,
      "date": analyse.date.millisecondsSinceEpoch,
    }).then((_) {
      allAnalysen[analyse.id] = analyse;
      //analysen[analyse.id]= analyse; //TODO without this can there be errors?
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  Map<String, Analyse> getAllSorted() {
    return analysen;
  }

  List<Analyse> searchTitle(String search) {
    return null;
  }

  List<Analyse> searchContent(String search) {
    return null;
  }

  Analyse getAnalyse(String id) {
    return allAnalysen[id];
  }

/* Analysen.getDummy() {
    var dummy = Analyse();
    dummy.id = "id1";
    dummy.link = "https://www.tradingview.com/x/KgXTpAye/";
    dummy.activeTags = ["Sequenzen", "SL"];
    dummy.title = "Analyse 1";
    dummy.pair = "AUDJPY";
    dummy.owner = "me";
    dummy.date = DateTime.now();
    analysen.add(dummy);
    dummy = Analyse();
    dummy.id = "id2";
    dummy.link = "https://www.tradingview.com/x/KgXTpAye/";
    dummy.activeTags = ["Priceaction"];
    dummy.title = "Analyse 2";
    dummy.pair = "AUDCHF";
    dummy.owner = "me";
    dummy.date = DateTime.now();
    analysen.add(dummy);
    dummy = Analyse();
    dummy.id = "id3";
    dummy.link = "https://www.tradingview.com/x/KgXTpAye/";
    dummy.title = "Analyse 3";
    dummy.pair = "GBPJPY";
    dummy.activeTags = ["TP"];
    dummy.owner = "me";
    dummy.date = DateTime.now();
    analysen.add(dummy);
  }*/
}
