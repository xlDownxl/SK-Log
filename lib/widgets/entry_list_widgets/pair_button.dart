import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import '../../models/analysen.dart';
import '../../models/helper_providers.dart';
import 'dart:math';

class PairButton extends StatefulWidget {
  @override
  _PairButtonState createState() => _PairButtonState();
}

class _PairButtonState extends State<PairButton> {
  bool hover = false;
  AnalyseFilter filter;

  @override
  Widget build(BuildContext context) {
    filter = Provider.of<AnalyseFilter>(context);

    /*  return InkWell(
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
  }*/

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: LayoutBuilder(builder: (ctx, constraints) {
            var size = max(constraints.maxWidth, constraints.maxHeight);
            return Material(
              color: Colors.green,
              shape: CircleBorder(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: InkWell(
                  customBorder: CircleBorder(),
                  borderRadius: BorderRadius.circular(25.0),
                  onTap: () {
                    Provider.of<FilterMode>(context, listen: false)
                        .activatePairFilter();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                        child:FittedBox(
                            child: Text(
                              "Pairs",
                              style: TextStyle(fontSize: size / 12 + 8),
                            ))),
                  ),
                ),
              ),
            );
          }),
        ),
        Flexible(
          child: filter.isPair?LayoutBuilder(builder: (ctx, constraints) {
            var size = max(constraints.maxWidth, constraints.maxHeight);
            return Material(
              color: Colors.green,
              shape: CircleBorder(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: InkWell(
                  customBorder: CircleBorder(),
                  borderRadius: BorderRadius.circular(25.0),
                  onTap: () {
                    filter.addPairFilter("");
                    Provider.of<Analysen>(context, listen: false)
                        .setFilter(filter);
                  },
                  onHover: (hovered) {
                    setState(() {
                      hover = hovered;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                        child: hover
                            ? FittedBox(    //TODO hierzwischen animation
                                child: Icon(
                                Icons.close,
                                size: size / 2,
                              ))
                            : FittedBox(
                                child: Text(
                                filter.pair,
                                style: TextStyle(fontSize: size / 12 + 8),
                              ))),
                  ),
                ),
              ),
            );
          }):Container(),
        ),
      ],
    );
  }
}
