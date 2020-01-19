import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
import '../screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeftsideMenu extends StatefulWidget {
  final Function changeMode;
  final Function changePair;
  LeftsideMenu(this.changeMode,this.changePair);

  @override
  _LeftsideMenuState createState() => _LeftsideMenuState();
}

class _LeftsideMenuState extends State<LeftsideMenu> {

  @override
  Widget build(BuildContext context) {

    Widget buildEntry(tag,mode){
      return FlatButton(
        onPressed: (){if(mode==0){widget.changePair("");}widget.changeMode(mode);},  //TODO make provider who keeps track of current pair
        child: Text(tag,
            style: TextStyle(fontSize: 16,color: Colors.white)
        ),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );
    }

    return Container(
      color: Colors.lightBlueAccent,
      padding: const EdgeInsets.only(top:20.0,left: 10,right: 10,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(child: Text("Deine Einträge",style: TextStyle(fontSize: 20,color: Colors.white),),),    // schwarz oder weiß?
          Divider(),
          SizedBox(height: 8,),
          buildEntry("Chronologisch", 0,),
          SizedBox(height: 10,),
          buildEntry("Paare", 1),
          SizedBox(height: 10,),
          buildEntry("Tags", 2),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){Navigator.pushNamed(context, AnalyseScreen.routeName);},
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).accentColor,

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
