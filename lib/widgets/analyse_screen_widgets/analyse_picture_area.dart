import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analyse.dart';
import '../../models/analysen.dart';
import '../../showcaseview/showcaseview.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class AnalysePictureArea extends StatefulWidget {
  final Key analysePictureKey;
  final Key linkKey;
  final Key pairKey;

  AnalysePictureArea(key, this.analysePictureKey, this.pairKey, this.linkKey)
      : super(key: key);

  @override
  AnalysePictureAreaState createState() => AnalysePictureAreaState();
}

class AnalysePictureAreaState extends State<AnalysePictureArea> {
  var textEditingController;
  Analyse analyse;
  bool editPair = false;
  FocusNode editPairFocus = FocusNode();

  bool loading = false;
  bool showTwo = false;
  bool showThree = false;

  var pictureIndex = 0;

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
              height: constraints.maxWidth,
              child: Showcase(
                key: widget.pairKey,
                description:
                    "Wenn du deinen Tradingview Link einfügst wird das Chartsymbol automatisch erkannt und hier angezeigt",
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                  ),
                  child: editPair
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              focusNode: editPairFocus,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2)),
                              ),
                              onSubmitted: (value) {
                                setState(() {
                                  editPair = false;
                                  analyse.pair = value;
                                });
                              },
                            ),
                          ),
                        )
                      : !loading
                          ? InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {
                                setState(() {
                                  editPair = true;
                                  editPairFocus.requestFocus();
                                });
                              },
                              child: Center(
                                child: FittedBox(
                                  child: analyse.links[0] == ""
                                      ? Text("")
                                      : Text(
                                          analyse.pair,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                ),
                              ),
                            )
                          : CircularProgressIndicator(),
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
                  setState(() {
                    loading = true;
                  });

                  analyse
                      .setLink(
                          val, Provider.of<Analysen>(context, listen: false))
                      .then((_) {
                    setState(() {
                      loading = false;
                    });
                  }).catchError((error) {
                    setState(() {
                      analyse.pair = "Others";
                      loading = false;
                    });
                  });
                } else {
                  setState(() {
                    analyse.links[0] = "";
                  });
                }
              }
            : index == 1
                ? (val) {
                    setState(() {
                      analyse.links[1] = val;
                    });
                  }
                : (val) {
                    setState(() {
                      analyse.links[2] = val;
                    });
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
            builder: (ctx, constraints) => Showcase(
              key: widget.analysePictureKey,
              description:
                  "Hier werden deine Screenshots angezeigt. Mit den Punkten unterhalb kannst du zwischen mehreren Bildern wechseln",
              child: (analyse.links[0] != "") && (pictureIndex == 0)
                  ? Image.network(
                      analyse.links[0],
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    )
                  : (analyse.links[1] != "") && (pictureIndex == 1)
                      ? Image.network(
                          analyse.links[1],
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                        )
                      : (analyse.links[2] != "") && (pictureIndex == 2)
                          ? Image.network(
                              analyse.links[2],
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
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                            ),
            ),
          ),
          fit: FlexFit.tight,
          flex: 26,
        ),
        Row(
          children: <Widget>[
            Radio(
              value: 0,
              groupValue: pictureIndex,
              onChanged: (val) {
                setState(() {
                  pictureIndex = val;
                });
              },
            ),
            Radio(
                value: 1,
                groupValue: pictureIndex,
                onChanged: analyse.links[1] != ""
                    ? (val) {
                        setState(() {
                          pictureIndex = val;
                        });
                      }
                    : null),
            Radio(
                value: 2,
                groupValue: pictureIndex,
                onChanged: analyse.links[2] != ""
                    ? (val) {
                        setState(() {
                          pictureIndex = val;
                        });
                      }
                    : null),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        SizedBox(
          height: 20,
        ),
        Flexible(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 42,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Showcase(
                          description:
                              "Füge hier den Link zu deinem Tradingview Screenshot ein, falls du mehr als ein Bild speichern willst, klicke auf den Plus-Button",
                          key: widget.linkKey,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(child: chartLinkDescription),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: linkField(0),
                                    fit: FlexFit.tight,
                                    flex: 3,
                                  ),
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
                      ),
                      showTwo
                          ? Flexible(
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(child: chartLinkDescription),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: linkField(1),
                                          fit: FlexFit.tight,
                                          flex: 3,
                                        ),
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
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(child: chartLinkDescription),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: linkField(2),
                                        fit: FlexFit.tight,
                                        flex: 3,
                                      ),
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
                Flexible(
                  child: Container(),
                ),
                Flexible(
                    flex: 11,
                    fit: FlexFit.tight,
                    child: Container(
                      child: pairShowing,
                      padding: EdgeInsets.all(10),
                    )),
                Flexible(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
