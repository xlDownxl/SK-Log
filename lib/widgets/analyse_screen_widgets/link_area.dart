import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analyse.dart';
import '../../models/analysen.dart';

class LinkArea extends StatefulWidget {
  final pairShowing;
  LinkArea(key,this.pairShowing): super(key: key);

  @override
  LinkAreaState createState() => LinkAreaState();
}

class LinkAreaState extends State<LinkArea> {
  bool showTwo = false;
  bool showThree = false;
  late Analyse analyse;
  var textEditingController;
  Future? pairLoadingFuture;

  @override
  void initState() {
    analyse = Provider.of<Analyse>(context, listen: false);
    if (analyse.links![1] != "") {
      showTwo = true;
    }
    if (analyse.links![2] != "") {
      showThree = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    analyse = Provider.of<Analyse>(context, listen: false);
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
            widget.pairShowing.currentState.editLoading(true);
             pairLoadingFuture=analyse
                .setLinkAuto(
                val,)
                .then((_) {
                  try{
                widget.pairShowing.currentState.editLoading(false);
                  } catch (error){
                  }

            }).catchError((error) {
                analyse.pair = "Others";
                widget.pairShowing.currentState.editLoading(false);
            });
          } else {
              analyse.setLink("", 0);
          }
        }
            : index == 1
            ? (val) {
          analyse.setLink(val, 1);
        }
            : (val) {
            analyse.setLink(val, 2);
        },
        controller: textEditingController,
        initialValue: analyse.links![index] != "" ? analyse.links![index] : "",
      );
    }

    Widget chartLinkDescription = FittedBox(
        child: Text(
          "Chart Link:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
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
                            analyse.setLink("", 1);
                            setState(() {
                              showTwo = false;
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
                        analyse.setLink("", 2);
                        setState(() {
                          showThree = false;
                        });
                      }),
                ]),
          ),
        )
            : Container(),
      ],
    );
  }
}
