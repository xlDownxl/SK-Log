import 'package:flutter/material.dart';
//import 'package:zefyr/zefyr.dart';
//import 'package:quill_delta/quill_delta.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../models/analyse.dart';

class ZefyrTextField extends StatefulWidget {
  final field;

  ZefyrTextField({this.field, Key key}) : super(key: key);

  @override
  ZefyrTextFieldState createState() => ZefyrTextFieldState();
}

class ZefyrTextFieldState extends State<ZefyrTextField> {
  //NotusDocument document;
  //ZefyrController _controller;
  FocusNode _focusNode;
  Analyse analyse;

  void safeDocument() {
    if (widget.field == "description") {
      //analyse.description = json.encode(document.toJson());
    } else {
      //analyse.learning = json.encode(document.toJson());
    }
  }

  /*NotusDocument _loadDocument(Analyse analyse) {
    if (widget.field == "description") {
      if (analyse.description == null) {
        final Delta delta = Delta()..insert("Beschreibung\n");
        return NotusDocument.fromDelta(delta);
      } else {
        return NotusDocument.fromJson(json.decode(analyse.description));
      }
    } else {
      if (analyse.learning == null) {
        final Delta delta = Delta()..insert("Learning\n");
        return NotusDocument.fromDelta(delta);
      } else {
        return NotusDocument.fromJson(json.decode(analyse.learning));
      }
    }
  }

  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      analyse = Provider.of<Analyse>(context);
      document = _loadDocument(analyse);
      _controller = ZefyrController(document);
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),

      child: Container()
      /*ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
          
        ),
      ),*/
    );
  }
}
