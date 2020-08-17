import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/analyse_screen_widgets/analyse_image.dart';
import 'package:provider/provider.dart';
import '../../models/analyse.dart';
import '../../showcaseview/showcaseview.dart';
import 'pair_showing.dart';
import 'link_area.dart';

class AnalysePictureArea extends StatefulWidget {
  AnalysePictureArea(key): super(key: key);

  @override
  AnalysePictureAreaState createState() => AnalysePictureAreaState();
}

class AnalysePictureAreaState extends State<AnalysePictureArea> {
  Analyse analyse;

  var pairShowing = GlobalKey<PairShowingState>();
  var linkArea = GlobalKey<LinkAreaState>();
  var pictureIndex = 0;

  @override
  Widget build(BuildContext context) {
    analyse = Provider.of<Analyse>(context);

    return Column(
      children: <Widget>[
        Flexible(
          child: AnalyseImage(),
        flex: 26,
        ),
        SizedBox(
          height: 20,
        ),
        Flexible(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 42,
                  child: LinkArea(linkArea,pairShowing),
                ),
                Flexible(
                  child: Container(),
                ),
                Flexible(
                    flex: 11,
                    fit: FlexFit.tight,
                    child: Container(
                      child: PairShowing(pairShowing),
                      padding: EdgeInsets.all(10),
                    )),
                Flexible(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
