import 'package:flutter/material.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

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