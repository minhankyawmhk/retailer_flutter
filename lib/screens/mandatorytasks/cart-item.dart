import 'package:flutter/material.dart';
import 'package:retailer/custom/custom_expansion_title.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/screens/mandatorytasks/carrt_item_discount.dart';
import '../../style/theme.dart' as Style;

// import '../../custom/custom_expansion_title.dart' as custom;

class CartItemScreen extends StatefulWidget {
  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  TextEditingController qtyController = TextEditingController();
  var val='1';
  var width;

  @override
  Widget build(BuildContext context) {
    if (qtyController.text.isEmpty) {
      qtyController.text = '';
    }
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    width: width - 100,
                    child: Center(
                      child: Text(
                        "May Zon (မေဇွန်)",
                        style: Style.headingPrimaryTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                     child:IconButton(
                            icon: ImageIcon(
                              AssetImage('assets/icon/percentage.png'),
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => CartItemDiscountScreen()));
                            },
                          ),
                  ),
                ],
              ),
              Container(
                width: width - 46,
                padding: EdgeInsets.only(left: 10, right: 8),
                child: Text(
                  "လမ်း80.34.35ကြား, ကဉ္စနမဟီရပ်ကွက်, ချမ်းအေးသာဇံ, ချမ်းအေးသာစံ, မန္တလေးခရိုင်, မန္တလေးတိုင်းဒေသကြီး\r\n",
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
                        color: Colors.red,
                        height: 45,
                        child: Center(
                          child: Text(
                            'Order Products',
                            style: TextStyle(
                              fontSize: 15.0,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    getExpansion(),
                    getBal(),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Container(
                        color: Colors.red,
                        height: 45,
                        child: Center(
                          child: Text(
                            'Return Products',
                            style: TextStyle(
                              fontSize: 15.0,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
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
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 2, left: 4, right: 4),
        height: 40,
        child: Row(
          children: [
            Container(
                width: width * 0.32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Style.Colors.mainColor),
                child: FlatButton(
                    onPressed: () {},
                    child: Center(  
                      child: Text(
                        'Complete Visit',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ))),
            Spacer(),
            Container(
                width: width * 0.32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Style.Colors.mainColor),
                child: FlatButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Print',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ))),
            Spacer(),
            Container(
                width: width * 0.32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Style.Colors.mainColor),
                child: FlatButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Order Update',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    )))
          ],
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
          backgroundColor: Colors.red[50],
          initiallyExpanded: false,
          headerBackgroundColor: Colors.red[100],
          iconColor: Colors.black,
          title: Text(
            'SP Bakery',
            style:TextStyle(
              fontSize: 15.0,
              height: 1.2,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
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
    
    List _items = [
      'SP Bakery',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery ',
      'SP Bakery '
    ];

    var secWidth = MediaQuery.of(context).size.width * 0.7 - 10;
    var width = MediaQuery.of(context).size.width - 10;

    return ListView.builder(
      
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        height: 110,
        child: Row(
          children: [
            getPhotoContainer(width,null),
            Container(width: 5,),
            Expanded(
              child: Container(
                height: 100,
                width: width * 0.72 - 1.5,
                child: Container(
                  decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(6),
                    ),
                  child: Column(
                    children: [
                      Spacer(),
                      Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 8),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Container(
                                  width: secWidth * 0.7,
                                  child: Text(
                                    _items[index],
                                    maxLines: 3,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    ),
                                  )),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: ImageIcon(
                              AssetImage('assets/icon/delete.png'),
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print('Shop  was tap');
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: secWidth * 0.45,
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: secWidth * 0.35,
                                  child: Card(
                                    elevation: 1,
                                    color: Colors.grey[200],
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
                                        InkWell(
                                          onTap: () {
                                            _showDialog();
                                          },
                                          child: Container(
                                            height: 40,
                                            width: secWidth * 0.1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 10, bottom: 10),
                                              child: Text(val),
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
                                    // height: 40,
                                    width: secWidth * 0.35,
                                    child: Text(
                                      "100",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: secWidth * 0.16,
                                  child: Text(
                                    "100",
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
            )
          ],
        ),
        decoration: BoxDecoration(),
      ),
      itemCount: _items.length,
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "SP_Blueberry Cream Roll",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          content: TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter the number'),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                    onPressed: () {
                      setState(() {
                        val = qtyController.text;
                        Navigator.pop(context, true);
                      });
                    },
                    child: new Text("OK"))
              ],
            ),
          ],
        );
      },
    );
  }
}
