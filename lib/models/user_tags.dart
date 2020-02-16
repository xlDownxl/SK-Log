import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class UserTags with ChangeNotifier {
  fs.Firestore store;

  List<String> _tags = [  //delete wenn inti steht
    "Priceaction",
    "Sequenzen",
    "TP",
    "SL",
    "Überschneidungsbereiche",
    "Sequenzpuzzle",
    "Trademanagement",
    "Risikomanagement",
    "Hedging"
  ];

  void init(){
    _tags = [
      "Priceaction",
      "Sequenzen",
      "TP",
      "SL",
      "Überschneidungsbereiche",
      "Sequenzpuzzle",
      "Trademanagement",
      "Risikomanagement",
      "Hedging"
    ];
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    ref.add({"userTags":_tags});
    notifyListeners();
  }

  List<String> getTags(){
    return _tags;
  }

  void add(String tag){
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    ref.doc("userTags").update();

    _tags.add(tag);
    notifyListeners();
  }

  void delete(String tag){
    store = firestore();
    fs.CollectionReference ref = store.collection("User");


    _tags.remove(tag);
    notifyListeners();
  }

  void loadTags(String userId)async{
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    var user_data = await ref.doc(userId).get();
    _tags=user_data.data()["userTags"];
    notifyListeners();
  }
}