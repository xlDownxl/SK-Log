import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
import '../screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'pairs.dart';
import 'tags_screen.dart';
class LeftsideMenu extends StatefulWidget {
  final Function changeMode;
  LeftsideMenu(this.changeMode);

  @override
  _LeftsideMenuState createState() => _LeftsideMenuState();
}

class _LeftsideMenuState extends State<LeftsideMenu> {

  @override
  Widget build(BuildContext context) {

    Widget buildEntry(tag,mode){
      return Container(

        child: FlatButton(
          onPressed: (){
            Provider.of<Pair>(context,listen: false).change(null);
            Provider.of<FilterList>(context,listen: false).filters=[];
            widget.changeMode(mode);

            },
          child: Text(tag,
              style: TextStyle(fontSize: 20,color: Colors.white)
          ),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      );
    }

    return Container(
      //color: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              stops: [
                0.5,
                0.8,
              ],
              colors: [
                Colors.cyan,
                Colors.indigo,

              ])),
      padding: const EdgeInsets.only(top:20.0,left: 10,right: 10,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(child: Text("Deine Einträge",style: TextStyle(fontSize: 20,color: Colors.black),),),    // schwarz oder weiß?
          Divider(),
          SizedBox(height: 8,),
          buildEntry("Chronologisch", 0,),
          SizedBox(height: 10,),
          buildEntry("Paare", 1),
          SizedBox(height: 10,),
          buildEntry("Tags", 2),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Provider.of<Pair>(context,listen: false).pair=null;
              Navigator.pushNamed(context, AnalyseScreen.routeName);
              },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,

                child: Center(child: Icon(Icons.add,color: Colors.white,size: 50,)),
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Expanded(child: SizedBox(),),
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Icon(Icons.input,color: Colors.white,),
              SizedBox(width: 10,),
              Text("Log Out",style: TextStyle(fontSize: 20,color: Colors.white),)
            ]),
          ),
        ],
      ),
    );
  }
}
