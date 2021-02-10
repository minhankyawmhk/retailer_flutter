import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/main/main_Screen_Search.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/screens/user/syncData/syncData.dart';
import 'package:retailer/services/functional_provider.dart';
import './main-drawer.dart';
import '../../style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ViewModelFunction model;

  var width;
  var height;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(
      context,
      listen: false,
    );

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    if (loading == true) {
      getData();
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: loading
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
                    strokeWidth: 2,
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Color(0xFFF5F5F5),
                appBar: AppBar(
                  title: Text("Retailer"),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: MainScreenSearch(
                                "Search...",
                              ));
                        }),
                  ],
                ),
                drawer: MainDrawer(),
                body: getBody(),
              ));
  }

  Widget getBody() {
    Widget widget;
    if (model.allShopSaleList.shopsByTeam.length > 0 ||
        model.allShopSaleList.shopsByUser.length > 0) {
      widget = Container(
        height: height,
        child: Column(
          children: [
            getUMWidget(),
            Flexible(
              child: Container(
                child: ListView(
                  children: [
                    getShopList(model.shopsByUser),
                    getOtherList(model.shopsByTeam),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      widget = Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        child: Center(
          child: Column(
            children: [
              ImageIcon(
                AssetImage("assets/icon/shop.png"),
                size: 50,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "No shop found !",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                width: 90,
                child: Card(
                  color: Colors.grey[300],
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SyncData()));
                      },
                      child: Text(
                        "Retry",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return widget;
  }

  Widget getUMWidget() {
    Widget widget;
    if (model.getLoginDetail != null) {
      if (model.getLoginDetail.userType == "saleperson" &&
          model.getLoginDetail.merchandizer == "Yes") {
        widget = Container(
          padding: EdgeInsets.all(5),
          height: 60,
          child: SizedBox(
            width: double.infinity,
            height: 45.0,
            child: RaisedButton(
              elevation: 0,
              onPressed: () async {
                // var isEnable = await Geolocator.checkPermission();
                // print(isEnable);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(Icons.cloud_upload),
                  SizedBox(width: 20.0),
                  Text("Upload Merchandizing"),
                  Spacer(),
                  Text("331/200")
                ],
              ),
              color: Style.Colors.mainColor,
              textColor: Style.Colors.textColor,
            ),
          ),
        );
      } else {
        widget = Container();
      }
    }
    return widget;
  }

  getData() async {
    getConectivity().then((ConnectivityResult value) async {
      if (value == ConnectivityResult.none) {
        getToast(context, "Check your internet Conection");
        setState(() {
          loading = false;
        });
      } else {
        // await model.login("09788571913", "123");
        // await model.getStockList();
        if (model.getLoginDetail != null) {
          await model.getMainList().timeout(Duration(seconds: 10),
              onTimeout: () {
            getToast(context, "Internet connection error");
            setState(() {
              loading = false;
            });
          });
        }

        setState(() {
          loading = false;
        });
      }
    });
  }
}
