import 'package:flutter/material.dart';
import '../screens/analyse_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../models/analysen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class LeftsideMenu extends StatefulWidget {

  final Function changeMode;
  final Function reset;
  final Key plusButtonKey;
  final Key logOutButtonKey;

  LeftsideMenu(key,this.changeMode, this.reset,this.plusButtonKey,this.logOutButtonKey): super(key: key);

  @override
  LeftsideMenuState createState() => LeftsideMenuState();
}

class LeftsideMenuState extends State<LeftsideMenu> {
  GlobalKey _one = GlobalKey();
  //GlobalKey _two = GlobalKey();
  //GlobalKey _three = GlobalKey();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var analysen = Provider.of<Analysen>(context, listen: false);
    var user = Provider.of<AppUser>(context, listen: false);

    Widget buildEntry(tag, mode) {
      return LayoutBuilder(
        builder: (ctx, constr) => Container(
          width: constr.maxWidth,
          child: FlatButton(
            onPressed: () {
              widget.changeMode(mode);
              widget.reset();
            },
            child: FittedBox(
              child: Text(tag,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            color: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
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
      padding:
          const EdgeInsets.only(top: 20.0, left: 10, right: 10, bottom: 20),
      child: Column(children: [
        Flexible(
          flex: 18,
          child: Column(
            children: <Widget>[
              Flexible(
                  child: Text(
                "Deine Einträge",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Flexible(
                  child: buildEntry(
                "Chronologisch",
                0,
              )),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: buildEntry("Paare", 1),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: buildEntry("Tags", 2),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: LayoutBuilder(
                  builder: (ctx, constraints) => SizedBox(
                    child: Showcase(
                      key: widget.plusButtonKey,
                      description:
                          "Klicke hier um eine neue Analyse zu erstellen",
                      overlayColor: Colors.black,
                      overlayOpacity: 0.5,
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AnalyseScreen.routeName);
                        }, //TODO push
                        child: Container(
                          width: constraints.maxWidth / 3,
                          height: constraints.maxHeight / 2,
                          child: Icon(
                            Icons.add,
                            size: constraints.maxHeight / 2,
                            color: Colors.white,
                            //size:50,
                          ),
                        ),

                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.all(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Showcase(
            key: widget.logOutButtonKey,
            description:
            "Klicke hier um dich auszuloggen",
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            child:InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              analysen.reset();
              user.reset();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                child: Icon(
                  Icons.input,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
          Flexible(
              child:FittedBox(
                child: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),),
            ]),
          ),),
        ),
      ]),
    );
  }
}
