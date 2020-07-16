import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
import '../models/analyse.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import 'package:flutter/gestures.dart';
import '../routing/application.dart';
class ListElement extends StatelessWidget {
  final String analyseId;

  ListElement(this.analyseId);

  double fSize = 20;
  OverlayEntry overlayEntry;

  String writeTags(tags) {
    StringBuffer builder = StringBuffer();
    for (String value in tags) {
      builder.write(value);
      builder.write(", ");
    }
    var result = builder.toString();
    return result.substring(0, max(result.length - 1, 0));
  }

  showOverlay(BuildContext context, Analyse analyse, Offset position) async {
    OverlayState overlayState = Overlay.of(context);
    if(overlayEntry==null){ // this is to fix the issue that mousewheel triggers on enter, so it will trigger twice and will not delete the first one, so the first on is stuck
      overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: position.dy,
          left: position.dx+30,
          child: Container(
            decoration: BoxDecoration(
                border:
                Border.all(color: Colors.black45, style: BorderStyle.solid)),
            child: Image.network(
              analyse.links[0],
              scale: 2.5,
            ),
          ),
        ),
      );
      overlayState.insert(overlayEntry);
    }
  }

  deleteOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry=null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Analyse analyse = Provider.of<Analysen>(context).analysen[analyseId];

    return MouseRegion(
      onEnter: (event) {
        if(analyse.links[0]!=""){
          showOverlay(context, analyse, event.position);
        }
      },
      onExit: (event) {
        deleteOverlay();
      },
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).accentColor),
            borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Application.router.navigateTo(context, AnalyseScreen.routeName+"/"+analyse.id);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                        child: Text(
                      analyse.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: fSize),
                    )),
                  ),
                  fit: FlexFit.tight,
                ),
                SizedBox(
                  width: 10,
                ),
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
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: FittedBox(
                        child: Text(
                      "${analyse.date.day}.${analyse.date.month}.${analyse.date.year}",
                      style: TextStyle(fontSize: fSize),
                    )),
                  ),
                  fit: FlexFit.tight,
                ),
                SizedBox(
                  width: 10,
                ),
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
          ),),
        //),
      ),
    );
  }
}
