import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';
import '../widgets/analyse_screen_widgets/analyse_input_area.dart';
import '../widgets/analyse_screen_widgets/analyse_picture_area.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analyse.dart';
import '../widgets/analyse_screen_widgets/zefyr_textfield.dart';
import '../showcaseview/showcaseview.dart';
import '../widgets/widget_helper.dart';
import '../models/screen_loader.dart';
import '../routing/application.dart';

class AnalyseScreen extends StatefulWidget {
  final analyseId;
  AnalyseScreen(this.analyseId);

  static const routeName = "/analyse";
  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen>
    with ScreenLoader<AnalyseScreen> {
  FocusNode titleFocus = FocusNode();
  Analyse analyse;

  final GlobalKey<ZefyrTextFieldState> descriptionKey =
      GlobalKey<ZefyrTextFieldState>();
  final GlobalKey<ZefyrTextFieldState> learningKey =
      GlobalKey<ZefyrTextFieldState>();
  final GlobalKey<AnalysePictureAreaState> apicKey =
      GlobalKey<AnalysePictureAreaState>();

  GlobalKey pairKey = GlobalKey();
  GlobalKey linkKey = GlobalKey();
  GlobalKey analysePictureKey = GlobalKey();
  GlobalKey tagsKey = GlobalKey();
  GlobalKey descriptionInputKey = GlobalKey();
  GlobalKey learningInputKey = GlobalKey();
  GlobalKey trashKey = GlobalKey();
  GlobalKey saveKey = GlobalKey();

  @override
  void initState() {
    if (widget.analyseId == null) {
      analyse = Analyse();
    } else {
      analyse = Provider.of<Analysen>(context, listen: false)
          .getAnalyse(widget.analyseId);
    }
    super.initState();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    super.dispose();
  }

  Future safe() {
    if (analyse.pair == null) {
      analyse.pair = "Others";
    }
    descriptionKey.currentState.safeDocument();
    learningKey.currentState.safeDocument();
    if (widget.analyseId == null) {
      return Provider.of<Analysen>(context, listen: false)
          .add(analyse,);
    } else {
      return Provider.of<Analysen>(context, listen: false).update(analyse);
    }
  }

  @override
  Widget loader() {
    return Container(
      width: MediaQuery.of(context).size.height / 5,
      height: MediaQuery.of(context).size.height / 5,
      child: CircularProgressIndicator(),
    );
  }

  Future goBack(bool backButton) async {
      return await this.performFuture(() {
        // ignore: missing_return
        return safe().then((_) {
          if (backButton) {
            return true;
          }
          else {
            Navigator.pop(context);
          }
        // ignore: missing_return
        }).catchError((error) {
          showErrorToast(context,
              "Speichern fehlgeschlagen. Bitte überprüfe deine Internet Verbindung oder kontaktiere einen Admin.");
          if (backButton) return false;
        });
      });
  }

  Future delete() async {
    if (widget.analyseId != null) {
      //if its a new analysis, just pop and do nothing
      await this.performFuture(() {
        return Provider.of<Analysen>(context, listen: false)
            .delete(widget.analyseId)
            .then((value) {
          Navigator.pop(context,analyse);
        }).catchError((error) {
          showErrorToast(context,
              "Löschen fehlgeschlagen. Bitte überprüfe deine Internet Verbindung oder kontaktiere einen Admin.");
        });
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget screen(BuildContext context) {

    Widget titleField = Container(
      width: 400, //TODO maybe make responsive title textfield
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.edit,
            color: Colors.white,
            size: 30,
          ),
        ),
        //maxLength: 30,
        focusNode: titleFocus,
        style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            //decoration: TextDecoration.underline,
        ),
        cursorColor: Colors.white,
        onChanged: (val) {
            analyse.title = val;
        },
        initialValue: analyse.title,
      ),
    );

    var appBar = GradientAppBar(
      leading: Showcase(
        key: saveKey,
        description:
            'Klicke hier um die Analyse zu speichern. Der "Zurück" Pfeil deines Browsers speichert die Analyse ebenfalls',
        child: Container(
          padding: EdgeInsets.all(10),
          child: InkWell(
            child: Icon(Icons.save, size: 36),
            onTap: (){
              goBack(false);
              },
          ),
        ),
      ),
      gradient: LinearGradient(colors: [ Theme.of(context).accentColor,Theme.of(context).primaryColor,],stops: [0.65,1]),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Showcase(
            description: "Klicke hier um die Analyse zulöschen",
            key: trashKey,
            child: InkWell(
              child:
                  Icon(Icons.delete, size: 36),
              onTap: delete,
            ),
          ),
          Flexible(
            child: Container(),
          ),
          Flexible(
            flex: 2,
            child: titleField,
          ),
          Flexible(
            child: Container(),
          ),
        ],
      ),
      centerTitle: true,
    );

    Widget errorScreen = Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Diese Analyse existiert nicht. "),
            RaisedButton(
                child: Text("Zurück"),
                onPressed: () {
                  Application.router
                      .navigateTo(context, HomeScreen.routeName);
                })
          ],
        ),
      ),
    );

    return analyse != null
        ? ChangeNotifierProvider.value(
            value: analyse,
            child: WillPopScope(
              onWillPop: () async{return await goBack(true);},
              child: ShowCaseWidget(
                builder: Builder(
                  builder: (ctx) => Scaffold(
                    appBar: appBar,
                    body: Container(
                      padding: EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 10),
                      child: LayoutBuilder(
                        builder: (ctx, constr) => Row(
                          children: <Widget>[
                            Container(
                              width: constr.maxWidth * 0.4,
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: AnalyseInputArea(
                                  descriptionKey,
                                  learningKey,
                                  tagsKey,
                                  descriptionInputKey,
                                  learningInputKey),
                            ),
                            Container(
                              width: constr.maxWidth * 0.6,
                              child: AnalysePictureArea(
                                  apicKey, analysePictureKey, linkKey, pairKey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : errorScreen;
  }
}
