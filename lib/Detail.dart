import 'package:flutter/material.dart';

class HomePageDetail extends StatefulWidget {
  @override
  _HomePageDetailState createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Detail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.asset(
                  'assets/icon/sp_bread3.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: getWidgetImage(),
      ),
    );
  }

  Widget getWidgetImage() {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Row(
              children: [
                Row(
                  children: [
                    Title(
                      color: Colors.black,
                      child: Text(
                        "SP_Blueberry Cream Roll",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 57,
                  child: Row(children: [
                    Container(
                      padding: EdgeInsets.only(left: 145),
                      child: Container(
                        width: 42,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          border: Border.all(
                            color: Colors.lightGreen,
                          ),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Pro",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 113,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icon/price-tag.png',
                        color: Colors.grey[600],
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Baked goods",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 7),
                child: Container(
                  width: 68,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icon/price-tag.png',
                        color: Colors.grey[600],
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Bread",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              getListWidget(),
              getTable(),
            ],
          ),
        ],
      ),
    );
  }

  Widget getListWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 23),
                child: Text(
                  'Detail',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 9),
                child: Text(
                  'Pack size',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 145),
                child: GestureDetector(
                  child: Text(
                    'Small',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 9),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 148),
                child: GestureDetector(
                  child: Text(
                    'C1',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 12),
                child: Text(
                  'Subcategory',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 128),
                child: GestureDetector(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 275.0, top: 30),
          child: Text(
            'Promotion',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget getTable() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Card(
          elevation: 0,
          child: SizedBox(
            width: 351,
            child: Column(
              children: [
                Container(
                  padding: new EdgeInsets.only(left: 8.0),
                  color: Colors.red[50],
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 12),
                        child: Text(
                          "Price Discount Test 1",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 5,
                        ),
                        child: Text(
                          '(Test)',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Expired On : 31/12/2020",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(166.0),
                        border: TableBorder.all(color: Colors.black12),
                        children: [
                          TableRow(children: [
                            Column(children: [
                              SizedBox(
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 14.0, right: 18),
                                  child: Container(
                                    width: 38,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      border: Border.all(
                                        color: Colors.lightGreen,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Buy",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 57,
                              child: Column(children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(top: 14.0, right: 18),
                                  child: Container(
                                    width: 38,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      border: Border.all(
                                        color: Colors.lightGreen,
                                      ),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Get",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 57,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 36, top: 20),
                                    child: Text(
                                      '10000 Ks under',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                            Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 57,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 90, top: 19),
                                    child: Text(
                                      '3 % off',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
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
                                      const EdgeInsets.only(right: 70, top: 20),
                                  child: Text(
                                    '10000 Ks',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 90, top: 15),
                                child: Text(
                                  '5 % off',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 57,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 38, top: 20),
                                    child: Text(
                                      '10000 Ks over',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                            Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 57,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 90, top: 19),
                                    child: Text(
                                      '7 % off',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            SizedBox(
                              height: 60,
                              child: Column(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 23, top: 15),
                                  child: Text(
                                    '20000 Ks between 30000 Ks',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              ]),
                            ),
                            Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 83, top: 15),
                                child: Text(
                                  '10 % off',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            ]),
                          ]),
                          TableRow(children: [
                            Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 57,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 15),
                                    child: Center(
                                      child: Text(
                                        '40000 Ks or over',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                            Container(
                              color: Colors.grey[200],
                              child: SizedBox(
                                height: 57,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 76, top: 15),
                                    child: Text(
                                      '15 % off',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  )
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
          )),
    );
  }
}
