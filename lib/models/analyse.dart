import 'pair_enum.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:enum_to_string/enum_to_string.dart';

class Analyse with ChangeNotifier {
  String id;
  String link;
  var description;
  String title;
  String learning;
  PairEnum pair;
  String owner;
  var activeTags;
  DateTime date;

  Analyse() {
    date = DateTime.now();
    link = "";
    id = DateTime.now().toString();
    title = "Analysis $id";
    activeTags = [];
    title = "Analyse Nr. 1";
  }

  Analyse.fromMap(Map snapshot,docID) {
    id = docID;
    title = snapshot['title'] ?? '';
    link = snapshot['link'] ?? '';
    activeTags = snapshot['tags'] ?? [];
    learning = snapshot['learning'] ?? "";
    description = snapshot['description'] ?? "";
    pair = EnumToString.fromString(PairEnum.values, snapshot['pair']) ?? null;
    owner = snapshot["owner"] ?? "not implemented";
    date = DateTime.fromMillisecondsSinceEpoch(snapshot["date"]);
  }

  Analyse.fromExample() {
    date = DateTime.now();
    link = "https://www.tradingview.com/x/L8uGb5au/";
    id = DateTime.now().toString();
    title = "Analysis $id";
    pair = PairEnum.AUDCAD;
    owner = "sdfsdf";
    activeTags = [];
    //learning="Das habe ich gelernt";
    //description="Das ist der Chart";
  }

  String toString() {
    return "ID: $id, Titel: $title, Pair: $pair, Tags: $activeTags, description: $description, learning: $learning, date: $date, link: $link";
  }
}
