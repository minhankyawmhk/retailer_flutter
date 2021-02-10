import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../style/theme.dart' as Style;

class DataSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 15),
      ),
      primaryColor: Style.Colors.mainColor,
      primaryIconTheme: IconThemeData(color: Colors.white),
    );
  }

  final title;

  DataSearch(this.title)
      : super(
            searchFieldLabel: title,
            searchFieldStyle: TextStyle(
                decorationColor: Colors.white,
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 1));
  List<dynamic> suggestion;
  List<dynamic> result;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? Container()
          : IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                query = '';
              },
            ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text('No Data'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Suggestion'),
      ),
    );
  }
}
