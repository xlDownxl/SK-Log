import 'package:flutter/material.dart';
import '../showcaseview/showcase_widget.dart';
import 'list_element.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';
import '../models/analysen_filter.dart';
import '../showcaseview/showcaseview.dart';
import '../models/helper_providers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/tags_filter_widget.dart';
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
  Analysen analysen;
  TextEditingController editingController = TextEditingController();

  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          Provider.of<Animations>(context, listen:false).animEntry=false;
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var asc = Provider.of<Ascending>(context);
    analysen = Provider.of<Analysen>(context);
    var anim = Provider.of<Animations>(context, listen:false).animEntry;

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

    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 15, top: 10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.buildSearchField
              ? buildSearchfield()
              : SizedBox(
            height: 20,
          ),
          Provider.of<FilterMode>(context).showTagsFilter?TagsFilterWidget():Container(),
          buildHeadline(),
          Expanded(
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

    );
  }
}