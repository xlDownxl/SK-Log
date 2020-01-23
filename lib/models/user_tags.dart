import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserTags with ChangeNotifier {

  List<String> _tags;

  List<String> getTags(){
    return _tags;
  }

  void loadTags(String userId){
    notifyListeners();
  }
}