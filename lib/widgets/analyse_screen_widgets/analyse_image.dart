import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analyse.dart';
import '../../showcaseview/showcaseview.dart';
import 'pair_showing.dart';
import 'link_area.dart';

class AnalyseImage extends StatefulWidget {
  @override
  _AnalyseImageState createState() => _AnalyseImageState();
}

class _AnalyseImageState extends State<AnalyseImage> {
  var pictureIndex = 0;
  Analyse analyse;

  @override
  Widget build(BuildContext context) {
    analyse = Provider.of<Analyse>(context);
    return Column(children: [
      Flexible(
        child: LayoutBuilder(
          builder: (ctx, constraints) => (analyse.links[0] != "") &&
                  (pictureIndex == 0)
              ? Image.network(
                  analyse.links[0],
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                )
              : (analyse.links[1] != "") && (pictureIndex == 1)
                  ? Image.network(
                      analyse.links[1],
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    )
                  : (analyse.links[2] != "") && (pictureIndex == 2)
                      ? Image.network(
                          analyse.links[2],
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              "Copy und Paste deinen Tradingview Link in den unteren Kasten",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
        ),
        fit: FlexFit.tight,
        flex: 26,
      ),
      Row(
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: pictureIndex,
            onChanged: (val) {
              setState(() {
                pictureIndex = val;
              });
            },
          ),
          Radio(
              value: 1,
              groupValue: pictureIndex,
              onChanged: analyse.links[1] != ""
                  ? (val) {
                      setState(() {
                        pictureIndex = val;
                      });
                    }
                  : null),
          Radio(
              value: 2,
              groupValue: pictureIndex,
              onChanged: analyse.links[2] != ""
                  ? (val) {
                      setState(() {
                        pictureIndex = val;
                      });
                    }
                  : null),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ]);
  }
}
