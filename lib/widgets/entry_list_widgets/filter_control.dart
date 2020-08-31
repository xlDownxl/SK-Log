import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen_filter.dart';
import 'pair_button.dart';
import 'tags_filter_widget.dart';
import '../../models/helper_providers.dart';
import 'searchfield.dart';

class FilterControl extends StatelessWidget {
  final pairButtonKey;
  FilterControl(this.pairButtonKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder:(ctx,constraints)=> Row(
          children: [
            Container(
              width: constraints.maxWidth*0.2,
              child: //Provider.of<AnalyseFilter>(context).isPair ?
               PairButton(pairButtonKey) //: Container(), //todo maybe listen:false for optimizing , how does the x btton for no more pair filter work??
            ),
            Container(
              width: constraints.maxWidth*0.6,
              child: //Provider.of<FilterMode>(context).showTagsFilter ?
               TagsFilterWidget() //: Container(),
            ),
            Container(
              width: constraints.maxWidth*0.2,
              child: Searchfield(),
            ),
          ],
        ),
      ),
    );
  }
}
