import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/components/checkin-shop.dart';
import 'package:retailer/screens/main/main-drawer.dart';
import 'package:retailer/screens/main/main-screen.dart';
import 'package:retailer/screens/mandatorytasks/cart-item.dart';
import 'package:retailer/screens/mandatorytasks/inventorycheck.dart';
import 'package:retailer/screens/mandatorytasks/merchandizing.dart';
import 'package:retailer/screens/mandatorytasks/orderplacement.dart';
import 'package:retailer/screens/public/widget.dart';
import '../../models/shopByListModel.dart';
import '../../services/functional_provider.dart';
import '../../style/theme.dart' as Style;
import 'package:flutter_svg/flutter_svg.dart';

class VisitCard extends StatefulWidget {
  final ShopByListM _shopDetail;

  VisitCard(this._shopDetail);

  @override
  _VisitCardState createState() => _VisitCardState(this._shopDetail);
}

class _VisitCardState extends State<VisitCard> {
  final ShopByListM _shopDetail;

  _VisitCardState(this._shopDetail);

  bool three;
  bool isSwitched = false;
  bool first = false;
  List<VisitCardModel> visitcards = [
    checkout,
    inventorycheck,
    merchandizing,
    orderplacement
  ];

  ViewModelFunction model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context, listen: false);

    print(model.getLoginDetail.merchandizer);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          title: Text("Retailer"),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartItemScreen()));
              },
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                CheckinShop(),
                Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: model.getLoginDetail.merchandizer == 'Yes'
                      ? Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                createCardWidget(checkout.id, checkout.img,
                                    "1.Check Out", checkout.task),
                                createCardWidget(
                                    inventorycheck.id,
                                    inventorycheck.img,
                                    "2.Inventory Check",
                                    _shopDetail.status.task.inventoryCheck),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                createCardWidget(
                                    merchandizing.id,
                                    merchandizing.img,
                                    "3.Merchandizing",
                                    _shopDetail.status.task.merchandizing),
                                isSwitched
                                    ? Container()
                                    : createCardWidget(
                                        orderplacement.id,
                                        orderplacement.img,
                                        "4.OrderPlacement",
                                        _shopDetail.status.task.orderPlacement),
                              ],
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                createCardWidget(checkout.id, checkout.img,
                                    "1.Check Out", checkout.task),
                                createCardWidget(
                                    inventorycheck.id,
                                    inventorycheck.img,
                                    "2.Inventory Check",
                                    _shopDetail.status.task.inventoryCheck),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                isSwitched
                                    ? Container()
                                    : createCardWidget(
                                        orderplacement.id,
                                        orderplacement.img,
                                        "3.OrderPlacement Check",
                                        _shopDetail.status.task.orderPlacement),
                              ],
                            ),
                          ],
                        ),
                ),
                createSkipOrderplacementWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createCardWidget(int id, String image, String text, String task) {
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: InkWell(
        onTap: () => cardClick(id),
        child: Container(
          height: 180,
          width: width * 0.465,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: Style.Colors.borderColor,
                      child: color(task),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                    height: 40,
                    child: SvgPicture.asset(
                      image,
                      color: Style.Colors.mainColor,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: Style.Colors.mainColor,
                    height: 40,
                    child: Center(
                        child: Text(
                      text,
                      style: Style.whiteTextStyle,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget createCardWidget1() {
  //   return GridView.count(
  //       shrinkWrap: true,
  //       controller: new ScrollController(keepScrollOffset: false),
  //       scrollDirection: Axis.vertical,
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 4,
  //       childAspectRatio: 1.7 / 1.5,
  //       children: visitcards.map((card) {
  //         return Card(
  //             elevation: 3.0,
  //             shadowColor: Colors.white,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(2.0),
  //             ),
  //             margin: EdgeInsets.all(5),
  //             child: InkWell(
  //               onTap: () => cardClick(card.id),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Positioned(
  //                     top: 10,
  //                     child: Padding(
  //                       padding: EdgeInsets.only(top: 5.0, left: 10.0),
  //                       child: CircleAvatar(
  //                         radius: 5,
  //                         backgroundColor: Colors.yellow,
  //                         child: CircleAvatar(
  //                           backgroundColor: Colors.yellow,
  //                           radius: 4.5,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: Center(
  //                         child: Container(
  //                             height: 40,
  //                             child: SvgPicture.asset(
  //                               card.img,
  //                               color: Style.Colors.mainColor,
  //                             ))),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.bottomCenter,
  //                     child: SizedBox(
  //                       width: double.infinity,
  //                       child: Container(
  //                         color: Style.Colors.mainColor,
  //                         height: 40,
  //                         child: Center(
  //                             child: Text(
  //                           card.text,
  //                           style: Style.whiteTextStyle,
  //                         )),
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //         );
  //       }).toList());
  // }

  cardClick(id) {
    print(id);

    switch (id) {
      case 1:
        checkOutFun(context);
        break;
      case 2:
        Navigator.push(
            context,
            new CupertinoPageRoute(
                builder: (context) => InventoryCheckScreen()));
        break;
      case 3:
        Navigator.push(
            context,
            new CupertinoPageRoute(
                builder: (context) => MerchandizingScreen()));
        break;
      case 4:
        loading(
          context,
        );
        Navigator.push(
            context,
            new CupertinoPageRoute(
                builder: (context) => OrderPlacementScreen()));
        break;
    }
  }

  color(task) {
    if (task == 'COMPLETE') {
      return (CircleAvatar(
        backgroundColor: Colors.green,
        radius: 4.5,
      ));
    }
    if (task == 'PENDING') {
      return (CircleAvatar(
        backgroundColor: Colors.yellow,
        radius: 4.5,
      ));
    }
    if (task == 'INCOMPLETE') {
      return (CircleAvatar(
        backgroundColor: Colors.white,
        radius: 4.5,
      ));
    }
  }

  Widget createSkipOrderplacementWidget() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Skip Order Placement",
                style: Style.headingTextStyle,
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    first = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Style.Colors.mainColor,
                activeColor: Style.Colors.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createplacementWidget() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Placement",
                style: Style.headingTextStyle,
              ),
              Switch(
                value: three,
                onChanged: (value) {
                  setState(() {
                    three = value;
                    print(three);
                  });
                },
                activeTrackColor: Style.Colors.mainColor,
                activeColor: Style.Colors.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  changeColor(task) {}

  checkOutFun(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No", style: TextStyle(color: Style.Colors.iconColor)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (_) => MainScreen()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("AlertDialog"),
      contentPadding: EdgeInsets.all(15),
      content: Text("Do you want to checkout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class VisitCardModel {
  int id;
  String text;
  String img;
  String task;

  VisitCardModel({this.id, this.text, this.img, this.task});
}

VisitCardModel checkout = new VisitCardModel(
    id: 1, text: "1. Check Out", img: "assets/checkout.svg", task: "COMPLETE");
VisitCardModel inventorycheck = new VisitCardModel(
    id: 2, text: "2. Inventory Check", img: "assets/supplier_fill.svg");
VisitCardModel merchandizing = new VisitCardModel(
    id: 3, text: "3. Merchandizing", img: "assets/product_order_fill.svg");
VisitCardModel orderplacement = new VisitCardModel(
    id: 4, text: "4. Order Placement", img: "assets/order_fill.svg");
