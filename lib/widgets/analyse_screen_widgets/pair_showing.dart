import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analyse.dart';
import '../../models/analysen.dart';
import '../../showcaseview/showcaseview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shine/flutter_shine.dart';

class PairShowing extends StatefulWidget {

  PairShowing(key,): super(key: key);
  @override
  PairShowingState createState() => PairShowingState();
}

class PairShowingState extends State<PairShowing> {
  bool editPair = false;
  Analyse analyse;
  FocusNode editPairFocus = FocusNode();
  bool loading = false;


  void editLoading(bool load){
    setState(() {
      loading=load;
    });
  }

  @override
  Widget build(BuildContext context) {
    analyse = Provider.of<Analyse>(context,listen: false);
    return LayoutBuilder(
        builder: (ctx, constraints) => Container(
              height: constraints.maxWidth,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor,
                ),
                child: editPair
                    ? Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            focusNode: editPairFocus,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                            onSubmitted: (value) {
                              setState(() {
                                editPair = false;
                                analyse.pair = value;
                              });
                            },
                          ),
                        ),
                      )
                    : !loading
                        ? FlutterShine(
                            config: Config(
                              shadowColor: Colors.black,
                            ),
                            light: Light(
                              intensity: 0.3,
                            ),
                            builder: (ctx, ShineShadow shineShadow) => InkWell(
                              customBorder: CircleBorder(),
                              onTap: () {
                                setState(() {
                                  editPair = true;
                                });
                                editPairFocus.requestFocus();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Center(
                                  child: analyse.pair == null
                                      ? Text("")
                                      : FittedBox(
                                          child: Text(
                                            analyse.pair,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.white,
                                              shadows: shineShadow?.shadows,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          )
                        : CircularProgressIndicator(),
              ),
            ));
  }
}


class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}