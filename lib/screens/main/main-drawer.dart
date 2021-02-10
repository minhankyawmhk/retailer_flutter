import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/mandatorytasks/orderList.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/screens/user/login.dart';
import 'package:retailer/screens/user/profile/profile.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  ViewModelFunction model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);

    return Drawer(
      child: Column(
        // Important: Remove any padding from the ListView.
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Profile()));
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: const DecorationImage(
                            image: ExactAssetImage("assets/notfound.png"),
                            fit: BoxFit.cover),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Style.Colors.mainColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Style.Colors.iconColor,
                ),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context, true);
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Style.Colors.iconColor,
                ),
                title: Text('Order List'),
                onTap: () {
                  Navigator.pop(context, true);
                  showAlertDialog();
                },
              ),
              Divider(
                height: 1,
              ),
            ],
          )),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Logout"),
                  color: Style.Colors.mainColor,
                  textColor: Style.Colors.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog() {
    int selected = 0;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(),
        title: Text(
          'Select Shop',
          style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1),
        ),
        titlePadding: EdgeInsets.only(top: 20, left: 8),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5 - 60,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      leading: selected == index + 1
                          ? Icon(
                              Icons.radio_button_checked,
                              color: Style.Colors.mainColor,
                            )
                          : Icon(Icons.radio_button_off),
                      title: Text(model.shopsByUser[index].shopname),
                      onTap: () {
                        setState(() {
                          selected = index + 1;
                        });
                      },
                    ),
                    itemCount: model.shopsByUser.length ?? 0,
                  ),
                ),
                Spacer(),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(),
                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Style.Colors.mainColor, width: 1.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Center(
                              child: Text('Cancel',
                                  style: TextStyle(
                                      color: Style.Colors.mainColor,
                                      fontWeight: FontWeight.w500)),
                            )),
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Style.Colors.mainColor, width: 1.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                            onPressed: () async {
                              if (selected != 0) {
                                Navigator.pop(context, true);
                                // showLoading();
                                await model.addActiveShop(
                                    model.shopsByUser[selected - 1]);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderListScreen()));
                              } else {
                                getToast(context, 'Select Shop');
                              }
                            },
                            child: Center(
                              child: Text(
                                'Select',
                                style: TextStyle(
                                    color: Style.Colors.mainColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
        contentPadding:
            EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 15),
      ),
    );
  }
}
