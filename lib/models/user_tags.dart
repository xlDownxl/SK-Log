import 'package:flutter/material.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class UserTags with ChangeNotifier {
  fs.Firestore store;
  String userId;
  var _tags=[];

  void init(id){
    print(id);
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
    fs.CollectionReference ref = store.collection("Users");
    ref.doc(userId).set({"user_tags":_tags});
   // notifyListeners();
  }

  List getTags(){
    return _tags;
  }

  void add(String tag){
    store = firestore();
    fs.CollectionReference ref = store.collection("Users");
    ref.doc(userId).update(data: {'user_tags': fs.FieldValue.arrayUnion([tag])}).then((_){
      _tags.add(tag);
      notifyListeners();
    });
  }

  void delete(String tag){
    store = firestore();
    fs.CollectionReference ref = store.collection("Users");
    ref.doc(userId).update(data: {'user_tags': fs.FieldValue.arrayRemove([tag])}).then((_){
      _tags.remove(tag);
      notifyListeners();
    });
  }

  void loadTags(id)async{
    this.userId=id;
    store = firestore();
    fs.CollectionReference ref = store.collection("Users");
    var user_data = await ref.doc(userId).get();
    _tags=user_data.data()["user_tags"];
    print(_tags);
    notifyListeners();
  }
}