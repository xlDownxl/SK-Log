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

  FilterMode filterMode;
  AnalyseFilter analyseFilter;
  Ascending asc;
  Analysen analysen;
  bool anim;

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




    Widget getItem(index){
      return ListElement(asc.asc
        ? analysen.analysen.keys.toList()[index]
        : analysen.analysen.keys.toList().reversed.toList()[index]);
    }
//TODO flexible column alignments
    return Stack(
      children:[
        Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 15, top: 10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           /* widget.buildSearchField
                ? Searchfield()
                : SizedBox(
              height: 20,
            ),*/
            //!filterMode.showTagsFilter && !analyseFilter.isPair ? Container() :
            Flexible(
              flex: 2,
                child: FilterControl(),
            ),
            Headline(),
            Flexible(
              flex: 12,
              child: Container(
                child:  ListView.builder(
                  itemBuilder: (ctx, index) {
                    return anim ?
                     AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: FlipAnimation(
                        duration: Duration(microseconds: 50),
                        child: FadeInAnimation(
                          child: getItem(index),
                        ),
                      ),
                    ): getItem(index);
                    },
                  itemCount: analysen.analysen.length,
                ),
              ),),
          ],
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