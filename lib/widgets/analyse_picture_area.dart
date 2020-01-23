import 'package:flutter/material.dart';


class AnalysePictureArea extends StatefulWidget {

  @override
  _AnalysePictureAreaState createState() => _AnalysePictureAreaState();
}

class _AnalysePictureAreaState extends State<AnalysePictureArea> {
  var id;
  DateTime _date;
  String link = "https://www.tradingview.com/x/nYWLxqjP/";
  var textEditingController;


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
        _date = pickedData;
      });
    });
  }

  @override
  void initState() {

    Future.delayed(Duration(microseconds: 0)).then((_) {
      setState(() {
        id = ModalRoute.of(context).settings.arguments;
        if (id == null) {
           textEditingController=TextEditingController();
          setState(() {
            link = null;
          });
        }
        else{
           textEditingController=TextEditingController(text: link);
        }
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: LayoutBuilder(
            builder: (ctx, constraints) => link != null
                ? Image.network(
              link,
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
        Flexible(
          flex: 4,
          child: Container(
            child: LayoutBuilder(
              builder: (ctx, constraints) => Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
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
                          link =
                              val; //TODO tradingview link validator
                        });
                        }
                        else{setState(() {
                          link=null;
                        });}
                      },
                      onFieldSubmitted: (val) {
                        if(val.contains("tradingview")){
                          setState(() {
                            link =
                                val; //TODO tradingview link validator
                          });
                        }
                        else{setState(() {
                          link=null;
                        });}
                      },
                      controller: textEditingController,
                     /* initialValue:
                      id == null
                          ? "https://www.tradingview.com/x/nYWLxqjP/"
                          : "lol",*/

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
                            Text(
                              _date == null
                                  ? "Heute"
                                  : _date.day.toString() +
                                  "." +
                                  _date.month.toString() +
                                  "." +
                                  _date.year.toString(),
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
