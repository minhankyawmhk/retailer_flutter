import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/components/checkin-shop.dart';
import 'package:retailer/screens/mandatorytasks/Inventory_stock.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;

class InventoryCheckScreen extends StatefulWidget {
  @override
  _InventoryCheckScreenState createState() => _InventoryCheckScreenState();
}

class _InventoryCheckScreenState extends State<InventoryCheckScreen> {
  var width;
  TextEditingController qtyController = TextEditingController();
  TextEditingController expQtyController = TextEditingController();
  ViewModelFunction model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);

    width = MediaQuery.of(context).size.width;
    if (qtyController.text == '') {
      qtyController.text = '1';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Check"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // showSearch(context: context, delegate: InventoryCheckSearch());
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4, left: 4, top: 10),
            child: CheckinShop(),
          ),
          Expanded(child: getStockList())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InventoryStockAddPage()));
        },
        backgroundColor: Style.Colors.mainColor,
        child: Icon(Icons.add),
        foregroundColor: Style.Colors.textColor,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
        child: Container(
          height: 45,
          child: FlatButton(
            color: Style.Colors.mainColor,
            onPressed: () {
              print('Save was tap');
            },
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getStockList() {
    var secWidth = MediaQuery.of(context).size.width * 0.7;
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Container(
          height: 110,
          child: Row(
            children: [
              getPhotoContainer(width,model.allStock[index].img),
              Spacer(),
              Container(
                height: 100,
                width: width * 0.74,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
                                  left: 4, right: 4, top: 4),
                              child: Container(
                                  width: secWidth * 0.8,
                                  child: Text(
                                    model.allStock[index].desc,
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 16,
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
                                  print('delete was tap');
                                },
                                child: ImageIcon(
                                  AssetImage('assets/icon/delete.png'),
                                  size: 23,
                                  color: Style.Colors.mainColor,
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
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Qty",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: secWidth * 0.35,
                                  child: Card(
                                    color: Colors.grey[50],
                                    elevation: 0,
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
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Exp qty",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: secWidth * 0.35,
                                  child: Card(
                                    color: Colors.grey[50],
                                    elevation: 0,
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
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      itemCount: model.allStock.length,
    );
  }
}
