import 'package:flutter/material.dart';
import 'package:retailer/custom/custom_expansion_title.dart';
import '../../style/theme.dart' as Style;

class InventorystockSearch extends SearchDelegate {
  List<String> litems = [
    "bake",
    "unbake",
    "overbake",
  ];
  final List list1 = ["Baked goods", "Lotte", "Soft drinks and others", "DD"];
  List<String> titlelist = [
    'Sp_Daily_Butter Bread',
    'SP_Milk Cream Roll ',
    'SP_Daily Cheese Spread',
    'SP_Bean Bread',
    'Example Bread',
    'Super Cream Bread',
    'Small Cream Bread',
    'No Cream Bread',
    'Stawbarry Cream',
    'Simple bread',
  ];
  List<String> list = ['Bread', 'Pastries', 'Cake'];
  var items = [];
  var value1 = "All";
  var value2 = 'Bread';
  var value3 = 'bake';
  var colorcheck;
  bool check;
  TextEditingController qtyController = TextEditingController();
  TextEditingController expQtyController = TextEditingController();

  @override
  ThemeData appBarTheme(BuildContext context) {
    if (qtyController.text.isEmpty) {
      qtyController.text = '0';
    }
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
  final List<String> mainList;

  InventorystockSearch(this.title, this.mainList)
      : super(
            searchFieldLabel: title,
            searchFieldStyle: TextStyle(
                decorationColor: Colors.white,
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 1));
  List<String> suggestion;
  List<String> result;

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
    Widget widget;

    result = mainList
        .where((p) => p.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print('this is result $result');
    if (result.isEmpty) {
      widget = Center(
        child: Column(
          children: [
            dropDown(context),
            Text('no result found'),
          ],
        ),
      );
    } else if (result.isNotEmpty) {
      var stockList = Container(
          child: Column(
        children: [
          dropDown(context),
          Expanded(child: getMainExpansion()),
        ],
      ));
      widget = stockList;
    }
    return widget;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Widget widget;
    if (query.isEmpty) {
      widget = Container(
          child: Column(
        children: [
          dropDown(context),
          Expanded(child: getMainExpansion()),
        ],
      ));
    } else {
      suggestion = mainList
          .where((p) => p.toLowerCase().contains(query.toLowerCase()))
          .toList();
      widget = Container(
          child: Column(
        children: [
          dropDown(context),
          Expanded(child: getMainExpansion()),
        ],
      ));
    }
    return widget;
  }

  Widget dropDown(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: width * .36,
          child: TextButton(
              onPressed: () {
                getlistView(context, list1);
              },
              child: Row(
                children: [
                  Text(
                    value1,
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down)
                ],
              )),
        ),
        Container(
          width: width * .32,
          child: TextButton(
              onPressed: () {
                getlistView(context, list);
              },
              child: Row(
                children: [
                  Text(
                    value2,
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down)
                ],
              )),
        ),
        Container(
          width: width * .32,
          child: TextButton(
              onPressed: () {
                getlistView(context, litems);
              },
              child: Row(
                children: [
                  Text(
                    value3,
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down),
                ],
              )),
        ),
      ],
    );
  }

  Widget getlistView(BuildContext context, getlist) {
    var alertDialog = AlertDialog(
      title: Text("Select Category"),
      content: Row(
        children: [
          thelist(getlist),
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: alertDialog,
                  ),
                ],
              ),
            ],
          );
        });
    return alertDialog;
  }

  Widget thelist(getlist) {
    return Container(
      height: 210.0,
      width: 250.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: getlist.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: ListTile(
              title: Text(getlist[index]),
              trailing: colorcheck == getlist[index]
                  ? Icon(
                      Icons.radio_button_on,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.radio_button_off,
                      color: Colors.grey,
                    ),
              onTap: () {
                if (getlist == list1) {
                  value1 = list1[index];
                } else if (getlist == list) {
                  value2 = list[index];
                } else if (getlist == litems) {
                  value3 = litems[index];
                }

                if (getlist == list1) {
                  colorcheck = value1;
                } else if (getlist == list) {
                  colorcheck = value2;
                } else if (getlist == litems) {
                  colorcheck = value3;
                }

                check = false;
                Navigator.pop(context, true);
              },
            ),
          );
        },
      ),
    );
  }

  Widget getMainExpansion() {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 5, right: 5),
      child: ListView.builder(
        itemBuilder: (context, index) => ExpansionTitle(
          backgroundColor: Colors.deepOrange[50],
          initiallyExpanded: false,
          headerBackgroundColor: Colors.red[100],
          iconColor: Colors.black,
          title: Text(list1[index], style: TextStyle(color: Colors.black)),
          children: [
            getSubTile(),
          ],
        ),
        itemCount: list1.length,
      ),
    );
  }

  Widget getSubTile() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ExpansionTile(
          title: Text(list[index], style: TextStyle(color: Colors.black)),
          children: [
            this.getStockList(context),
          ],
        ),
        itemCount: list.length,
      ),
    );
  }

  Widget getStockList(BuildContext context) {
    var secWidth = MediaQuery.of(context).size.width * 0.7;
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Container(
          padding: const EdgeInsets.only(left: 4),
          color: Colors.white,
          height: 110,
          child: Row(
            children: [
              Container(
                width: width * 0.23,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset(
                      'assets/icon/sp_bread3.jpg',
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Container(
                height: 110,
                width: width * 0.73,
                child: Card(
                  child: Column(
                    children: [
                      Spacer(),
                      Spacer(),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 7),
                              child: Container(
                                  width: secWidth * 0.8,
                                  child: Text(
                                    titlelist[index],
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    ),
                                  )),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 10),
                              child: InkWell(
                                onTap: () {
                                  print('Check was tap');
                                },
                                child: ImageIcon(
                                  AssetImage('assets/icon/empty_check_box.png'),
                                  size: 23,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: secWidth * 0.45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    height: 40,
                                    width: secWidth * 0.08,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: secWidth * 0.35,
                                  child: Card(
                                    color: Colors.grey[200],
                                    elevation: 2,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print('minus one was tap');
                                          },
                                          child: Container(
                                            height: 40,
                                            width: secWidth * 0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8,
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 4),
                                              child: ImageIcon(
                                                AssetImage(
                                                    'assets/icon/minus.png'),
                                                color: Style.Colors.mainColor,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Container(
                                            width: secWidth * 0.1,
                                            child: TextField(
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                              controller: qtyController,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 14),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print('object');
                                          },
                                          child: Container(
                                            height: 40,
                                            width: secWidth * 0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 10, bottom: 10),
                                              child: ImageIcon(
                                                AssetImage(
                                                    'assets/icon/add.png'),
                                                color: Style.Colors.mainColor,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: secWidth * 0.55,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Container(
                                    height: 40,
                                    width: secWidth * 0.16,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "Exp qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: secWidth * 0.35,
                                  child: Card(
                                    color: Colors.grey[200],
                                    elevation: 2,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print('minus two was tap');
                                          },
                                          child: Container(
                                            height: 40,
                                            width: secWidth * 0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8,
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 4),
                                              child: ImageIcon(
                                                AssetImage(
                                                    'assets/icon/minus.png'),
                                                color: Style.Colors.mainColor,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Container(
                                            width: secWidth * 0.1,
                                            child: TextField(
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                              controller: qtyController,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(bottom: 14),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print('plus two was tap ');
                                          },
                                          child: Container(
                                            height: 40,
                                            width: secWidth * 0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 10, bottom: 10),
                                              child: ImageIcon(
                                                AssetImage(
                                                    'assets/icon/add.png'),
                                                color: Style.Colors.mainColor,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: titlelist.length,
    );
  }
}
