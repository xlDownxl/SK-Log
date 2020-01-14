import 'package:flutter/material.dart';

class LeftsideMenu extends StatefulWidget {
  final Function changeMode;
  LeftsideMenu(this.changeMode);


  @override
  _LeftsideMenuState createState() => _LeftsideMenuState();
}

class _LeftsideMenuState extends State<LeftsideMenu> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(child: Text("Deine Einträge",style: TextStyle(fontSize: 20,),),),
          SizedBox(height: 8,),
          FlatButton(onPressed: (){widget.changeMode(1);}, child: Text("Chronologisch"),),
          FlatButton(onPressed: (){widget.changeMode(2);}, child: Text("Paare"),),
          FlatButton(onPressed: (){widget.changeMode(3);}, child: Text("Tags"),),
        ],
      ),
    );
  }
}
