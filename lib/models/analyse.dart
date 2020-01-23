import 'pair.dart';

class Analyse {
  String id;
  String link;
  String description;
  String title;
  String learning;
  Pair pair;
  String owner;
  List<String> activeTags;

  String toString(){
    return "Analyse mit der ID: $id, Titel: $title, Pair: $pair.";
  }

}