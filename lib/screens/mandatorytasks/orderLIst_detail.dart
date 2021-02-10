import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailer/custom/custom_expansion_title.dart' as custom;
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;

class OrderListDetailScreen extends StatefulWidget {
  @override
  _OrderListDetailScreenState createState() => _OrderListDetailScreenState();
}

class _OrderListDetailScreenState extends State<OrderListDetailScreen> {
  TextEditingController qtyController = TextEditingController();
   TextEditingController textEditingController = TextEditingController();
  var width;
  String currentTime = DateFormat("dd/MM/yyyy").format(DateTime.now());
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
        padding: EdgeInsets.only(top: 20),
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
                      "${modelFunction.activeShop.shopname}",
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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                    height: 54,
                    color: Style.Colors.mainColor,
                    child: Center(
                      child: Text(
                        'Order Products',
                        style: Style.whiteTextStyle,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      children: [
                        getExpansion(),
                        getBal(),
                      ],
                    ),
                    itemCount: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4, left: 8, right: 8),
                    height: 54,
                    color: Style.Colors.mainColor,
                    child: Center(
                      child: Text(
                        'Return Products',
                        style: Style.whiteTextStyle,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                      children: [
                        getExpansion(),
                        getBal(),
                      ],
                    ),
                    itemCount: 1,
                  ),
                  getRemark(textEditingController),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getExpansion() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: custom.ExpansionTitle(
        initiallyExpanded: false,
        headerBackgroundColor: Colors.red[50],
        backgroundColor: Colors.black12,
        iconColor: Colors.black,
        title: Row(
          children: [
            Text(
              'SP Bakery',
              style: Style.headingTextStyle,
            ),
          ],
        ),
        onExpansionChanged: (value) {
          // print(value);
        },
        children: [
          SizedBox(
            height: 4,
          ),
          getProducts(),
        ],
      ),
    );
  }

  Widget getProducts() {
    var secWidth = MediaQuery.of(context).size.width * 0.65;
    List _items = [
      'SP Bread',
      'SP Donut ',
      'SP Long Bread ',
      'SP Cream Roll ',
      'SP No Cream ',
      'SP Stawbarry Bread ',
      'SP Orange Cream '
    ];
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: _items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 80,
                width: width * 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'assets/icon/sp_bread1.jpg',
                    height: 80,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: 80,
                width: width * 0.7,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 4, top: 12),
                        child: Container(
                            width: secWidth * 0.85,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        children: [
                          Text(
                            '5',
                            style: Style.headingTextStyle,
                          ),
                          Spacer(),
                          Text(
                            '200',
                            style: Style.headingTextStyle,
                          ),
                          Spacer(),
                          Text(
                            '1000',
                            style: Style.headingTextStyle,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )
            ],
          ),
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
}
