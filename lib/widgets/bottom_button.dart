import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final bool on;
  final Function change;
  final String text;
  BottomButton(this.on,this.change,this.text);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {change();}
      ,color: on? Theme.of(context).accentColor:Colors.grey,
      child: FittedBox(child: Text(text,style: TextStyle(color: Colors.white),)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
