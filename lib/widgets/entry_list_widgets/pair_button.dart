import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import '../../models/analysen.dart';

class PairButton extends StatefulWidget {

  @override
  _PairButtonState createState() => _PairButtonState();
}

class _PairButtonState extends State<PairButton> {
  bool hover=false;
  AnalyseFilter filter;


  @override
  Widget build(BuildContext context) {
    filter = Provider.of<AnalyseFilter>(context);

    return InkWell(
      onTap: (){
       filter.addPairFilter("");
        Provider.of<Analysen>(context, listen: false)
            .setFilter(filter);
      },
      onHover: (isHover){
        setState(() {
          hover=isHover;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: !hover ? Text(filter.pair) : Icon(Icons.delete),
      ),);
  }
}
