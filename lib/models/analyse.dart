import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Analyse with ChangeNotifier {
  String id;
  List<dynamic> links;
  var description;
  String title;
  String learning;
  String pair;
  var activeTags;
  DateTime date;
  var resPair;

  Analyse() {
    date = DateTime.now();
    links = ["","",""];
    id = DateTime.now().toString();
    activeTags = [];
    title = "Neue Analyse";
  }


  Future getPair(tv_url,analysen) async {
    print(tv_url);
    var url="https://sk-log.appspot.com/getpair?id="+tv_url;
    print(url);
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
      this.pair = "Others";
      print(error);
    });

  }

  Future setLink(String link,analysen){
    this.links[0]=link;
    return getPair(link,analysen);
  }

  Analyse.fromMap(Map snapshot,docID) {
    id = docID;
    title = snapshot['title'] ?? '';
    links = snapshot['link'] ?? ["","",""];
    activeTags = snapshot['tags'] ?? [];
    learning = snapshot['learning'] ?? "";
    description = snapshot['description'] ?? "";
    pair = snapshot['pair'] ?? null;
    date = DateTime.fromMillisecondsSinceEpoch(snapshot["date"]);
  }

  Analyse.fromExample() {
    date = DateTime.now();
    links = ["https://www.tradingview.com/x/HGfcBpTV/","",""];
    id = DateTime.now().toString();
    title = "667er SL Öl";
    pair = "OIL";
    activeTags = [];
    description='Markt stand tief etc'; //TODO
    learning='Immer 667 rein';
  }

  String toString() {
    return "ID: $id, Titel: $title, Pair: $pair, Tags: $activeTags, description: $description, learning: $learning, date: $date, link: $links";
  }
}
