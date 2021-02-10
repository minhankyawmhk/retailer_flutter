import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/models/shopByListModel.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;

class MainScreenSearch extends SearchDelegate {
  List<ShopByListM> shopList;
  List<ShopByListM> otherList;
  ViewModelFunction model;

  @override
  ThemeData appBarTheme(BuildContext context) {
    model = Provider.of<ViewModelFunction>(
      context,
    );
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

  MainScreenSearch(
    this.title,
  ) : super(
            searchFieldLabel: title,
            searchFieldStyle: TextStyle(
                decorationColor: Colors.white,
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 1));

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
    return getResultWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return getSugWidget();
  }

  Widget getSugWidget() {
    Widget sugWidget;

    if (model.shopsByUser != null || model.shopsByTeam != null) {
      sugWidget = ListView(
        children: [
          getShopList(model.shopsByUser),
          getOtherList(model.shopsByTeam),
        ],
      );
    } else {
      sugWidget = Center(
        child: Text(
          "No shop found !",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      );
    }
    return sugWidget;
  }

  Widget getResultWidget() {
    Widget resultWidget;

    shopList = model.shopsByUser
        .where((p) => p.shopname.toLowerCase().contains(query.toLowerCase()))
        .toList();
    otherList = model.shopsByTeam
        .where((element) =>
            element.shopname.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (shopList.length > 0 || otherList.length > 0) {
      resultWidget = ListView(
        children: [
          getShopList(shopList),
          getOtherList(otherList),
        ],
      );
    } else {
      resultWidget = Center(
        child: Text(
          "No shop found !",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
      );
    }
    return resultWidget;
  }
}
