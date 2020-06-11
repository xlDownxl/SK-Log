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
  bool loading=false;

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
        Flexible(child: Container(),),
        Flexible(
          flex: 7,
          child: Container(
            child: LayoutBuilder(
              builder: (ctx, constraints) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: constraints.maxWidth * 0.02,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.08,
                    child:         LayoutBuilder(
                        builder:(ctx,constraints)=> Container(
                          //width: constraints.maxWidth,
                          height: constraints.maxWidth,
                          child: analyse.link==""?Text(
                              ""
                          ):
                          loading?CircularProgressIndicator():
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              shape: BoxShape.circle,

                              color: Theme.of(context).accentColor,
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                    analyse.pair,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                                ),
                              ),
                            ),

                          ),
                        )
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.05,
                  ),
                  Container(
                    child: FittedBox(
                        child: Text(
                      "Chart Link:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    width: constraints.maxWidth * 0.15,
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
                          loading=true;
                          analyse.setLink(val,Provider.of<Analysen>(context,listen: false)).then((err){
                              loading=false;
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
                    width: constraints.maxWidth * 0.35,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
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
                                      fontSize: 20.0),
                                ),
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
