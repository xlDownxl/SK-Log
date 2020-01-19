import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widgets/input_field.dart';
import '../widgets/bottom_button.dart';
import 'package:flutter_tags/tag.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

class AnalyseScreen extends StatefulWidget {
  static const routeName = "/analyse";


  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {

  String link= "https://www.tradingview.com/x/nYWLxqjP/";
  FocusNode linkFieldNode = FocusNode();
  bool showDescription=true;
  bool showMistake=true;
  bool showLearnings=true;
  bool showTags=true;
  var id;

  List _tags=["Priceaction","Sequenzen","TP","SL","Überschneidungsbereiche","Sequenzpuzzle","Trademanagement","Risikomanagement","Hedging"];


  DateTime _date;

  @override
  void dispose() {
    linkFieldNode.dispose();
    super.dispose();
  }

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
       _date=pickedData;
      });
    });
  }

  void changeMistake(){
    setState(() {
      showMistake=!showMistake;
    });
  }
  void changeDescription(){
    setState(() {
      showDescription=!showDescription;
    });
  }
  void changeLearning(){
    setState(() {
      showLearnings=!showLearnings;
    });
  }
  void changeTags(){
    setState(() {
      showTags=!showTags;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 1)).then((_){
      id=ModalRoute.of(context).settings.arguments;
      if (id==null){setState(() {
        link=null;
      });}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  double spaceBetweenInputs=10;

  Future _displayDialog(BuildContext context) async {
    Alert(
        style: AlertStyle(
          isOverlayTapDismiss: false,
          isCloseButton: false,
        ),
        context: context,
        title: "New Tag",
        /*content: Column(
          children: <Widget>[
            Text("Enter new Tag"),
          ],
        ),*/
        buttons: [
          DialogButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
             //TODO
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  return Scaffold(
      appBar: AppBar(
        title:  Text("Analyse Nr 5",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, decoration: TextDecoration.underline,),),

        centerTitle: true,
      ),
      body: Container(
      padding: EdgeInsets.all(20),
      child:LayoutBuilder(
        builder:(ctx,constr)=> Row(children: <Widget>[
          Container(
            width: constr.maxWidth*0.4,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: LayoutBuilder(
              builder:(_,constraint) => Column(
                children: <Widget>[
                  Container(
                    height: constraint.maxHeight*0.9,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                      showDescription? Flexible(
                        child: InputField(
                                      id!=null?"Der Markt machte erst dies und dann das. Danach noch hier hin und da hin und überall hin bis er nicht mehr fallen kann.":"","Beschreibung",20
                        ),

                        flex: 4,
                      ):Container(),
                        showMistake?SizedBox(height: spaceBetweenInputs,):Container(),
                      showMistake? Flexible(
                        child:InputField(id!=null?"Beim Kaufen den Spread nicht mit einberechnet.":"","Fehler",10),
                        fit: FlexFit.tight,
                        flex: 3,
                      ):Container(),
                        showLearnings?SizedBox(height: spaceBetweenInputs,):Container(),
                      showLearnings? Flexible(
                        child:InputField(id!=null?"Ich muss den Spread beim Kaufen auf den Entry Preis drauf rechnen.":"","Learnings",10),
                        fit: FlexFit.tight,
                        flex: 2,
                      ):Container(),
                        SizedBox(height: spaceBetweenInputs,),
                     /*showTags? Flexible(
                        child:InputField(id!=null?"#Sequenzen #Priceaction":"","Tags",1),
                        fit: FlexFit.tight,
                        flex: 1,
                      ):Container(),*/
                      Flexible(
                        flex: 3,
                       child: SingleChildScrollView(
                         child: Container(
                           padding: EdgeInsets.all(16),
                           child: Tags(
                              spacing: 4,
                             runSpacing: 3,
                             textField: TagsTextField(
                               hintText: "Füge einen Tag hinzu",

                               textStyle: TextStyle(fontSize: 15),
                               onSubmitted: (String str) {
                                 // Add item to the data source.
                                 setState(() {
                                   // required
                                   _tags.add(str);
                                 });
                               },
                             ),

                             itemCount: _tags.length,
                              itemBuilder: (int index){
                                return ItemTags(
                                  //textScaleFactor: 2,
                                  elevation: 3,
                                  key: Key(index.toString()),
                                  index: index,
                                  title: _tags[index],
                                  textStyle: TextStyle( fontSize: min(14,max((25-_tags.length),21)).toDouble(), ),
                                  active: false,

                                  removeButton: ItemTagsRemoveButton( ), // OR null,
                                  onRemoved: (){
                                  // print(min(14,max((23-_tags.length),22)).toDouble().toString());
                                    // Remove the item from the data source.
                                    setState(() {
                                      // required
                                      _tags.removeAt(index);
                                    });
                                  },

                                  );
                                },
                               ),
                         ),
                       ),
                        ),
                      ],),
                  ),
                  Container(
                    height: constraint.maxHeight*0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(child: BottomButton(showDescription,changeDescription,"Hide Beschr."),flex: 6,),
                        Flexible(child: SizedBox(),),
                        Flexible(child: BottomButton(showMistake,changeMistake,"Hide Fehler"),flex: 6),
                        Flexible(child: SizedBox(),),
                        Flexible(child: BottomButton(showLearnings,changeLearning,"Hide Learnings"),flex: 6),
                        //Flexible(child: SizedBox(),),
                       // Flexible(child: BottomButton(showTags,changeTags,"Hide Tags"),flex: 6),
                      ],),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: constr.maxWidth*0.6,
            child: Column(children: <Widget>[
              Flexible(
                child: LayoutBuilder(
                  builder:(ctx,constraints)=> link!=null?Image.network(
                      link,height: constraints.maxHeight,width: constraints.maxWidth,
                    ):Container(
                    child: Center(
                      child:Text(
                        "Enter your TradingView Link below",
                        style: TextStyle(fontSize: 18),
                        ),
                      ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 2),
                      ),
                    ),
                ),
                fit: FlexFit.tight,
                flex: 16,),
              Flexible(
                flex: 4,
                child: Container(
                 child: LayoutBuilder(
                  builder:(ctx,constraints)=> Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth*0.1,
                      ),
                      Container(
                      child: FittedBox(child: Text("Chart Link:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                       width: constraints.maxWidth*0.1,),
                      SizedBox(width: 10,),
                      Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Link",
                                labelStyle: TextStyle(fontSize: 20)
                            ),
                            style: TextStyle(fontSize: 14.0, color: Colors.black,),

                            focusNode: linkFieldNode, //TODO load image when lose focus or completely automatic
                            onChanged:(val){setState(() {
                            link=val; //TODO tradingview link validator
                            });} ,
                            onFieldSubmitted: (val){setState(() {
                              link=val; //TODO tradingview link validator
                            });},
                            initialValue: id!=null?"https://www.tradingview.com/x/nYWLxqjP/":"",
                          ),
                        
                        width: constraints.maxWidth*0.4,
                          ),
                      SizedBox(
                        width: constraints.maxWidth*0.1,
                      ),
                      Container(
                         width: constraints.maxWidth*0.2,
                        child:
                        RaisedButton(
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
                                SizedBox(width: 5,),
                                Text(
                                  _date==null?"Heute":_date.day.toString()+"."+_date.month.toString()+"."+_date.year.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                SizedBox(width: 5,),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
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
            ],),
          )
        ],),
      ),
    ),);
  }
}
