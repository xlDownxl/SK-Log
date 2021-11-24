import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Analyse with ChangeNotifier {
  String? id;
  List<dynamic>? links;
  var description;
  String? title;
  String? learning;
  String? pair;
  var activeTags;
  late DateTime date;

  Analyse() {
    date = DateTime.now();
    links = ["", "", ""];
    id = DateTime.now().toString();
    activeTags = [];
    title = "Neue Analyse";
  }

  void setLink(String link, int index){
    links![index]=link;
    notifyListeners();
  }

  Future getPair(tv_url,) async {
    String url = "https://sk-log.appspot.com/getpair?id=" + tv_url;
    return Future.delayed(Duration.zero);
    /*return http.get(url).then((response) {
      if (response.statusCode != 200) {
        throw ("response timed out");
      } else {
        var res = json.decode(response.body);
        this.pair = res["pair"] ?? "Others";

        notifyListeners();
        //analysen.notify();
      }
    });*/
  }

  Future setLinkAuto(String link,) {
    this.links![0] = link;
    return getPair(link,);
  }

  Analyse.fromMap(Map snapshot, docID) {
    id = docID;
    title = snapshot['title'] ?? '';
    links = snapshot['link'] ?? ["", "", ""];
    activeTags = snapshot['tags'] ?? [];
    learning = snapshot['learning'] ?? "";
    description = snapshot['description'] ?? "";
    pair = snapshot['pair'] ?? "Others";
    date = DateTime.fromMillisecondsSinceEpoch(snapshot["date"]);
  }

  Analyse.fromExample() {
    date = DateTime.now();
    links = ["https://www.tradingview.com/x/HGfcBpTV/", "", ""];
    id = DateTime.now().toString();
    title = "667er SL Öl";
    pair = "OIL";
    activeTags = [];
    description = 'Markt stand tief etc'; //TODO
    learning = 'Immer 667 rein';
  }

  String toString() {
    return "ID: $id, Titel: $title, Pair: $pair, Tags: $activeTags, description: $description, learning: $learning, date: $date, link: $links";
  }
}
