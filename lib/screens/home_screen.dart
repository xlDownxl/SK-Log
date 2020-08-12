import 'package:flutter/material.dart';
import '../widgets/entry_list.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../models/analysen_filter.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../showcaseview/showcaseview.dart';
import '../models/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/helper_providers.dart';
import '../routing/application.dart';
import "login_screen.dart";
import 'package:fluro/fluro.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<EntryListState> entryList = GlobalKey<EntryListState>();

  GlobalKey _plusButtonKey = GlobalKey();
  GlobalKey logOutButtonKey = GlobalKey();
  GlobalKey searchFieldKey = GlobalKey();
  GlobalKey analysenFieldKey = GlobalKey();
  GlobalKey menuKey = GlobalKey();

  final IconData icon = Icons.add;

  Future showInitDialog(context) {
    var width = MediaQuery.of(context).size.width * 0.3;
    var height = MediaQuery.of(context).size.height * 0.5;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              width: width,
              height: height,
              child: Column(
                children: [
                  Flexible(
                    flex: 7,
                    child: Image.asset("assets/skloggro.png"),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      "Willkommen zu SK!Log",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: AutoSizeText(
                      "Beim ersten Start des Tools werden alle grundlegenden Funktionen dieses Tools kurz erläutert. Falls du zu jeglichem Zeitpunkt eine Frage oder ein Problem bei der Nutzung hast, bitte zögere nicht uns "
                      "über die Telegram Links auf der ersten Seite zu kontaktieren. Wir wünschen dir viel Spaß und Erfolg im Trading!",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 4,
                    child: MaterialButton(
                      onPressed: () {
                        Provider.of<AppUser>(context, listen: false).isNew =
                            false;
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Let's get Started!",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    if (Provider.of<AppUser>(context, listen: false).isNew) {
      Future.delayed(Duration.zero).then((_) {
        showInitDialog(context).then((_) {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = GradientAppBar(
      title: Container(
        margin: EdgeInsets.only(top: 2),
        child: Image.asset(
          "assets/logo_neu.png",
        ),
      ),
      actions: [
        Flexible(
          child: IconButton(
            icon: Icon(Icons.input),
            color: Colors.white,
            onPressed: () {
              Provider.of<Animations>(context, listen: false).animEntry = false;
              Provider.of<Analysen>(context, listen: false).reset();
              Provider.of<AppUser>(context, listen: false).reset();
              Application.router.navigateTo(context, LoginScreen.routeName,
                  transition: TransitionType.inFromBottom);
            },
          ),
        ),
      ],
      centerTitle: true,
      gradient: LinearGradient(colors: [
        Theme.of(context).accentColor,
        Theme.of(context).primaryColor,
      ], stops: [
        0.65,
        1
      ]),
    );

    final deviceWidth = MediaQuery.of(context).size.width;

    var plusButton = LayoutBuilder(
      builder: (ctx, constraints) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: ClipRRect(
          child: InkWell(
            //TODO clip rrect
            onTap: () {
              Application.router.navigateTo(context, "/analyse",
                  transition: TransitionType.fadeIn);
            },
            child: LayoutBuilder(
              builder: (ctx, constr) => Text(
                  String.fromCharCode(icon.codePoint),
                  style: TextStyle(
                      fontSize: constr.maxHeight * 9 / 60,
                      fontFamily: icon.fontFamily,
                      package: icon.fontPackage,
                      color: Colors.white)),
            ),
          ),
        ),
      ),
    );

    Widget menu = Column(children: [
      RaisedButton(child: Text("#",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),), onPressed: (){
        Provider.of<FilterMode>(context,listen: false).activateTagFilter();
      }),
      RaisedButton(child: Text("Pairs",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),), onPressed: (){
        Provider.of<FilterMode>(context,listen: false).activatePairFilter();
      }),
      RaisedButton(child: Text("Clear",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),), onPressed: (){
        Provider.of<AnalyseFilter>(context,listen: false).reset();
        Provider.of<Analysen>(context,listen: false).setFilter(Provider.of<AnalyseFilter>(context,listen: false));
        Provider.of<FilterMode>(context,listen: false).reset();
      }),
    ],);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        floatingActionButton: plusButton,
        appBar: appBar,
        body: ShowCaseWidget(
          builder: Builder(
            builder: (ctx) => Row(
              children: [
               /* Container(
                  width: deviceWidth*0.1,
                  child: menu,
                ),*/
                Container(
                  width: deviceWidth*1,
                  child: EntryList(
                    entryList,
                    true,
                    analysenFieldKey,
                    searchFieldKey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
