import 'pair_enum.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;


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

  Future getPair(tv_url,analysen) async {
    var url="https://sk-log.appspot.com/getpair?id="+tv_url;
    return http.get(url).then((response){
      if (response.statusCode!=200){

      }
      else{
        var res = json.decode(response.body);
        print(res);
        this.pair=EnumToString.fromString(PairEnum.values, res["pair"]);
        notifyListeners();
        analysen.notify();
        //analyseListParent.notifyListeners();
      }
    }).catchError((error){
      print(error);
    });

  }

  Future setLink(link,analysen){
    this.link=link;
    return getPair(link,analysen);
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
