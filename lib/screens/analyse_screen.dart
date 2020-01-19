import 'package:flutter/material.dart';
import '../widgets/analyse_input_area.dart';
import '../widgets/analyse_picture_area.dart';

class AnalyseScreen extends StatefulWidget {
  static const routeName = "/analyse";
  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {

  bool editText=false;
  var title="Analyse Nr. 5";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){
            editText=true;
          },
          child: !editText?Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Analyse Nr. 5",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(width: 5,),
                Icon(Icons.edit,size: 35,),
              ],
            ),
          ):TextFormField(
            initialValue: title,
            onFieldSubmitted: (val){
              setState(() {
                title=val;
                editText=false;
              });
            },
          ),
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
