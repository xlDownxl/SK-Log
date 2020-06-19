import 'package:flutter/material.dart';
import 'analyse.dart';
import 'analysen_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_pairs.dart';
import 'package:firebase_core/firebase_core.dart';

class Analysen with ChangeNotifier {
  Map<String,Analyse> analysen = {};
  Map<String,Analyse> allAnalysen = {};
  Firestore store;
  AnalyseFilter filter = AnalyseFilter.showAll();
  String userId;
  UserPairs userPairs=UserPairs();

  Analysen();

  void notify(){
    notifyListeners();
  }

  void reset(){
    analysen = {};
    allAnalysen = {};
    userId="";
    filter = AnalyseFilter.showAll();
  }

  void loadWithId(String id, bool isNew){
    //TODO isnew=true implementation
    if (!isNew){
    this.userId=id;

    Firestore.instance.collection("Users").document(userId).collection("analysen").orderBy("date",descending: true).getDocuments().then((snapshot) {
      snapshot.documents.forEach((document) {
        allAnalysen[document.documentID]=(Analyse.fromMap(document.data,document.documentID));
        userPairs.add(document.data["pair"]);
      });
    }).then((_) {
      analysen = allAnalysen;
      notifyListeners();
    });
    }
    else{

      /*add(Analyse.fromExample());
      analysen=allAnalysen;
      notifyListeners();*/
    }
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase().contains(string2?.toLowerCase());
  }

  void reverse(){
    //allAnalysen=allAnalysen.reversed.toList();
    //analysen=analysen.reversed.toList();
    notifyListeners();
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
        analysen={};
        allAnalysen.values.forEach((analyse){
          if (analyse.pair== filter.pair){
            analysen[analyse.id]=analyse;
          }
        });

      } else if (filter.isTag) {
        if (filter.tags.isNotEmpty) {
          analysen={};
          allAnalysen.values.forEach((analyse) {
            if(
              filter.tags.every((tag) {
               return analyse.activeTags.contains(tag);
              })
            )
            {
              analysen[analyse.id]=analyse;
            }
          });
        } else {
          analysen = allAnalysen;
        }
      }
    }

    if (filter.isSearch) {
      /*analysen = analysen.where((analyse) {
        return equalsIgnoreCase(analyse.title, filter.word);
      }).toList();*/
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
    var ref = Firestore.instance.collection("Users").document(userId).collection("analysen");
    ref.document(id).delete().then((_){
   /*  analysen.removeWhere((analyse) {
        return analyse.id == id;
      });
     allAnalysen.removeWhere((analyse) {
       return analyse.id == id;
     });*/
     notifyListeners();
    });
  } //TODO catcherror

  void add(Analyse analyse,bool ascending) {
    var ref = Firestore.instance.collection("Users").document(userId).collection("analysen");
    ref.add({
      "id": ref.id,
      "title": analyse.title,
      "link": analyse.link,
      "tags": analyse.activeTags,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": analyse.pair,
      "date": analyse.date.millisecondsSinceEpoch,
    });

    analyse.id=ref.id;
    if(!ascending){
      allAnalysen[analyse.id]=analyse;
    }
    else{
      allAnalysen[analyse.id]=analyse; //TODO sort
    }

    userPairs.add(analyse.pair);
    notifyListeners();
  }


  //dict über listen benutzen wegen runtime
  void update(Analyse analyse) {
    var ref = Firestore.instance.collection("Users").document(userId).collection("analysen");
    ref.document(analyse.id).updateData({
      "id": ref.id,
      "title": analyse.title,
      "tags": analyse.activeTags,
      "link": analyse.link,
      "description": analyse.description,
      "learning": analyse.learning,
      "pair": analyse.pair,
      "date": analyse.date.millisecondsSinceEpoch,
    });


   /* allAnalysen.removeWhere((anal){ //TODO think about the way how the list behavious and change this so the analysis really gets updated and not deleted and readded
      return anal.id==analyse.id;
    });
    allAnalysen.add(analyse);*/
    notifyListeners();
  }

  Map<String,Analyse> getAllSorted() {
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
