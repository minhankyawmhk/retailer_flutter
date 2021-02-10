import 'package:flutter/material.dart';
import '../../custom/custom_expansion_title.dart' as custom;

class CartItemDiscountScreen extends StatefulWidget {
  @override
  _CartItemDiscountScreenState createState() => _CartItemDiscountScreenState();
}

class _CartItemDiscountScreenState extends State<CartItemDiscountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invoice Discount',
          style: TextStyle(fontSize: 15),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context,true);
            }),
      ),
      body: Column(
        children: [
          promotionAllitemWidget('SP Bakery'),
          promotionPricDiscounteWidget('Price Discount 1'),
          promotionGetDiscountWidget('Get Discount 1'),
        ],
      ),
    );
  }

  Widget promotionAllitemWidget(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 5, right: 5),
      child: custom.ExpansionTitle(
        headerBackgroundColor: Colors.red[100],
        iconColor: Colors.black,
        title: Container(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          promotionItem(),
        ],
      ),
    );
  }

  Widget promotionItem() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Center(
          child: Text(
        "No Promotion",
        style: TextStyle(fontWeight: FontWeight.w500),
      )),
    );
  }

  Widget promotionPricDiscounteWidget(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 4, left: 5, right: 5),
      child: custom.ExpansionTitle(
        headerBackgroundColor: Colors.red[100],
        iconColor: Colors.black,
        title: Container(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          promotionPrice(),
        ],
      ),
    );
  }

  Widget promotionPrice() {
    return Card(
      child: SizedBox(
        // width: 470,
        child: Column(
          children: [
            Container(
              child: Column(children: <Widget>[
                Container(
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(185.0),
                    border: TableBorder.all(color: Colors.black12),
                    children: [
                      TableRow(children: [
                        Container(
                          width: 57,
                          height: 57,
                          color: Colors.red[100],
                          child: Column(children: [
                            SizedBox(
                              child: Container(
                                padding: EdgeInsets.only(top: 14.0, right: 18),
                                child: Container(
                                  width: 38,
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Buy",
                                          style: TextStyle(
                                            backgroundColor: Colors.red[100],
                                            color: Colors.black,
                                            fontSize: 13,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          width: 57,
                          height: 57,
                          color: Colors.red[100],
                          child: SizedBox(
                            height: 57,
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.only(top: 14.0, right: 18),
                                child: Container(
                                  width: 38,
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Get",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Container(
                          color: Colors.grey[100],
                          child: SizedBox(
                            height: 57,
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 22, top: 20),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '10000',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        // children: textSpans,
                                      ),
                                      TextSpan(
                                          text: ' Ks between ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: '     12000 ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: ' Ks ',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                        Container(
                          color: Colors.grey[100],
                          child: SizedBox(
                            height: 57,
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 122, top: 19),
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '5',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '% off',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 57,
                          child: Column(children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 20),
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '20000',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13,
                                          )),
                                      TextSpan(
                                          text: ' Ks between',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          )),
                                      TextSpan(
                                          text: '   0                   ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 13,
                                          )),
                                      TextSpan(
                                          text: 'Ks',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                          )),
                                    ],
                                  ),
                                ))
                          ]),
                        ),
                        Column(children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 116, top: 15),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '10',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '% off',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black)),
                                  ],
                                ),
                              ))
                        ]),
                      ]),
                      TableRow(children: [
                        Container(
                          color: Colors.grey[100],
                          child: SizedBox(
                            height: 57,
                            child: Column(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25, top: 20),
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '30000',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 13,
                                            )),
                                        TextSpan(
                                            text: ' Ks between',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '   0 ',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '        Ks',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                        Container(
                          color: Colors.grey[100],
                          child: SizedBox(
                            height: 57,
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 116, top: 19),
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '15',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: '% off',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black)),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget promotionGetDiscountWidget(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 4, left: 5, right: 5),
    child: custom.ExpansionTitle(
      headerBackgroundColor: Colors.red[100],
      iconColor: Colors.black,
      title: Container(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ),
      children: <Widget>[
        SizedBox(
          height: 4,
        ),
        promotionDiscount(),
      ],
    ),
  );
}

Widget promotionDiscount() {
  return Card(
    child: Column(
      children: [
        Container(
          child: Column(children: <Widget>[
            Container(
              child: Table(
                defaultColumnWidth: FixedColumnWidth(185.0),
                border: TableBorder.all(color: Colors.black12),
                children: [
                  TableRow(children: [
                    Container(
                      width: 57,
                      height: 57,
                      color: Colors.red[100],
                      child: Column(children: [
                        SizedBox(
                          child: Container(
                            padding: EdgeInsets.only(top: 14.0, right: 18),
                            child: Container(
                              width: 38,
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Buy",
                                      style: TextStyle(
                                        backgroundColor: Colors.red[100],
                                        color: Colors.black,
                                        fontSize: 13,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      width: 57,
                      height: 57,
                      color: Colors.red[100],
                      child: SizedBox(
                        height: 57,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.only(top: 14.0, right: 18),
                            child: Container(
                              width: 38,
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Get",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      color: Colors.grey[100],
                      child: SizedBox(
                        height: 57,
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 22, top: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '10000 ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 13,
                                        )),
                                    TextSpan(
                                        text: ' Ks between     ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        )),
                                    TextSpan(
                                        text: ' 20000 ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 13,
                                        )),
                                    TextSpan(
                                        text: 'Ks',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                              ))
                        ]),
                      ),
                    ),
                    Column(children: [
                      Container(
                        height: 57,
                        color: Colors.grey[100],
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 3),
                            child: Text(
                              "SP_Assorted Cake",
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 3,
                              left: 22,
                            ),
                            child: SizedBox(
                              width: 21,
                              height: 16,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ]),
                  ]),
                  TableRow(children: [
                    SizedBox(
                      height: 57,
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.only(left: 22, top: 20),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '30000',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 13,
                                      )),
                                  TextSpan(
                                      text: ' Ks between    ',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: ' 40000 ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 13,
                                      )),
                                  TextSpan(
                                      text: 'Ks',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      )),
                                ],
                              ),
                            ))
                      ]),
                    ),
                    Column(children: [
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 13,
                          ),
                          child: Text("bag"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 103,
                          ),
                          child: SizedBox(
                            width: 21,
                            height: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              child: Center(
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ]),
                  ]),
                ],
              ),
            ),
          ]),
        ),
      ],
    ),
  );
}
