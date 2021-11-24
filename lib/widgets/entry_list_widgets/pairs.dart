import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import '../../models/analysen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/helper_providers.dart';
import 'pair_button.dart';
class Pairs extends StatelessWidget {
  final GlobalKey<PairButtonState> pairButtonKey;
  Pairs(this.pairButtonKey);

  @override
  Widget build(BuildContext context) {
    List buildPairs() {
      var pairs =
          Provider.of<Analysen>(context, listen: false).userPairs.getPairs();
      var pairWidgets = [];

      pairs.forEach((pair, value) {
        pairWidgets.add(GridElement(pair, value, pairButtonKey));
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
        padding:  EdgeInsets.all(40),
        children: <Widget>[
          ...buildPairs() as Iterable<Widget>,
        ],
      ),
    );
  }
}

class GridElement extends StatefulWidget {
  final pair;
  final value;
  final GlobalKey<PairButtonState> pairButtonKey;

  GridElement(this.pair, this.value,this.pairButtonKey);

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
          child:
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
                              //shadows: shineShadow?.shadows,
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
                      widget.pairButtonKey.currentState!.controller.forward();
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
    );
  }
}
