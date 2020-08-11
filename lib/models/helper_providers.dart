import 'package:flutter/material.dart';

class Ascending with ChangeNotifier {
  bool asc;
  Ascending(this.asc);
}

class Animations with ChangeNotifier {
  bool animEntry=true;
  bool animTag=true;
  bool animGrid=true;
}

class FilterMode with ChangeNotifier {
  bool showTagsFilter=false;
  void activateTagFilter(){
    showTagsFilter=true;
    notifyListeners();
  }
  void deactivateTagFilter(){
    showTagsFilter=false;
    notifyListeners();
  }
  bool showPairFilter=false;
  void activatePairFilter(){
    showPairFilter=true;
    notifyListeners();
  }
  void deactivatePairFilter(){
    showPairFilter=false;
    notifyListeners();
  }

}