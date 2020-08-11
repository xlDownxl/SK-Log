import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'entry_list.dart';
import '../models/analysen_filter.dart';
import '../models/analysen.dart';
import '../models/user_pairs.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Pairs extends StatefulWidget {
  Pairs({Key key}) : super(key: key);

  @override
  PairsState createState() => PairsState();
}

class PairsState extends State<Pairs> {
  Analysen analysen;

  List buildPairs() {
    var pairs = Provider.of<Analysen>(context, listen: false)
        .userPairs
        .getPairs(); //listen = false?
    var pairWidgets = [];
    var counter = 0;
    pairs.forEach((pair, value) {
      pairWidgets.add(
        AnimationConfiguration.staggeredGrid(
          position: counter,
          columnCount: 6,
          duration: const Duration(milliseconds: 375),
          child: ScaleAnimation(
              child: FadeInAnimation(
                  child: Card(
            elevation: 2,
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      pair,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              onTap: () {
                analysen.setFilter(AnalyseFilter.pairFilter(pair));
              },
            ),
          ))),
        ),
      );
    });
    return pairWidgets;
  }

  @override
  Widget build(BuildContext context) {
    analysen = Provider.of<Analysen>(context);

    return analysen.filter.isPair == false
        ? Container(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //crossAxisCount: 8,
                maxCrossAxisExtent: 130,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: <Widget>[
                ...buildPairs(),
              ],
            ),
            padding: EdgeInsets.all(20),
          )
        : EntryList(GlobalKey(), false, GlobalKey(), GlobalKey());
  }
}
