import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
class ListElement extends StatelessWidget {

  final String title;
  final String paar;
  final String tags;

  ListElement(this.title,this.paar,this.tags);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.pushNamed(context, AnalyseScreen.routeName,arguments: 2);},
      child: Card(
        shape: RoundedRectangleBorder(side: BorderSide(),borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(children: <Widget>[
            Flexible(child: Center(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold),)),fit: FlexFit.tight,),
            Flexible(child: Center(child: Text(paar)),fit: FlexFit.tight,),
            Flexible(child: Center(child: Text(tags,style: TextStyle(color: Colors.blueGrey),),),fit: FlexFit.tight,),

          ],),
        ),
      ),
    );
  }
}
