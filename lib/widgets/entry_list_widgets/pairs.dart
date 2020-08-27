import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import '../../models/analysen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/helper_providers.dart';
import 'package:flutter_shine/flutter_shine.dart';

class Pairs extends StatelessWidget {
  Pairs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List buildPairs() {
      var pairs =
          Provider.of<Analysen>(context, listen: false).userPairs.getPairs();
      var pairWidgets = [];

      pairs.forEach((pair, value) {
        pairWidgets.add(GridElement(pair, value));
      });
      return pairWidgets;
    }

    return GestureDetector(
      onTap: () {
        Provider.of<FilterMode>(context, listen: false).deactivatePairFilter();
      },
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 130,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 10,
        ),
        children: <Widget>[
          ...buildPairs(),
        ],
      ),
    );
  }
}

class GridElement extends StatefulWidget {
  final pair;
  final value;

  GridElement(this.pair, this.value);

  @override
  _GridElementState createState() => _GridElementState();
}

class _GridElementState extends State<GridElement> {
  var counter = 0;
  bool colors = false;
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: counter,
      columnCount: 6,
      duration: const Duration(milliseconds: 375),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: FlutterShine(
            config: Config(
              shadowColor: Theme.of(context).primaryColor,
            ),
            light: Light(
              intensity: 0.5,
            ),
            builder: (ctx, ShineShadow shineShadow) =>
                 AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                margin: !_hovering?EdgeInsets.all(8):null,

                child: Card(
                  elevation: 2,
                  color: !colors ? Colors.orange : Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            widget.pair,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _hovering?35:30,
                              //color: Colors.white,
                              shadows: shineShadow?.shadows,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Provider.of<AnalyseFilter>(context, listen: false)
                          .addPairFilter(widget.pair);
                      Provider.of<Analysen>(context, listen: false).setFilter(
                          Provider.of<AnalyseFilter>(context, listen: false));
                      Provider.of<FilterMode>(context, listen: false)
                          .deactivatePairFilter();
                    },
                    onHover: (val) {
                      setState(() {
                        colors = val;
                        _hovering = val;
                      });
                    },
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
