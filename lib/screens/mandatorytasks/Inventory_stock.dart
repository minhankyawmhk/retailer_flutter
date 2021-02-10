import 'package:flutter/material.dart';
import 'package:retailer/screens/mandatorytasks/inventory_stock_search.dart';
import '../../style/theme.dart' as Style;
import 'package:retailer/custom/custom_expansion_title.dart';

class InventoryStockAddPage extends StatefulWidget {
  @override
  _InventoryStockAddPageState createState() => _InventoryStockAddPageState();
}

class _InventoryStockAddPageState extends State<InventoryStockAddPage> {
  final List data = ["Baked goods", "Lotte", "Soft drinks and others", "DD"];
  List<String> mainList = [
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

  TextEditingController qtyController = TextEditingController();
  TextEditingController expQtyController = TextEditingController();

  var secWidth;
  var width;

  @override
  Widget build(BuildContext context) {
    if (qtyController.text.isEmpty) {
      qtyController.text = '0';
    }
    secWidth = MediaQuery.of(context).size.width * 0.68;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Stocks"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: InventorystockSearch(
                      'search',
                      mainList,
                    ));
              })
        ],
      ),
      body: getMainExpansion(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
        child: Container(
          height: 45,
          child: FlatButton(
            color: Colors.red,
            onPressed: () {
              print('Add was tap');
            },
            child: Center(
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getMainExpansion() {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 5, right: 5),
      child: ListView.builder(
        itemBuilder: (context, index) => ExpansionTitle(
          backgroundColor: Colors.deepOrange[50],
          initiallyExpanded: true,
          headerBackgroundColor: Colors.red[100],
          iconColor: Colors.black,
          title: Text(
            data[index],
            style: TextStyle(color: Colors.black),
          ),
          children: [
            getSubTile(),
          ],
        ),
        itemCount: data.length,
      ),
    );
  }

  Widget getSubTile() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ExpansionTile(
          title: Text(
            list[index],
            style: TextStyle(color: Colors.black),
          ),
          children: [
            getStockList(),
          ],
        ),
        itemCount: list.length,
      ),
    );
  }

  Widget getStockList() {
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
                                    mainList[index],
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
      itemCount: mainList.length,
    );
  }
}
