import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/helper_providers.dart';

class Headline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black45, width: 2))),
      //padding: EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Center(
                child: FittedBox(
              child: Text(
                "Analyse Titel",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )),
            fit: FlexFit.tight,
          ),
          Flexible(
            flex: 1,
            child: Center(
                child: FittedBox(
              child: Text("Paar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            )),
            fit: FlexFit.tight,
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: FittedBox(
                      child: Text("Datum",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                  Flexible(
                    child: Provider.of<Ascending>(context, listen: false).asc
                        ? IconButton(
                            icon: Icon(Icons.arrow_downward),
                            onPressed: () {
                              Provider.of<Ascending>(context, listen: false)
                                  .setAsc(false);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.arrow_upward),
                            onPressed: () {
                              Provider.of<Ascending>(context, listen: false)
                                  .setAsc(true);
                            },
                          ),
                  ),
                ],
              ),
            ),
            fit: FlexFit.tight,
          ),
          Flexible(
            flex: 3,
            child: Center(
                child: FittedBox(
              child: Text("Tags",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            )),
            fit: FlexFit.tight,
          ),
        ],
      ),
    );
  }
}
