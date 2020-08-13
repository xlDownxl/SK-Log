import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import '../../models/analysen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/helper_providers.dart';
class Pairs extends StatelessWidget {
  Pairs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List buildPairs() {
      var pairs = Provider.of<Analysen>(context, listen: false)
          .userPairs
          .getPairs(); //listen = false?
      var pairWidgets = [];
      var counter = 0;
      pairs.forEach((pair, value) {
        pairWidgets.add(
          AnimationConfiguration.staggeredGrid(
            position: counter,
            columnCount: 6,
            duration: const Duration(milliseconds: 375),
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Card(
                  elevation: 2,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30),
                    ),
                  ),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            pair,
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Provider.of<AnalyseFilter>(context,listen:false).addPairFilter(pair);
                      Provider.of<Analysen>(context,listen:false).setFilter(Provider.of<AnalyseFilter>(context,listen:false));
                      Provider.of<FilterMode>(context,listen: false).deactivatePairFilter();
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      });
      return pairWidgets;
    }

    return GestureDetector(
      onTap: (){
        Provider.of<FilterMode>(context,listen: false).deactivatePairFilter();
      },
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //crossAxisCount: 8,
          maxCrossAxisExtent: 130,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: <Widget>[
          ...buildPairs(),
        ],
      ),
    );
  }
}
