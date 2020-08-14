import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import '../../models/analysen.dart';
import '../../models/helper_providers.dart';
import 'dart:math';
import 'package:flutter_shine/flutter_shine.dart';

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

    var dollarLogo = Container(
      child: LayoutBuilder(builder: (ctx, constraints) {
        var size = min(constraints.maxHeight, constraints.maxWidth) / 3 + 2;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    FontAwesomeIcons.dollarSign,
                    size: size,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.apple,
                    size: size,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    FontAwesomeIcons.euroSign,
                    size: size,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.bitcoin,
                    size: size,
                  ),
                ),
              ],
            )
          ],
        );
      }),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: LayoutBuilder(builder: (ctx, constraints) {
            var size = max(constraints.maxWidth, constraints.maxHeight);
            return Material(
              color: Colors.orange,
              elevation: 2,
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
                  splashColor: Colors.red[900],
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: dollarLogo,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Flexible(
          child: filter.isPair
              ? LayoutBuilder(builder: (ctx, constraints) {
                  var size = max(constraints.maxWidth, constraints.maxHeight);
                  return FlutterShine(
                    config: Config(
                      shadowColor: Colors.black,
                    ),
                    light: Light(
                      intensity: 0.7,
                    ),
                    builder: (ctx, ShineShadow shineShadow) => Material(
                      color: Colors.redAccent,
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
                            hover = false;
                          },
                          splashColor: Colors.red[900],
                          onHover: (hovered) {
                            setState(() {
                              hover = hovered;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                                child: hover
                                    ? FittedBox(
                                        //TODO hierzwischen animation
                                        child: Icon(
                                        Icons.close,
                                        size: size / 2,
                                      ))
                                    : FittedBox(
                                        child: Text(
                                        filter.pair.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size / 12 + 8,
                                          fontWeight: FontWeight.bold,
                                          shadows: shineShadow?.shadows,
                                        ),
                                      ))),
                          ),
                        ),
                      ),
                    ),
                  );
                })
              : Container(),
        ),
      ],
    );
  }
}
