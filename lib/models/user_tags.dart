import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class UserTags with ChangeNotifier {
  fs.Firestore store;
  String userId;

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

  UserTags(this.userId);

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
      "Hedging",
    ];
    store = firestore();
    print("init");
    fs.CollectionReference ref = store.collection("User");
    ref.doc(userId).set({"user_tags":_tags});
   // notifyListeners();
  }

  List<String> getTags(){
    return _tags;
  }

  void add(String tag){
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    ref.doc(userId).update(data: {'user_tags': fs.FieldValue.arrayUnion([tag])}).then((_){
      _tags.add(tag);
      notifyListeners();
    });
  }

  void delete(String tag){
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    ref.doc(userId).update(data: {'user_tags': fs.FieldValue.arrayRemove([tag])}).then((_){
      _tags.remove(tag);
      notifyListeners();
    });
  }

  void loadTags()async{
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    var user_data = await ref.doc(userId).get();
    _tags=user_data.data()["user_tags"];
    notifyListeners();
  }
}