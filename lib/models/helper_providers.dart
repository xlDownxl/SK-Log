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