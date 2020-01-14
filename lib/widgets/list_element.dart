import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
class ListElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.pushNamed(context, AnalyseScreen.routeName);},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: <Widget>[
          Flexible(child: Center(child: Text("Falscher TP")),fit: FlexFit.tight,),
          Flexible(child: Center(child: Text("EURUSD")),fit: FlexFit.tight,),
          Flexible(child: Center(child: Text("#Sequenzen #Priceaction")),fit: FlexFit.tight,),

        ],),
      ),
    );
  }
}
