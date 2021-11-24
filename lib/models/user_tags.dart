import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserTags with ChangeNotifier {
  FirebaseFirestore store = FirebaseFirestore.instance;
  String? userId;
  List<dynamic>? _tags = [];

  Future init(id) {
    this.userId = id;
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

    return store
        .collection("Users")
        .doc(userId)
        .set({"user_tags": _tags});
    // notifyListeners();
  }

  List? getTags() {
    return _tags;
  }

  Future add(String tag) {
    _tags!.add(tag);
    notifyListeners();
    return store.collection("Users").doc(userId).update({
      'user_tags': FieldValue.arrayUnion([tag])
    });
  }

  Future delete(String tag) {
    _tags!.remove(tag);
    notifyListeners();
    return store.collection("Users").doc(userId).update({
      'user_tags': FieldValue.arrayRemove([tag])
    });
  }

  Future loadTags(id) {
    this.userId = id;
    return store.collection("Users").doc(userId).get().then((user_data) {
      _tags = user_data.data()!["user_tags"];
      notifyListeners();
    });
  }
}
