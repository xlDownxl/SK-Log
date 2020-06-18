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

class AnalyseScreen extends StatefulWidget {
  static const routeName = "/analyse";
  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
  var titleFocus = FocusNode();
  String id;
  Analyse analyse;
  final GlobalKey<ZefyrTextFieldState> descriptionKey =
      GlobalKey<ZefyrTextFieldState>();
  final GlobalKey<ZefyrTextFieldState> learningKey =
      GlobalKey<ZefyrTextFieldState>();

  bool editText = false;

  @override
  void dispose() {
    titleFocus.dispose();
    super.dispose();
  }

  bool init = true;

  @override
  void didChangeDependencies() {
    //TODO als future.delayed in init state implementieren für performance
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

  void safe() {
    if(analyse.pair==null){
      analyse.pair="Others";
    }
      descriptionKey.currentState.safeDocument();
      learningKey.currentState.safeDocument();
      if (id == null) {
        Provider.of<Analysen>(context, listen: false).add(analyse,Provider.of<Ascending>(context,listen: false).asc);
      }
      else{
        Provider.of<Analysen>(context, listen: false).update(analyse);
      }
      Navigator.pop(context);
  }

  bool error = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: analyse,
      child: WillPopScope(
        onWillPop: () {
          return Future.delayed(Duration()).then((_) {
            safe();
            return true;
          });
        },
        child: Scaffold(
          appBar: GradientAppBar(
            leading: InkWell(
              //TODO inkwell design/verhalten
              child: Icon(Icons.save, size: 36),
              onTap: safe,
            ),
            gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /*InkWell(
                  //TODO inkwell design/verhalten
                  child: Icon(Icons.save),
                  onTap: safe,
                ),*/
                InkWell(
                  child: Icon(Icons.delete, size: 36),
                  onTap: () {
                    if (id != null)
                      Provider.of<Analysen>(context, listen: false).delete(id);
                    Navigator.pop(context);
                  },
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
            padding: EdgeInsets.only(top: 20,right: 20,left: 20,bottom: 0),
            child: LayoutBuilder(
              builder: (ctx, constr) => Row(
                children: <Widget>[
                  Container(
                    width: constr.maxWidth * 0.4,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: AnalyseInputArea(descriptionKey, learningKey),
                  ),
                  Container(
                    width: constr.maxWidth * 0.6,
                    child: AnalysePictureArea(error),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
