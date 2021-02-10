import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/models/shopByListModel.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:retailer/style/theme.dart' as Style;

class TransferWidget extends StatefulWidget {
  @override
  _TransferWidgetState createState() => _TransferWidgetState();
}

class _TransferWidgetState extends State<TransferWidget> {
  ViewModelFunction model;
  String _shopValue;
  String _userValue;
  double width;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              getSelectShop(),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              getSelectUser(),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Style.Colors.mainColor,
                ),
                height: 40,
                width: width,
                child: FlatButton(
                  onPressed: () async {
                    if (_shopValue == null) {
                      getToast(context, 'select shop');
                    } else if (_userValue == null) {
                      getToast(context, 'select user');
                    } else if (_shopValue != null && _userValue != null) {
                      List<ShopByListM> shopSysKey = model.shopsByUser
                          .where((element) =>
                              element.shopname.contains(_shopValue))
                          .toList();
                      List<ShopByListM> userCode = model.shopsByTeam
                          .where((element) =>
                              element.username.contains(_userValue))
                          .toList();

                      await model.shopTransfer(
                          shopSysKey[0].shopsyskey, userCode[0].usercode);
                      if (model.statusCode == 200) {
                        if (model.status == "Already Existed") {
                          getToast(context, 'Transfer Already Existed');
                          await model.getMainList();
                        } else {
                          getToast(context, 'Transfer Successful');
                          await model.getMainList();
                        }
                      } else {
                        getToast(context, "Server error !. Try again later");
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      'Submit',
                      style: Style.whiteTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSelectShop() {
    List<ShopByListM> filteredList = [];
    if (model.shopsByUser != null) {
      filteredList = model.shopsByUser
          .where((element) => element.status.currentType.isEmpty)
          .toList();
    }

    return Stack(
      children: [
        Positioned(
          bottom: 18,
          child: ImageIcon(
            AssetImage('assets/shop.png'),
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: DropdownButton(
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Style.Colors.mainColor,
            underline: Container(),
            isExpanded: true,
            value: _shopValue,
            hint: Text('Select Shop'),
            items: filteredList.map((element) {
              return DropdownMenuItem<String>(
                  value: element.shopname,
                  child: Text(element.shopname,
                      style: TextStyle(color: Colors.black)));
            }).toList(),
            onChanged: (shopValue) {
              setState(() {
                _shopValue = shopValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget getSelectUser() {
    List<ShopByListM> filteredList = [];
    if (model.shopsByTeam != null) {
      filteredList = model.shopsByTeam.fold([], (current, next) {
        ShopByListM isExist = current.firstWhere((element) {
          return element.usercode == next.usercode;
        }, orElse: () => null);

        if (isExist == null) {
          current.add(next);
        }
        return current;
      });
    }
    return Stack(
      children: [
        Positioned(
          bottom: 15,
          child: ImageIcon(
            AssetImage('assets/icon/user.png'),
            size: 20,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: DropdownButton(
            focusNode: FocusNode(canRequestFocus: false),
            iconEnabledColor: Colors.grey,
            iconDisabledColor: Style.Colors.mainColor,
            underline: Container(),
            isExpanded: true,
            value: _userValue,
            hint: Text('Select User'),
            items: filteredList.map((element) {
              return DropdownMenuItem<String>(
                value: element.username,
                child: Text(
                  element.username,
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (userValue) {
              setState(() {
                _userValue = userValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
