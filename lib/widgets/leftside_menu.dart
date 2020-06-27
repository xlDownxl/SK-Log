import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../models/analysen.dart';
import '../showcaseview/showcaseview.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../screens/analyse_screen.dart';

class LeftsideMenu extends StatefulWidget {
  final Function changeMode;
  final Function reset;
  final Key plusButtonKey;
  final Key logOutButtonKey;

  LeftsideMenu(key, this.changeMode, this.reset, this.plusButtonKey,
      this.logOutButtonKey)
      : super(key: key);

  @override
  LeftsideMenuState createState() => LeftsideMenuState();
}

class LeftsideMenuState extends State<LeftsideMenu> {
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

    final IconData icon = Icons.add;

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
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) => Showcase(
                      key: widget.plusButtonKey,
                      description:
                          "Klicke hier um eine neue Analyse zu erstellen",
                      overlayColor: Colors.black,
                      overlayOpacity: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AnalyseScreen.routeName);
                          },
                          child: LayoutBuilder(
                            builder: (ctx, constr) => Text(
                                String.fromCharCode(icon.codePoint),
                                style: TextStyle(
                                    fontSize: constr.maxHeight * 9 / 11,
                                    fontFamily: icon.fontFamily,
                                    package: icon.fontPackage,
                                    color: Colors.white)),
                          ),
                        ),
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
            description: "Klicke hier um dich auszuloggen",
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                analysen.reset();
                user.reset();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  child: FittedBox(
                    child: Text(
                      "Log Out",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
