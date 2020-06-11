import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
import '../models/analyse.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';
class ListElement extends StatelessWidget {
  final Analyse analyse;
  ListElement(this.analyse);


  double fSize = 20;

  String writeTags(tags) {

    StringBuffer builder = StringBuffer();
    for (String value in tags) {
      builder.write(value);
      builder.write(", ");
    }
    var result = builder.toString();

    return result.substring(0, max(result.length - 1,0));
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AnalyseScreen.routeName,
              arguments: analyse.id);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Center(
                    child: FittedBox(
                        child:Text(
                  analyse.title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: fSize),
                )),),
                fit: FlexFit.tight,
              ),
              SizedBox(width: 10,),
              Flexible(
                flex: 1,
                child: Center(
                    child: FittedBox(
                      child: Text(
                  analyse.pair,
                  style: TextStyle(fontSize: fSize),
                ),
                    )),
                fit: FlexFit.tight,
              ),
              SizedBox(width: 10,),
              Flexible(
                flex: 1,
                child: Center(
                    child: FittedBox(
                        child:Text(
                      "${analyse.date.day}.${analyse.date.month}.${analyse.date.year}",
                      style: TextStyle(fontSize: fSize),
                    )),),
                fit: FlexFit.tight,
              ),
              SizedBox(width: 10,),
              Flexible(
                flex: 3,
                child: Center(
                  child: AutoSizeText(
                    writeTags(analyse.activeTags),
                    maxLines: 2,
                    style: TextStyle(color: Colors.blueGrey, fontSize: fSize),
                  ),
                ),
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
