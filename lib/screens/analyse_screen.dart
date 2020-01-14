import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/input_field.dart';
class AnalyseScreen extends StatefulWidget {

  static const routeName = "/analyse";

  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {

  void presentDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        Duration(
          days: 100,
        ),
      ),
      initialDate: DateTime.now(),
      lastDate: DateTime.now()
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
       //TODO
      });

    });
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: Text("SK!Log",style: TextStyle(fontSize: 30),),centerTitle: true,)
      ,body: Container(
      padding: EdgeInsets.all(20),

      child:LayoutBuilder(
        builder:(ctx,constr)=> Row(children: <Widget>[
          Container(
            width: constr.maxWidth*0.4,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(children: <Widget>[
              Flexible(child: Text("Analyse Nr 5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, decoration: TextDecoration.underline,),),fit: FlexFit.loose,),
              SizedBox(height: 30,),
              Align(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("Beschreibung",style: TextStyle(fontSize: 24),),
                ),
                alignment: Alignment.centerLeft,
                ),
              Flexible(
                child:InputField("Der Markt machte erst dies und dann das. Danach noch hier hin und da hin und überall hin bis er nicht mehr fallen kann."),
                fit: FlexFit.tight,
              ),
               SizedBox(height: 20,),
               Align(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("Fehler",style: TextStyle(fontSize: 24),),
                ),
                alignment: Alignment.centerLeft,
                ),
              Flexible(
                child:InputField("Beim Kaufen den Spread nicht mit einberechnet."),
                fit: FlexFit.tight,
              ),
              SizedBox(height: 20,),
              Align(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("Learnings",style: TextStyle(fontSize: 24),),
                ),
                alignment: Alignment.centerLeft,
              ),
              Flexible(
                child:InputField("Ich muss den Spread beim Kaufen auf den Entry Preis drauf rechnen."),
                fit: FlexFit.tight,
              ),
               SizedBox(height: 20,),
               Align(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text("Tags",style: TextStyle(fontSize: 24),),
                ),
                alignment: Alignment.centerLeft,
                ),
              Flexible(
                child:InputField("#Sequenzen #Priceaction"),
                fit: FlexFit.tight,
              ),

            ],),
          ),
          Container(
            width: constr.maxWidth*0.6,
            child: Column(children: <Widget>[
              Flexible(child: LayoutBuilder(builder:(ctx,constraints)=> Image.network("https://www.tradingview.com/x/pwj0jdsL/",height: constraints.maxHeight,width: constraints.maxWidth,),),fit: FlexFit.tight,flex: 5,),
              Flexible(
              child: Container(
                padding: EdgeInsets.only(bottom: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(child:Container(),),
                    Text("Chart Link:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    Text("https://www.tradingview.com/x/pwj0jdsL/",style: TextStyle(fontSize: 18),),
                    Expanded(child: SizedBox(),),
                    RaisedButton(
                      onPressed: presentDatePicker,
                      child: Text("Choose Date"),
                    ),
                    Flexible(child:Container(),),
                  ],
                ),
              ),
              ),
            ],),
          )
        ],),
      ),
    ),);
  }
}
