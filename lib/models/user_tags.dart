import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserTags with ChangeNotifier {
  Firestore store=Firestore.instance;
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

    store.collection("Users").document(userId).setData({"user_tags":_tags});
   // notifyListeners();
  }

  List getTags(){
    return _tags;
  }

  void add(String tag){
    store.collection("Users").document(userId).updateData({'user_tags': FieldValue.arrayUnion([tag])}).then((_){
      _tags.add(tag);
      notifyListeners();
    });
  }

  void delete(String tag){

  store.collection("Users").document(userId).updateData({'user_tags': FieldValue.arrayRemove([tag])}).then((_){
      _tags.remove(tag);
      notifyListeners();
    });
  }

  void loadTags(id)async{
    this.userId=id;
    var user_data = await store.collection("Users").document(userId).get();
    _tags=user_data.data["user_tags"];
    print(_tags);
    notifyListeners();
  }
}