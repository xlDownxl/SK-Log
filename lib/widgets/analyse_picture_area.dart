import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/analyse.dart';
import '../models/pair_enum.dart';
import '../models/pair_list.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AnalysePictureArea extends StatefulWidget {
  final bool showError;

  AnalysePictureArea(this.showError);

  @override
  _AnalysePictureAreaState createState() => _AnalysePictureAreaState();
}

class _AnalysePictureAreaState extends State<AnalysePictureArea> {
  var textEditingController;
  Analyse analyse;

  void presentDatePicker(context) {
    showDatePicker(
            context: context,
            firstDate: DateTime.now().subtract(
              Duration(
                days: 100,
              ),
            ),
            initialDate: DateTime.now(),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        analyse.date = pickedData;
      });
    });
  }

  List<Widget> buildPairs(constraints) {
    var height=constraints.maxHeight;
    var width=constraints.maxWidth;
    var pairs = PairList.pairs;
    List<Widget> pairWidgets = [];
    pairs.forEach((pair) {
      pairWidgets.add(Container(
        //height: height/3-15,
        child: Card(
          color: choseColor(pair),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            //side: BorderSide(color: Colors.white)
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                analyse.pair = pair;
              });
            },
            child: Center(
              child: FittedBox(
                child: Text(
                  pair.toString().split('.')[1],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
          ),
        ),
      ));
    });
    return pairWidgets;
  }

  Color choseColor(pair) {
    if (analyse.pair == pair)
      return Theme.of(context).accentColor;
    else
      return Colors.white;
  }
  
  bool isToday(date){
    var now=DateTime.now();
    return date.day==now.day &&  date.month ==now.month && date.year ==now.year;
  }

  @override
  Widget build(BuildContext context) {
    analyse = Provider.of<Analyse>(context);



    return Column(
      children: <Widget>[
        Flexible(
          flex: 4,
          child:  LayoutBuilder(
            builder:(ctx,constraints)=> ResponsiveGridList(
                desiredItemWidth: (constraints.maxWidth)/13,
                minSpacing: 0,
                squareCells: true,
                children: buildPairs(constraints),
            ),
          ),

          /*GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 15,
                childAspectRatio: 2 / 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              children: <Widget>[
                ...buildPairs(),
              ]),*/
        ),

        Flexible(
          child: LayoutBuilder(
            builder: (ctx, constraints) => analyse.link != ""
                ? Image.network(
                    analyse.link,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  )
                : Container(
                    child: Center(
                      child: Text(
                        "Enter your TradingView Link below",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
          ),
          fit: FlexFit.tight,
          flex: 16,
        ),
        Flexible(
          flex: 4,
          child: Container(
            child: LayoutBuilder(
              builder: (ctx, constraints) => Row(
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth * 0.1,
                  ),
                  Container(
                    child: FittedBox(
                        child: Text(
                      "Chart Link:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    width: constraints.maxWidth * 0.1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Link",
                          labelStyle: TextStyle(fontSize: 20)),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      onChanged: (val) {
                        if (val.contains("tradingview")) {
                          setState(() {
                            analyse.link =
                                val; //TODO tradingview link validator
                          });
                        } else {
                          setState(() {
                            analyse.link = "";
                          });
                        }
                      },
                      onFieldSubmitted: (val) {
                        if (val.contains("tradingview")) {
                          setState(() {
                            analyse.link = val;
                          });
                        } else {
                          setState(() {
                            analyse.link = "";
                          });
                        }
                      },
                      controller: textEditingController,
                      initialValue: analyse.link,
                    ),
                    width: constraints.maxWidth * 0.4,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.1,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.2,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        presentDatePicker(context);
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 12,
                              child: Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                width: 5,
                              ),
                            ),
                            Flexible(
                              flex: 25,
                              child: FittedBox(
                                child: Text(
                                  //TODO handle time
                                  isToday(analyse.date)
                                      ? "Heute"
                                      : analyse.date.day.toString() +
                                          "." +
                                          analyse.date.month.toString() +
                                          "." +
                                          analyse.date.year.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                width: 5,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
