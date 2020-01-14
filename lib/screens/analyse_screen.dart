import 'package:flutter/material.dart';

class AnalyseScreen extends StatefulWidget {

  static const routeName = "/analyse";

  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Container(child: Center(child: Text("Analyse"),),),);
  }
}
