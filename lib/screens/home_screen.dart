import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/leftside_menu.dart';
import '../widgets/entry_list.dart';
import '../widgets/tags_screen.dart';
import '../widgets/pairs.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../models/analysen_filter.dart';
import 'package:provider/provider.dart';
import '../models/dummy.dart';
class HomeScreen extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  final GlobalKey<PairsState> pairsPage =  GlobalKey<PairsState>();
  final GlobalKey<TagScreenState> tagsPage =  GlobalKey<TagScreenState>();


  int mode=0;
  var pair="";

  void changePair(pair){
    this.pair=pair;
  }

  void changeMode(val){
    if(val!=mode){
      setState(() {
        mode=val;
      });
    }
  }

  void reset(){
   // print("reset");
   // pairsPage.currentState.resetPair();
    //print("mitte");
    //tagsPage.currentState.resetTags();
  }

  @override
  Widget build(BuildContext context) {
    var appBar=GradientAppBar(
      title: Text("Dein Journal"),
      gradient: LinearGradient(colors: [Colors.cyan,Colors.indigo]),
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth  =  MediaQuery.of(context).size.width;


    var rightSide =[EntryList(AnalyseFilter.showAll(),true),Pairs(key:pairsPage),TagScreen(key:tagsPage),];

    return  Scaffold(
        appBar:appBar,
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
        child: Row(children:[
          Container(
            width: deviceWidth*0.25,
            child:LeftsideMenu(changeMode,reset),
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
