import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/widget_helper.dart';
class UserTags with ChangeNotifier {
  Firestore store = Firestore.instance;
  String userId;
  var _tags = [];

  void init(id) {
    print(id);
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

    store.collection("Users").document(userId).setData({"user_tags": _tags});
    // notifyListeners();
  }

  List getTags() {
    return _tags;
  }

  void add(String tag,BuildContext context) {
    _tags.add(tag);
    notifyListeners();
    store
        .collection("Users")
        .document(userId)
        .updateData({
          'user_tags': FieldValue.arrayUnion([tag])
        })
        .then((_) {})
        .catchError((error) {
          _tags.remove(tag);
          notifyListeners();
          showErrorToast(context, "Something went wrong");
        });
  }

  void delete(String tag,BuildContext context) {
    _tags.remove(tag);
    notifyListeners();
    store
        .collection("Users")
        .document(userId)
        .updateData({
          'user_tags': FieldValue.arrayRemove([tag])
        })
        .then((_) {})
        .catchError((error) {
          _tags.add(tag);
          notifyListeners();
          showErrorToast(context, "Something went wrong");

        });
  }

  Future loadTags(id) {
    this.userId = id;
    return store.collection("Users").document(userId).get().then((user_data) {
      _tags = user_data.data["user_tags"];
      notifyListeners();
    });

  }
}
