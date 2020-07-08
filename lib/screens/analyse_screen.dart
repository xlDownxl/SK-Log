import 'dart:html';

import 'package:flutter/material.dart';
import '../widgets/analyse_input_area.dart';
import '../widgets/analyse_picture_area.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analyse.dart';
import '../widgets/zefyr_textfield.dart';
import '../models/user_pairs.dart';
import '../models/ascending.dart';
import '../models/user.dart';
import '../showcaseview/showcaseview.dart';
import '../widgets/widget_helper.dart';
import '../models/screen_loader.dart';

class AnalyseScreen extends StatefulWidget {
  static const routeName = "/analyse";

  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> with ScreenLoader<AnalyseScreen>{
  FocusNode titleFocus = FocusNode();
  String id;
  Analyse analyse;



  bool trashcanLoading = false;
  bool saveLoading = false;
  bool editText = false;

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

  bool init = true;
  @override
  void initState() {
    if (Provider.of<AppUser>(context, listen: false).isNew) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(apicKey.currentContext).startShowCase([
                pairKey, linkKey, analysePictureKey, tagsKey, descriptionInputKey, trashKey, saveKey,
              ]));
    }
    super.initState();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      id = ModalRoute.of(context).settings.arguments;
      if (id != null) {
        analyse = Provider.of<Analysen>(context).getAnalyse(id);
      } else {
        analyse = Analyse();
      }
      init = false;
    }
    super.didChangeDependencies();
  }

  Future safe() {
    if (analyse.pair == null) {
      analyse.pair = "Others";
    }
    descriptionKey.currentState.safeDocument();
    learningKey.currentState.safeDocument();
    if (id == null) {
      return Provider.of<Analysen>(context, listen: false)
          .add(analyse, Provider.of<Ascending>(context, listen: false).asc);
    } else {
      return Provider.of<Analysen>(context, listen: false).update(analyse);
    }
  }

  @override
  Widget loader() {
    return Container(
      width: MediaQuery.of(context).size.height/5,
      height: MediaQuery.of(context).size.height/5,
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget screen(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: analyse,
      child: WillPopScope(
        onWillPop: () async{
          if (!trashcanLoading && !saveLoading) {
            //if user clicked trashcan first do nothing
            setState(() {
              saveLoading = true;
            });
            return await this.performFuture(() {
              return safe().then((_) {
                return true;
              }).catchError((error) {
                setState(() {
                  saveLoading = false;
                });
                showErrorToast(context,
                    "Löschen fehlgeschlagen. Bitte überprüfe deine Internet Verbindung oder kontaktiere einen Admin.");
                return false;
              });
            });
          } else {
            return Future.value(false);
          }
        },
        child: ShowCaseWidget(
          builder: Builder(
            builder: (ctx) => Scaffold(
              appBar: GradientAppBar(
                leading: Showcase(
                  key: saveKey,
                  description:
                      'Klicke hier um die Analyse zu speichern. Der "Zurück" Pfeil deines Browsers speichert die Analyse ebenfalls',
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: InkWell(
                      //TODO inkwell design/verhalten
                      child: //!saveLoading ?
                      Icon(Icons.save, size: 36)
                          /*: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )*/,
                      onTap: () async{
                        if (!trashcanLoading&& !saveLoading) {
                          //if user clicked trashcan first do nothing
                          setState(() {
                            saveLoading = true;
                          });
                    await this.performFuture(() {
                            return safe().then((_) {
                              Navigator.pop(context);
                            }).catchError((error) {
                              setState(() {
                                saveLoading = false;
                              });
                              showErrorToast(context,
                                  "Speichern fehlgeschlagen. Bitte überprüfe deine Internet Verbindung oder kontaktiere einen Admin.");
                            });
                          });
                        }
                      },
                    ),
                  ),
                ),
                gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Showcase(
                      description: "Klicke hier um die Analyse zulöschen",
                      key: trashKey,
                      child: InkWell(
                        child: //!trashcanLoading ?
                        Icon(Icons.delete, size: 36)
                         /*   : CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )*/,
                        onTap: () async{

                            if (!saveLoading && !trashcanLoading) {
                              if (id != null) {
                              //if user clicked trashcan first do nothing
                              setState(() {
                                trashcanLoading = true;
                              });
                              await this.performFuture((){
                                return Provider.of<Analysen>(context, listen: false)
                                  .delete(id)
                                  .then((value) {
                                Navigator.pop(context);
                              }).catchError((error) {
                                setState(() {
                                  trashcanLoading = false;
                                });
                                showErrorToast(context,
                                    "Löschen fehlgeschlagen. Bitte überprüfe deine Internet Verbindung oder kontaktiere einen Admin.");
                              });
                              });
                            } else {
                                Navigator.pop(context);
                              }
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: Container(),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: 400,
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white54,
                              size: 30,
                            ),
                          ),
                          focusNode: titleFocus,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                          //initialValue: analyse.title,
                          cursorColor: Colors.white,
                          onChanged: (val) {
                            //nur on submit ändern
                            setState(() {
                              analyse.title = val;

                              editText = false;
                            });
                          },
                          initialValue: analyse.title,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Container(
                padding:
                    EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
                child: LayoutBuilder(
                  builder: (ctx, constr) => Row(
                    children: <Widget>[
                      Container(
                        width: constr.maxWidth * 0.4,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: AnalyseInputArea(descriptionKey, learningKey,
                            tagsKey, descriptionInputKey, learningInputKey),
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
    );
  }
}
