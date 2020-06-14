import 'package:flutter/material.dart';
import '../widgets/leftside_menu.dart';
import '../widgets/entry_list.dart';
import '../widgets/tags_screen.dart';
import '../widgets/pairs.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../models/analysen_filter.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../showcaseview/showcaseview.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<PairsState> pairsPage = GlobalKey<PairsState>();
  final GlobalKey<TagScreenState> tagsPage = GlobalKey<TagScreenState>();

  final GlobalKey<LeftsideMenuState> leftSideMenu = GlobalKey<LeftsideMenuState>();
  final GlobalKey<EntryListState> entryList = GlobalKey<EntryListState>();

  GlobalKey _plusButtonKey = GlobalKey();
  GlobalKey logOutButtonKey = GlobalKey();
  GlobalKey searchFieldKey = GlobalKey();
  GlobalKey analysenFieldKey = GlobalKey();

  bool dark=true;
  int mode = 0;

  void changeMode(val) {
    if (val != mode) {
      setState(() {
        mode = val;
      });
    }
  }

  void reset() {
    if (pairsPage.currentState != null) {
      pairsPage.currentState.resetPair(); //TODO fix when not existing
    }
    Provider.of<Analysen>(context, listen: false).setFilter(AnalyseFilter.showAll());
  }

  @override
  void initState() {
    print("init homescreen");
      if(Provider.of<AppUser>(context,listen: false).isNew) {
        print("isNew");
        WidgetsBinding.instance
            .addPostFrameCallback((_) =>
            ShowCaseWidget.of(leftSideMenu.currentContext).startShowCase([
              _plusButtonKey,
              logOutButtonKey,
              searchFieldKey,
              analysenFieldKey,
            ]));
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var appBar = GradientAppBar(
      title: Text("Dein Journal"),
      gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
    );

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    var rightSide = [
      EntryList(entryList,AnalyseFilter.showAll(), true,analysenFieldKey,searchFieldKey,),
      Pairs(key: pairsPage),
      TagScreen(key: tagsPage),
    ];



    return Scaffold(
      appBar: appBar,
      body: ShowCaseWidget(
        builder: Builder(
          builder:(ctx)=> Container(
            height: deviceHeight,
            width: deviceWidth,
            child: Row(children: [
            Container(
              width: deviceWidth * 0.25,
              child: LeftsideMenu(leftSideMenu,changeMode, reset,_plusButtonKey,logOutButtonKey),
            ),
            Container(
              width: deviceWidth * 0.75,
              child: rightSide[mode],
            ),
              ]),
          ),
        ),
      ),
    );
  }
}
