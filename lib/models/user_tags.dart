import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTags with ChangeNotifier {

  List<String> _tags = [
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

  List<String> getTags(){
    return _tags;
  }

  void loadTags(String userId){
    notifyListeners();
  }
}