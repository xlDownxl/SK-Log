import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Analyse with ChangeNotifier {
  String id;
  String link;
  var description;
  String title;
  String learning;
  String pair;
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
  var resPair;

  Future getPair(tv_url,analysen) async {
    var url="https://sk-log.appspot.com/getpair?id="+tv_url;
    return http.get(url).then((response){
      if (response.statusCode!=200){
          print("error in text recognition");
      }
      else{
        var res = json.decode(response.body);
        resPair=res["pair"];
        this.pair = resPair;
        /*if(this.pair==null) { should not happen like this
          this.pair = "Others";
        }*/
        notifyListeners();
        analysen.notify();
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
    pair = snapshot['pair'] ?? null;
    owner = snapshot["owner"] ?? "not implemented";
    date = DateTime.fromMillisecondsSinceEpoch(snapshot["date"]);
  }

  Analyse.fromExample() {
    date = DateTime.now();
    link = "https://www.tradingview.com/x/L8uGb5au/";
    id = DateTime.now().toString();
    title = "Analysis $id";
    pair = "AUDCAD";
    owner = "sdfsdf";
    activeTags = [];
    //learning="Das habe ich gelernt";
    //description="Das ist der Chart";
  }

  String toString() {
    return "ID: $id, Titel: $title, Pair: $pair, Tags: $activeTags, description: $description, learning: $learning, date: $date, link: $link";
  }
}
