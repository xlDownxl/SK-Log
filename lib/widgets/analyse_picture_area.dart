import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/analyse.dart';
import '../models/analysen.dart';

class AnalysePictureArea extends StatefulWidget {
  final bool showError;

  AnalysePictureArea(this.showError);

  @override
  _AnalysePictureAreaState createState() => _AnalysePictureAreaState();
}

class _AnalysePictureAreaState extends State<AnalysePictureArea> {
  var textEditingController;
  Analyse analyse;

  bool loading = false;
  bool showTwo = false;
  bool showThree = false;

  @override
  void initState() {
    analyse = Provider.of<Analyse>(context, listen: false);
    if (analyse.links[1] != "") {
      showTwo = true;
    }
    if (analyse.links[2] != "") {
      showThree = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    analyse = Provider.of<Analyse>(context);

    Widget pairShowing = LayoutBuilder(
        builder: (ctx, constraints) => Container(
              //width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: analyse.links[0] == ""
                  ? Text("")
                  : loading
                      ? CircularProgressIndicator()
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                analyse.pair,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
            ));

    Widget linkField(int index) {
      return TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Link",
            labelStyle: TextStyle(fontSize: 20)),
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        onChanged: index == 0
            ? (val) {
                if (val.contains("tradingview")) {
                  loading = true;
                  analyse
                      .setLink(
                          val, Provider.of<Analysen>(context, listen: false))
                      .then((err) {
                    loading = false;
                  });
                } else {
                  setState(() {
                    analyse.links[0] = "";
                  });
                }
              }
            : index == 1
                ? (val) {
                    analyse.links[1] = val;
                  }
                : (val) {
                    analyse.links[2] = val;
                  },
        controller: textEditingController,
        initialValue: analyse.links[index] != "" ? analyse.links[index] : "",
      );
    }

    Widget chartLinkDescription = FittedBox(
        child: Text(
      "Chart Link:",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ));

    return Column(
      children: <Widget>[
        Flexible(
          child: LayoutBuilder(
            builder: (ctx, constraints) => analyse.links[0] != ""
                ? Image.network(
                    analyse.links[0],
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  )
                : Container(
                    child: Center(
                      child: Text(
                        "Copy und Paste deinen Tradingview Link in den unteren Kasten",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
          ),
          fit: FlexFit.tight,
          flex: 26,
        ),
        SizedBox(
          height: 20,
        ),
        Flexible(
          flex: 10,
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(children: [
                          Flexible(child: chartLinkDescription),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(child: linkField(0)),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                if (showTwo) {
                                  showThree = true;
                                } else {
                                  showTwo = true;
                                }
                              });
                            },
                          ),
                        ]),
                      ),
                    ),
                    showTwo
                        ? Flexible(
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(children: [
                                  Flexible(child: chartLinkDescription),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(child: linkField(1)),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          showTwo = false;
                                          analyse.links[1] = "";
                                        });
                                      }),
                                ])))
                        : Container(),
                    showThree
                        ? Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(children: [
                                Flexible(child: chartLinkDescription),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(child: linkField(2)),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        showThree = false;
                                        analyse.links[2] = "";
                                      });
                                    }),
                              ]),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: Container(
                child: pairShowing,
                padding: EdgeInsets.symmetric(vertical: 20),
              )),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
