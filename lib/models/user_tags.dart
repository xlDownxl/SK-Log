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

  UserTags();

  void setUserId(id)async{
    this.userId=id;
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    var user_data = await ref.doc(userId).get();
    _tags=user_data.data()["user_tags"];
    notifyListeners();
  }

  void init(id){
    this.userId=id;
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
    fs.CollectionReference ref = store.collection("ficker");
    print(id);
    ref.add({"user_tags":_tags}).then( // das dokument existiert nicht
            (lel){print(lel);print("done");}
            ).catchError((error) => error.code);
    store.collection("User").doc(userId).set(
        {"user_tags":_tags}).then((lel){print(lel);print("done");}
        ).catchError((error) => error.code);
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
    print(userId);
    ref.doc(userId).update(data: {'user_tags': fs.FieldValue.arrayRemove([tag])}).then((_){
      print("then");
      _tags.remove(tag);
      notifyListeners();
    }).catchError((error) => error.code);
  }

  void loadTags()async{
    store = firestore();
    fs.CollectionReference ref = store.collection("User");
    var user_data = await ref.doc(userId).get();
    _tags=user_data.data()["user_tags"];
    notifyListeners();
  }
}