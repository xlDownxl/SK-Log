import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
class ListElement extends StatelessWidget {

  final String title;
  final String paar;
  final String tags;

  double fSize=20;

  ListElement(this.title,this.paar,this.tags);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(side: BorderSide(color: Theme.of(context).accentColor),borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: (){Navigator.pushNamed(context, AnalyseScreen.routeName,arguments: 2);},
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
          child: Row(children: <Widget>[
            Flexible(child: Center(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: fSize),)),fit: FlexFit.tight,),
            Flexible(child: Center(child: Text(paar,style: TextStyle(fontSize: fSize),)),fit: FlexFit.tight,),
            Flexible(child: Center(child: Text(tags,style: TextStyle(color: Colors.blueGrey,fontSize: fSize),),),fit: FlexFit.tight,),

          ],),
        ),
      ),
    );
  }
}
