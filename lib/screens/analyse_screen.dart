import 'package:flutter/material.dart';
import '../widgets/analyse_input_area.dart';
import '../widgets/analyse_picture_area.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analyse.dart';
import '../widgets/zefyr_textfield.dart';
import '../screens/home_screen.dart';


class AnalyseScreen extends StatefulWidget {

  static const routeName = "/analyse";
  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
  var titleFocus=FocusNode();
  String id;
  Analyse analyse;
  final GlobalKey<ZefyrTextFieldState> descriptionKey =  GlobalKey<ZefyrTextFieldState>();
  final GlobalKey<ZefyrTextFieldState> learningKey =  GlobalKey<ZefyrTextFieldState>();

  bool editText=false;

  @override
  void dispose() {
    titleFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }


  bool init=true;

  @override
  void didChangeDependencies() {
    if(init) {
      id = ModalRoute
          .of(context)
          .settings
          .arguments;
      if (id != null) {
        analyse = Provider.of<Analysen>(context).getAnalyse(id);
      }
      else {
        analyse = Analyse();
      }
      init=false;
    }
    super.didChangeDependencies();
  }

  void safe(){
    descriptionKey.currentState.safeDocument();
    learningKey.currentState.safeDocument();
    Provider.of<Analysen>(context,listen: false).add(analyse);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider.value(
      value: analyse,
      child: Scaffold(
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: [Colors.cyan,Colors.indigo]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: InkWell(child: Icon(Icons.edit,color: Colors.white54,size: 36,),
                onTap: (){ FocusScope.of(context).requestFocus(titleFocus);}),
              ),
              Flexible(
                child: Container(
                  width: 500,
                  child: TextFormField(
                    focusNode: titleFocus,
                    style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),
                    //initialValue: analyse.title,
                    cursorColor: Colors.white,
                    onChanged: (val){ //nur on submit ändern
                      setState(() {
                        analyse.title=val;
                        print(analyse.title);
                        editText=false;
                      });
                    },
                    initialValue: analyse.title,
                  ),
                ),
              ),

            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (ctx, constr) => Row(
              children: <Widget>[
                Container(
                  width: constr.maxWidth * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: AnalyseInputArea(descriptionKey,learningKey),
                ),
                Container(
                  width: constr.maxWidth * 0.5,
                  child: AnalysePictureArea(safe),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
