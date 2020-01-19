import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/leftside_menu.dart';
import '../widgets/entry_list.dart';
import '../widgets/tags.dart';
import '../widgets/pairs.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int mode=0;
  var pair="";

  void changePair(pair){
    this.pair=pair;
  }

  void changeMode(val){
    setState(() {
      mode=val;
    });
  }


  @override
  Widget build(BuildContext context) {
    var appBar=AppBar(title: Text("Dein Journal"),);

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth   =  MediaQuery.of(context).size.width;

    var rightSide =[EntryList(pair),Pairs(changeMode,changePair),Tags(),];

    return Scaffold(
      appBar:appBar,
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
      child: Row(children:[
        Container(
          width: deviceWidth*0.25,
          child:LeftsideMenu(changeMode,changePair),
        ),
        Container(
          width: deviceWidth*0.75,
          child: rightSide[mode],
        ),
      ]),
      ),
    );
  }
}
