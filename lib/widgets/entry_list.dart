import 'package:flutter/material.dart';
import 'list_element.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../showcaseview/showcaseview.dart';
import '../models/helper_providers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'entry_list_widgets/tags_filter_widget.dart';
import 'entry_list_widgets/pairs.dart';
import '../models/analysen_filter.dart';
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
  TextEditingController editingController = TextEditingController();
  bool hover=false;

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

    Widget buildHeadline() {
      return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black45,width: 2))),
        //padding: EdgeInsets.only(bottom: 3),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Center(
                  child: FittedBox(
                    child: Text(
                      "Analyse Title",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Center(
                  child: FittedBox(
                    child: Text("Paar",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  )),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: FittedBox(
                        child: Text("Datum",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ),
                    Flexible(
                      child: asc.asc
                          ? IconButton(
                        icon: Icon(Icons.arrow_downward),
                        onPressed: () {
                          setState(() {
                            Provider.of<Ascending>(context, listen: false)
                                .asc = false;
                          });
                        },
                      )
                          : IconButton(
                        icon: Icon(Icons.arrow_upward),
                        onPressed: () {
                          setState(() {
                            Provider.of<Ascending>(context, listen: false)
                                .asc = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 3,
              child: Center(
                  child: FittedBox(
                    child: Text("Tags",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  )),
              fit: FlexFit.tight,
            ),
          ],
        ),
      );
    }


    Widget buildSearchfield() {
      return Align(
        alignment: Alignment.centerRight,
        child: Showcase(
          key: widget.searchFieldKey,
          description: "Suche hier nach Namen von Analysen",
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          child: LayoutBuilder(
            builder: (_, constraint) => Container(
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(width: 1,color: Colors.tealAccent)),
              margin: EdgeInsets.only(bottom: 5),
              width: constraint.maxWidth * 0.25,
              child: TextFormField(
                onChanged: (value) {
                  analysen.addSearch(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Suche eine Analyse",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget getItem(index){
      return ListElement(asc.asc
        ? analysen.analysen.keys.toList()[index]
        : analysen.analysen.keys.toList().reversed.toList()[index]);
    }

    Widget pairWidget = InkWell(
      onTap: (){
        analyseFilter.addPairFilter("");
        Provider.of<Analysen>(context, listen: false)
            .setFilter(analyseFilter);
        },
      onHover: (isHover){
        setState(() {
          hover=isHover;
        });

      },
      child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: !hover ? Text(analyseFilter.pair) : Icon(Icons.delete),
    ),);

    return Stack(
      children:[
        Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 15, top: 10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.buildSearchField
                ? buildSearchfield()
                : SizedBox(
              height: 20,
            ),
            !filterMode.showTagsFilter && !analyseFilter.isPair ? Container() :
            Flexible(
              flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder:(ctx,constraints)=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: constraints.maxWidth*0.3,
                            child: Provider.of<AnalyseFilter>(context).isPair ? pairWidget : Container(), //todo maybe listen:false for optimizing , how does the x btton for no more pair filter work??
                        ),
                        Container(
                          width: constraints.maxWidth*0.7,
                            child: Provider.of<FilterMode>(context).showTagsFilter ? TagsFilterWidget() : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
            buildHeadline(),
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