import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/entry_list_widgets/searchfield.dart';
import 'entry_list_widgets/list_element.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/helper_providers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'entry_list_widgets/pairs.dart';
import '../models/analysen_filter.dart';
import 'entry_list_widgets/headline.dart';
import 'entry_list_widgets/filter_control.dart';
import '../routing/application.dart';
import 'dart:math';
import 'package:fluro/fluro.dart';
import 'package:flutter_shine/flutter_shine.dart';
import 'draggable_scrollbar.dart';

class EntryList extends StatefulWidget {
  final bool buildSearchField;
  final Key analysenKey;
  final Key searchFieldKey;
  EntryList(key, this.buildSearchField, this.analysenKey,
      this.searchFieldKey,)
      : super(key: key);

  @override
  EntryListState createState() => EntryListState();
}

class EntryListState extends State<EntryList> {
  final IconData icon = Icons.add;
  FilterMode filterMode;
  AnalyseFilter analyseFilter;
  Ascending asc;
  Analysen analysen;
  bool anim;
  ScrollController scrollController=ScrollController();

  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          Provider.of<Animations>(context, listen:false).animEntry=false;
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    asc = Provider.of<Ascending>(context);
    analysen = Provider.of<Analysen>(context);
    filterMode=Provider.of<FilterMode>(context);
    analyseFilter = Provider.of<AnalyseFilter>(context);
    anim = Provider.of<Animations>(context, listen:false).animEntry;

    Widget plusButton=LayoutBuilder(builder: (ctx, constraints) {
      var size = max(constraints.maxWidth, constraints.maxHeight);
      return SizedBox(
        width: constraints.maxHeight*0.15,
        height: constraints.maxHeight*0.15,
        child: FlutterShine(
          config: Config(shadowColor: Colors.black,),
      light: Light(intensity: 0.5,),
      builder:(ctx,ShineShadow shineShadow)=> Material(
          color: Colors.orange,
          elevation: 4,
          shape: CircleBorder(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: InkWell(
              customBorder: CircleBorder(),
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                Application.router.navigateTo(context, "/analyse",
                    transition: TransitionType.fadeIn);
              },
              splashColor: Colors.orange[900],
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: LayoutBuilder(
                    builder: (ctx, constr) => Text(
                        String.fromCharCode(icon.codePoint),
                        style: TextStyle(
                            fontSize: constr.maxHeight ,
                            shadows: shineShadow?.shadows,
                            fontFamily: icon.fontFamily,
                            package: icon.fontPackage,
                            color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
      ),
        ),
      );
    });

    Widget getItem(index){
      return ListElement(asc.asc
        ? analysen.analysen.keys.toList()[index]
        : analysen.analysen.keys.toList().reversed.toList()[index]);
    }

    return Stack(
      children:[
        Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 15, top: 10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
                child: FilterControl(),
            ),
            Headline(),
            Flexible(
              flex: 12,
              child: Container(
                child:  AnimationLimiter(
                  child: DraggableScrollbar.rrect(
                    backgroundColor: Colors.grey,
                    controller: scrollController,
                    alwaysVisibleScrollThumb: true,
                    child: ListView.builder(
                      padding: EdgeInsets.only(right: 20),
                      controller: scrollController,
                      itemBuilder: (ctx, index) {
                        return anim ?
                         AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: FlipAnimation(
                            duration: const Duration(milliseconds: 500),
                            child: FadeInAnimation(
                              child: getItem(index),
                            ),
                          ),
                        ): getItem(index);
                        },
                      itemCount: analysen.analysen.length,
                    ),
                  ),
                ),
              ),),
          ],
        ),
      ),
    Align(
    alignment: Alignment.bottomRight,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10,right: 10,),
        child: plusButton,
    ),
    ),
        Provider.of<FilterMode>(context).showPairFilter?Container(
          color: Colors.black.withOpacity(0.7),
          padding: EdgeInsets.all(50),
          child: Pairs(),
        ):Container(),
      ],
    );
  }
}