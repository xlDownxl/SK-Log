import 'package:flutter/material.dart';
import '../widgets/analyse_input_area.dart';
import '../widgets/analyse_picture_area.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
class AnalyseScreen extends StatefulWidget {
  static const routeName = "/analyse";
  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
  var titleFocus=FocusNode();

  bool editText=false;
  var title="Analyse Nr. 5";

  @override
  void dispose() {
    titleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  initialValue: title,
                  cursorColor: Colors.white,
                  onFieldSubmitted: (val){
                    setState(() {
                      title=val;
                      editText=false;
                    });
                  },
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
                child: AnalyseInputArea(),
              ),
              Container(
                width: constr.maxWidth * 0.5,
                child: AnalysePictureArea(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
