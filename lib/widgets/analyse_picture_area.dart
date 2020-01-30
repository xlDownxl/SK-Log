import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/analyse.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../models/SaveFile.dart';
import '../models/pair.dart';

class AnalysePictureArea extends StatefulWidget {
final Function safe;
AnalysePictureArea(this.safe);
  @override
  _AnalysePictureAreaState createState() => _AnalysePictureAreaState();
}

class _AnalysePictureAreaState extends State<AnalysePictureArea> {
  var textEditingController;
  Analyse analyse;

  void presentDatePicker() {
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
        analyse.date=pickedData;
      });
    });
  }


/*  void doML() async {
    print("do ml");
    var file = await DefaultCacheManager().getSingleFile("https://www.fonic.de/dlc/pdf/FONIC-Mobilfunk-Preisliste.pdf");
    print("chache manager done");
    final image = FirebaseVisionImage.fromFile(file);
    print("image is here");
    VisionText whatever=await FirebaseVision.instance.textRecognizer().processImage(image);
    print("done");
    print(whatever.text+"image detection");
  } */

  @override
  void initState() {
    //print("initState");
    //doML();
    super.initState();
  }
  int _radioValue1 = -1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
      if(_radioValue1==1){
        analyse.pair=Pair.AUDCAD;
      }else{
        analyse.pair=Pair.EURCAD;
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    analyse=Provider.of<Analyse>(context);

    Widget buildRadios(){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Radio(
            value: 0,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
           Text(
            'EURUSD',
            style: new TextStyle(fontSize: 16.0),
          ),
           Radio(
            value: 1,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
           Text(
            'AUDUSD',
            style: new TextStyle(fontSize: 16.0),
          ),
           Radio(
            value: 2,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
           Text(
            'USDJPY',
            style: new TextStyle(fontSize: 16.0),
          ),
        ],
      );
    }


       return Column(
      children: <Widget>[
        Flexible(
          child: buildRadios(),
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
                border:
                Border.all(color: Colors.black, width: 2),
              ),
            ),
          ),
          fit: FlexFit.tight,
          flex: 16,
        ),
        RaisedButton(onPressed: (){
          widget.safe();
        }),
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
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
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
                        if(val.contains("tradingview")){
                        setState(() {
                          analyse.link =
                              val; //TODO tradingview link validator
                        });
                        }
                        else{setState(() {
                          analyse.link="";
                        });}
                      },
                      onFieldSubmitted: (val) {
                        if(val.contains("tradingview")){
                          setState(() {
                            analyse.link =
                                val;
                          });
                        }
                        else{setState(() {
                          analyse.link="";
                        });}
                      },
                      controller: textEditingController,
                      initialValue:analyse.link,

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
                        presentDatePicker();
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text( //TODO handle time
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
                            SizedBox(
                              width: 5,
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
