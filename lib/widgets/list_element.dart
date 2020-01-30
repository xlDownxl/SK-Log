import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
import '../models/analyse.dart';
class ListElement extends StatelessWidget {

  final Analyse analyse;
  ListElement(this.analyse);


  double fSize=20;

  @override
  Widget build(BuildContext context) {
    print(analyse);
    return Card(
      shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).accentColor),borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: (){Navigator.pushNamed(context, AnalyseScreen.routeName,arguments: analyse.id);},
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
          child: Row(children: <Widget>[
            Flexible(child: Center(child: Text(analyse.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fSize),)),fit: FlexFit.tight,),
            Flexible(child: Center(child: Text(analyse.pair.toString().split('.')[1],style: TextStyle(fontSize: fSize),)),fit: FlexFit.tight,),
            Flexible(child: Center(child: Text(analyse.activeTags.toString(),style: TextStyle(color: Colors.blueGrey,fontSize: fSize),),),fit: FlexFit.tight,),
          ],),
        ),
      ),
    );
  }
}
