import 'package:flutter/material.dart';

class UserPairs {
  var _pairs=[];

  List getPairs(){
    return _pairs;
  }

  void add(String pair){
    if (!_pairs.contains(pair)){  // make _pairs a dict to save runtime
        _pairs.add(pair);
    }
  }
}