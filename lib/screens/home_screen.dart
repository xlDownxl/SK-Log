import 'package:flutter/material.dart';
import '../widgets/leftside_menu.dart';
import '../widgets/entry_list.dart';
import '../widgets/pairs.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../models/analysen_filter.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../showcaseview/showcaseview.dart';
import '../models/user.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<PairsState> pairsPage = GlobalKey<PairsState>();
 // final GlobalKey<TagScreenState> tagsPage = GlobalKey<TagScreenState>();

  final GlobalKey<LeftsideMenuState> leftSideMenu =
      GlobalKey<LeftsideMenuState>();
  final GlobalKey<EntryListState> entryList = GlobalKey<EntryListState>();

  GlobalKey _plusButtonKey = GlobalKey();
  GlobalKey logOutButtonKey = GlobalKey();
  GlobalKey searchFieldKey = GlobalKey();
  GlobalKey analysenFieldKey = GlobalKey();
  GlobalKey menuKey = GlobalKey();
  bool dark = true;

  Future showInitDialog(context){
    var width=MediaQuery.of(context).size.width*0.3;
    var height=MediaQuery.of(context).size.height*0.5;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content:  Container(
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
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,),
                      ),
                  ),
                    Flexible(
                      flex:1,
                        child: Container(),
                        //height: height*0.05
                       ),
                    Flexible(
                      flex:10,
                    fit: FlexFit.tight,
                    child: AutoSizeText("Beim ersten Start des Tools werden alle grundlegenden Funktionen dieses Tools kurz erläutert. Falls du zu jeglichem Zeitpunkt eine Frage oder ein Problem bei der Nutzung hast, bitte zögere nicht uns "
                        "über die Telegram Links auf der ersten Seite zu kontaktieren. Wir wünschen dir viel Spaß und Erfolg im Trading!",style: TextStyle(fontSize: 20),),
                  ),
                    Flexible(
                      flex: 1,
                     child: Container(),
                    ),
                    Flexible(
                      flex:4,
                        child: MaterialButton(
                          onPressed: (){
                            Provider.of<AppUser>(context,listen: false).isNew=false;
                            Navigator.pop(context);
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text("Let's get Started!",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                    ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,),
              ),
          );
        });
  }

  @override
  void initState() {
    if (Provider.of<AppUser>(context, listen: false).isNew) {
      Future.delayed(Duration.zero).then((_) {
        showInitDialog(context).then((_) {
        });
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var appBar = GradientAppBar(
      title: Container(
        margin: EdgeInsets.only(top: 2),
          child: Image.asset("assets/logo_neu.png",),
      ),
      centerTitle: true,
      gradient: LinearGradient(colors: [ Theme.of(context).accentColor,Theme.of(context).primaryColor,],stops: [0.65,1]),
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        appBar: appBar,
        body: ShowCaseWidget(
          builder: Builder(
            builder: (ctx) => Container(
              height: deviceHeight,
              width: deviceWidth,
              child: Row(children: [
                Container(
                  width: deviceWidth * 0.25,
                  child: LeftsideMenu(leftSideMenu, _plusButtonKey, logOutButtonKey, menuKey),
                ),
                Container(
                  width: deviceWidth * 0.75,
                  child:
                         EntryList(
                          entryList,
                          true,
                          analysenFieldKey,
                          searchFieldKey,
                        ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
