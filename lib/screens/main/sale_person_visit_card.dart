import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:retailer/models/checkIn_status_task.dart';
import 'package:retailer/screens/components/checkin-shop.dart';
import 'package:retailer/screens/main/main-drawer.dart';
import 'package:retailer/screens/main/main-screen.dart';
import 'package:retailer/screens/mandatorytasks/cart-item.dart';
import 'package:retailer/screens/mandatorytasks/inventorycheck.dart';
import 'package:retailer/screens/mandatorytasks/merchandizing.dart';
import 'package:retailer/screens/mandatorytasks/orderplacement.dart';
import 'package:retailer/screens/public/widget.dart';
import '../../services/functional_provider.dart';
import '../../style/theme.dart' as Style;
import 'package:flutter_svg/flutter_svg.dart';

class SalePersonVisitCard extends StatefulWidget {
  @override
  _SalePersonVisitCardState createState() => _SalePersonVisitCardState();
}

class _SalePersonVisitCardState extends State<SalePersonVisitCard> {
  bool three;
  bool isSwitched = false;
  ViewModelFunction model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(
      context,
    );
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
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: createCardWidget(checkout.id,
                                    checkout.img, "1.Check Out", ""),
                              ),
                              createCardWidget(
                                  inventorycheck.id,
                                  inventorycheck.img,
                                  "2.Inventory Check",
                                  model.checkInStatus.inventoryCheck),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: createCardWidget(
                                    merchandizing.id,
                                    merchandizing.img,
                                    "3.Merchandizing",
                                    model.checkInStatus.merchandizing),
                              ),
                              isSwitched
                                  ? Container()
                                  : createCardWidget(
                                      orderplacement.id,
                                      orderplacement.img,
                                      "4.OrderPlacement",
                                      model.checkInStatus.orderPlacement),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              createCardWidget(
                                  checkout.id, checkout.img, "1.Check Out", ""),
                              createCardWidget(
                                  inventorycheck.id,
                                  inventorycheck.img,
                                  "2.Inventory Check",
                                  model.checkInStatus.inventoryCheck),
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
                                      model.checkInStatus.orderPlacement),
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
    );
  }

  Widget createCardWidget(int id, String image, String text, String task) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () => getConectivity().then((ConnectivityResult value) async {
        if (value == ConnectivityResult.none) {
          getToast(context, "Check your internet Conection");
        } else {
          await cardClick(id).timeout(Duration(seconds: 15), onTimeout: () {
            getToast(context, "Internet connection error");
            Navigator.pop(context, true);
          });
        }
      }),
      child: Container(
        height: height * 0.28,
        width: width * 0.5 - 5,
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10),
                    child: statusColor(task),
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
              Spacer(),
              Container(
                color: Style.Colors.mainColor,
                height: 40,
                child: Center(
                    child: Text(
                  text,
                  style: Style.whiteTextStyle,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future cardClick(id) async {
    switch (id) {
      case 1:
        checkOutFun(context);
        break;
      case 2:
        loading(
          context,
        );
        if (model.checkInStatus.inventoryCheck != "COMPLETED") {
          await model.setTaskOfShop(
              "PENDING",
              model.checkInStatus.merchandizing,
              model.checkInStatus.orderPlacement);
          await model.addcheckInStatus(CheckInStatus(
              "PENDING",
              model.checkInStatus.merchandizing,
              model.checkInStatus.orderPlacement,
              model.checkInStatus.printStatus));
          Navigator.pop(context, true);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => InventoryCheckScreen()));
        } else {
          Navigator.pop(context, true);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => InventoryCheckScreen()));
        }

        break;
      case 3:
        loading(context);
        if (model.checkInStatus.merchandizing != "COMPLETED") {
          await model.setTaskOfShop(model.checkInStatus.inventoryCheck,
              "PENDING", model.checkInStatus.orderPlacement);
          await model.addcheckInStatus(CheckInStatus(
              model.checkInStatus.inventoryCheck,
              "PENDING",
              model.checkInStatus.orderPlacement,
              model.checkInStatus.printStatus));

          Navigator.pop(context, true);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => MerchandizingScreen()));
        } else {
          Navigator.pop(context, true);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => MerchandizingScreen()));
        }

        break;
      case 4:
        loading(
          context,
        );
        if (model.checkInStatus.orderPlacement != "COMPLETED") {
          await model.setTaskOfShop(model.checkInStatus.inventoryCheck,
              model.checkInStatus.merchandizing, "PENDING");
          await model.addcheckInStatus(CheckInStatus(
              model.checkInStatus.inventoryCheck,
              model.checkInStatus.merchandizing,
              "PENDING",
              model.checkInStatus.printStatus));
          Navigator.pop(context, true);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => OrderPlacementScreen()));
        } else {
          Navigator.pop(context, true);
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => OrderPlacementScreen()));
        }

        break;
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

class SalePersonVisitCardModel {
  int id;
  String text;
  String img;
  String task;

  SalePersonVisitCardModel({this.id, this.text, this.img, this.task});
}

SalePersonVisitCardModel checkout = new SalePersonVisitCardModel(
    id: 1, text: "1. Check Out", img: "assets/checkout.svg", task: "COMPLETE");
SalePersonVisitCardModel inventorycheck = new SalePersonVisitCardModel(
    id: 2, text: "2. Inventory Check", img: "assets/supplier_fill.svg");
SalePersonVisitCardModel merchandizing = new SalePersonVisitCardModel(
    id: 3, text: "3. Merchandizing", img: "assets/product_order_fill.svg");
SalePersonVisitCardModel orderplacement = new SalePersonVisitCardModel(
    id: 4, text: "4. Order Placement", img: "assets/order_fill.svg");
