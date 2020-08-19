import 'package:flutter/material.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'package:provider/provider.dart';
import '../../models/helper_providers.dart';

class Headline extends StatelessWidget {
  TextStyle headlineStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black,fontFamily: "Tisa",);

  @override
  Widget build(BuildContext context) {

    buildText(text){
      return Center(
          child: FittedBox(
            child: FlutterShine(
              config: Config(
                shadowColor: Colors.grey,
                blur: 25,
              ),
              light: Light(
                intensity: 0.3,
              ),
              builder: (ctx,shineShadows)=>
                  Text(text,
                    style: headlineStyle.copyWith(shadows: shineShadows?.shadows),
                  ),
            ),
          ));
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black45, width: 2))),
      //padding: EdgeInsets.only(bottom: 3),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: buildText("Analyse Titel"),
            fit: FlexFit.tight,
          ),
          Flexible(
            flex: 2,
            child: buildText("Paar"),
            fit: FlexFit.tight,
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: FlutterShine(
                      config: Config(
                        shadowColor: Colors.grey,
                        blur: 25,
                      ),
                      light: Light(
                        intensity: 0.3,
                      ),
                      builder: (ctx,shineShadows)=> FittedBox(
                        child: Text(
                          "Datum",
                          style: headlineStyle.copyWith(shadows: shineShadows?.shadows),
                        ),
                      ),
                    ),
                  ),
                 // SizedBox(width: 10,),
                  Flexible(
                    child: Provider.of<Ascending>(context, listen: false).asc
                        ? IconButton(
                            icon: Icon(Icons.arrow_downward,),
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
            flex: 5,
            child: buildText("Tags"),
            fit: FlexFit.tight,
          ),
        ],
      ),
    );
  }
}
