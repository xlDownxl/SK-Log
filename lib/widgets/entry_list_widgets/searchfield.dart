import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/analysen.dart';

class Searchfield extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child:  TextFormField(
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
    );
  }
}
