import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/custom/custom_expansion_title.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;
import 'package:http/http.dart' as http;

// import '../../custom/custom_expansion_title.dart' as custom;

class OrderEditScreen extends StatefulWidget {
  @override
  _OrderEditScreenState createState() => _OrderEditScreenState();
}

class _OrderEditScreenState extends State<OrderEditScreen> {
  TextEditingController qtyController = TextEditingController();
  var width;
  ViewModelFunction modelFunction;

  @override
  Widget build(BuildContext context) {
    modelFunction = Provider.of<ViewModelFunction>(context);
    if (qtyController.text.isEmpty) {
      qtyController.text = '2';
    }
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  width: width - 86,
                  child: Center(
                    child: Text(
                      modelFunction.activeShop.shopname,
                      style: Style.headingPrimaryTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: width - 46,
              padding: EdgeInsets.only(left: 10, right: 8),
              child: Text(
                "${modelFunction.activeShop.address}\r\n",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Center(child: Text("15/09/2020"))),
            Divider(
              color: Colors.black,
              height: 1,
            ),
            Flexible(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Container(
                      color: Colors.red[100],
                      height: 45,
                      child: Center(
                        child: Text(
                          'Order Products',
                          style: Style.headingTextStyle,
                        ),
                      ),
                    ),
                  ),
                  getExpansion(),
                  getBal(),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Container(
                      color: Colors.red[100],
                      height: 45,
                      child: Center(
                        child: Text(
                          'Return Products',
                          style: Style.headingTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        getExpansion(),
                        getBal(),
                        getRemark(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Style.Colors.mainColor,
          ),
          height: 45,
          child: FlatButton(
            onPressed: () {
              print('order upadated');
            },
            child: Center(
              child: Text(
                'Order Update',
                style: Style.whiteTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getRemark() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: TextField(
          maxLines: 4,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "Remark :",
              labelStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: Colors.black),
              fillColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8)),
        ),
      ),
    );
  }

  Widget getExpansion() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 6, left: 6),
      child: Card(
        color: Colors.transparent,
        elevation: 3,
        child: ExpansionTitle(
          backgroundColor: Colors.white,
          initiallyExpanded: false,
          headerBackgroundColor: Style.Colors.mainColor,
          iconColor: Style.Colors.textColor,
          title: Text(
            'SP Bakery',
            style: TextStyle(color: Style.Colors.textColor),
          ),
          onExpansionChanged: (value) {
            // print(value);
          },
          children: [
            SizedBox(
              height: 4,
            ),
            getChildren(),
          ],
        ),
      ),
    );
  }

  Widget getBal() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      child: Text('Subtotal'),
                    ),
                    Container(
                      height: 30,
                      child: Text('Discount Amount (10%)'),
                    ),
                    Container(
                      height: 30,
                      child: Text('Total Amount (90%)'),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        ':',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Spacer(),
              Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      child: Text('200'),
                    ),
                    Container(
                      height: 30,
                      child: Text('20'),
                    ),
                    Container(
                      height: 30,
                      child: Text('180'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getChildren() {
    var secWidth = MediaQuery.of(context).size.width * 0.68;

    List _items = [
      'SP Bakery',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery '
    ];
    List<Widget> getByCharacter = [];
    return new FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
        getByCharacter.clear();
        _items.forEach((element) {
          getByCharacter.add(
            Row(
              children: [
                Container(
                  height: 100,
                  width: width * 0.25,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset(
                        'assets/icon/sp_bread1.jpg',
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: width * 0.68,
                  child: Card(
                    child: Column(
                      children: [
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
                                    width: secWidth * 0.7,
                                    child: Text(
                                      "Bread flour can be substituted with all-purpose flour, but you have to keep in mind that bread flour, since it has a higher gluten content, requires more liquid. When using all-purpose flour you can either add more flour (usually 1 tbsp per 1 cup flour) or add less water.",
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
                              width: secWidth * 0.5,
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
                                        width: secWidth * 0.15,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8,
                                              top: 8,
                                              bottom: 8,
                                              left: 4),
                                          child: ImageIcon(
                                            AssetImage('assets/icon/minus.png'),
                                            color: Style.Colors.mainColor,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Container(
                                        width: secWidth * 0.15,
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
                                        width: secWidth * 0.15,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 10, bottom: 10),
                                          child: ImageIcon(
                                            AssetImage('assets/icon/add.png'),
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
                            Spacer(),
                            Text(
                              '100',
                              style: Style.headingTextStyle,
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                '200',
                                style: Style.headingTextStyle,
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
          );
        });

        return new Column(children: getByCharacter);
      },
    );
  }
}
