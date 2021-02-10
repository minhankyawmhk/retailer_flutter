import 'package:flutter/material.dart';

class InventoryCheckSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Text('inventory check search'),
    );
  }
}
