import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen.dart';

class Searchfield extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
          builder: (_, constraint) => Container(
            margin: EdgeInsets.only(bottom: 5),
            width: constraint.maxWidth * 0.25,
            child: TextFormField(
              onChanged: (value) {
                Provider.of<Analysen>(context,listen: false).addSearch(value);
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
    );
  }
}
