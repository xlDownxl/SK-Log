import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/analyse.dart';
import '../models/pair_enum.dart';
import '../models/pair_list.dart';
import 'package:custom_radio/custom_radio.dart';

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

  List buildPairs(){
    var pairs= PairList.pairs;
    var pairWidgets=[];
    pairs.forEach((pair){

      pairWidgets.add(Card(
        elevation: 2,


        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),side: BorderSide(color: Colors.white)),
        child: FlatButton(
          child: Center(child: Text(pair.toString().split('.')[1],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),),
          onPressed: (){
setState(() {

});
          },
        ),
      )
      );
    });
    return pairWidgets;
  }
  String radioValue = 'First';

  @override
  Widget build(BuildContext context) {

    analyse = Provider.of<Analyse>(context);


    return Column(
      children: <Widget>[
        Flexible(
          flex: 4,
          child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 2 / 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,),children: <Widget>[
            CustomRadio<String, dynamic>(
              value: 'First',
              groupValue: radioValue,
              animsBuilder: (AnimationController controller) => [
                CurvedAnimation(
                    parent: controller,
                    curve: Curves.easeInOut
                ),
                ColorTween(
                    begin: Colors.white,
                    end: Colors.deepPurple
                ).animate(controller),
                ColorTween(
                    begin: Colors.deepPurple,
                    end: Colors.white
                ).animate(controller),
              ],
              builder: (BuildContext context, List<dynamic> animValues, Function updateState, String value) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        radioValue = value;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(18.0),
                        padding: EdgeInsets.all(32.0 + animValues[0] * 12.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: animValues[1],
                            border: Border.all(
                                color: animValues[2],
                                width: 2.0
                            )
                        ),
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 20.0,
                              color: animValues[2]
                          ),
                        )
                    )
                );
              },
            ),
            CustomRadio<String, dynamic>(
              value: 'First',
              groupValue: radioValue,
              animsBuilder: (AnimationController controller) => [
                CurvedAnimation(
                    parent: controller,
                    curve: Curves.easeInOut
                ),
                ColorTween(
                    begin: Colors.white,
                    end: Colors.deepPurple
                ).animate(controller),
                ColorTween(
                    begin: Colors.deepPurple,
                    end: Colors.white
                ).animate(controller),
              ],
              builder: (BuildContext context, List<dynamic> animValues, Function updateState, String value) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        radioValue = value;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(18.0),
                        padding: EdgeInsets.all(32.0 + animValues[0] * 12.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: animValues[1],
                            border: Border.all(
                                color: animValues[2],
                                width: 2.0
                            )
                        ),
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 20.0,
                              color: animValues[2]
                          ),
                        )
                    )
                );
              },
            ),
          ],),
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
                                  analyse.date == null
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
                  // Container(
                  //  width: constraints.maxWidth*0.1,
                  //),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: SizedBox(),
          fit: FlexFit.loose,
        ),
      ],
    );
  }
}
