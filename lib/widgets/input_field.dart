import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InputField extends StatefulWidget {

  final String text;
  final String label;
  final int maxLines;
  InputField(this.text,this.label,this.maxLines);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(ctx,con)=> Container(
        //padding: EdgeInsets.all(10),
        //constraints: BoxConstraints.expand(),
        //width: con.maxWidth*0.8,
        //decoration: BoxDecoration(borderRadius:BorderRadius.circular(5),border: Border.all(width: 2,color: Colors.black)),
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              //isDense: true,
              labelText: widget.label,
            labelStyle: TextStyle(fontSize: 20)

          ),
          initialValue: widget.text,
          style: TextStyle(fontSize: 14.0, color: Colors.black,),
        maxLines: widget.maxLines,

        //),
        ),
      ),
    );
  }
}
/* AutoSizeText(
          widget.text,
          style: TextStyle(fontSize: 20),
          maxLines: 2,
        ),*/