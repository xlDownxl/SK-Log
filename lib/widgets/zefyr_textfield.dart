import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

class ZefyrTextField extends StatefulWidget {
  final String text;
  ZefyrTextField(this.text);

  @override
  _ZefyrTextFieldState createState() => _ZefyrTextFieldState();
}

class _ZefyrTextFieldState extends State<ZefyrTextField> {

  ZefyrController _controller;
  FocusNode _focusNode;
  
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying "Zefyr Quick Start".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("${widget.text}\n");
    return NotusDocument.fromDelta(delta);
  }
  
  @override
  void initState() {
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(10)),

      child: ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
