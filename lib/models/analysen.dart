import 'dart:collection';
import 'package:flutter/material.dart';
import 'analyse.dart';
import 'analysen_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_pairs.dart';

class Analysen with ChangeNotifier {
  LinkedHashMap analysen =
      LinkedHashMap(); //When specified as <String,Analyse> an type error with dynamic,dynamic not fitting
  LinkedHashMap allAnalysen = LinkedHashMap();
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
    allAnalysen = LinkedHashMap();
    userId = "";
    filter = AnalyseFilter.showAll();
    userPairs = UserPairs();
  }

  Future loadWithId(String id, bool isNew) async{
    this.userId = id;
    if (!isNew) {
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
    else{
      return  this.add(Analyse.fromExample()).then((value)  {
        analysen = allAnalysen;
      notifyListeners();
      });
    }
  }

  void addSearch(String value) {
    filter.addSearch(value);
    get();
  }

  void get() {
    if (filter.isShowAll) {
      analysen = allAnalysen;
    } else {
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
      LinkedHashMap wordFilterAnalysen = LinkedHashMap();
      analysen.values.forEach((analyse) {
        if (equalsIgnoreCase(analyse.title, filter.word)) {
          wordFilterAnalysen[analyse.id] = analyse;
        }
      });
      analysen = wordFilterAnalysen;
    }
    notifyListeners();
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase().contains(string2?.toLowerCase());
  }

  void setFilter(AnalyseFilter filter) {
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

  Future delete(String id) {
    var ref = Firestore.instance
        .collection("Users")
        .document(userId)
        .collection("analysen");

    return ref.document(id).delete().then((_) {
      allAnalysen.removeWhere((key, analyse) {
        //TODO check if both analysen+allanalysen deleted werden
        return key == id;
      });
      notifyListeners();
    });
  }

  Future add(Analyse analyse,) {
    var ref = Firestore.instance
        .collection("Users")
        .document(userId)
        .collection("analysen");
    return ref.add({
      "title": analyse.title,
      "link": analyse.links.toList(),
      "tags": analyse.activeTags,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": analyse.pair,
      "date": analyse.date.millisecondsSinceEpoch,
    }).then((val) {
      analyse.id = val.documentID;
        allAnalysen[analyse.id] = analyse;
      //analysen[analyse.id] = analyse; //TODO auf den grund gehen: warum funktioniert zb update nicht mehr wenn das hier im cod eist
      userPairs.add(analyse.pair);
      notifyListeners();
      return "success";
    });
    /*.timeout(Duration(seconds: 5), onTimeout: () {
      throw ("timeout");
    });*/
  }

  Future update(Analyse analyse) {
    var ref = Firestore.instance
        .collection("Users")
        .document(userId)
        .collection("analysen");

    return ref.document(analyse.id).updateData({
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
    });
  }

  Analyse getAnalyse(String id) {
    return allAnalysen[id];
  }
}
