import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:retailer/models/checkIn_status_task.dart';
import 'package:retailer/models/shopByListModel.dart';
import 'package:retailer/screens/main/owner_visit_card.dart';
import 'package:retailer/screens/main/sale_person_visit_card.dart';

import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:retailer/style/theme.dart' as Style;

var date = DateTime.now();
DateFormat dateFormat = DateFormat("yyyyMMdd");
String getDate = dateFormat.format(date);

getToast(BuildContext context, String message) {
  return showToast(message,
      context: context,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: 4),
      animDuration: Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn);
}

String getPhoneFormat(String message) {
  String formatedPhone;
  if (message.startsWith('09')) {
    formatedPhone = message.replaceFirst('09', '+959');
  } else if (message.startsWith('959')) {
    formatedPhone = message.replaceFirst('959', '+959');
  } else if (message.length < 10) {
    formatedPhone = '+959' + message;
  }
  return formatedPhone;
}

Widget statusColor(task) {
  Widget statusWidget;
  if (task == 'COMPLETED') {
    statusWidget = CircleAvatar(
      backgroundColor: Colors.green,
      radius: 4.5,
    );
  }
  if (task == 'PENDING') {
    statusWidget = CircleAvatar(
      backgroundColor: Colors.yellow,
      radius: 4.5,
    );
  }
  if (task == 'INCOMPLETE' || task == "" || task == null) {
    statusWidget = Container();
  }
  return statusWidget;
}

checkInDialog(
  BuildContext context,
  ShopByListM element,
  ViewModelFunction model,
) {
  Position position;
  List<String> _checkInList = ['Check In', 'Store Closed'];
  String _selectedType;
  DateFormat dateFormat = DateFormat("dd/MM/yyyy-HH:mm aaa");

  String currentTime = dateFormat.format(DateTime.now());

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(),
      title: Text(
        'Check In',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 1),
      ),
      titlePadding: EdgeInsets.only(top: 20, left: 8),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icon/shop.png'),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          child: Text(element.shopname),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icon/history.png'),
                      color: Colors.grey[700],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, left: 8),
                        child: Container(
                          child: Text('$currentTime'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ImageIcon(
                        AssetImage('assets/icon/pin.png'),
                      ),
                    ),
                    Flexible(
                      child: FutureBuilder(
                          future: getCurrentLocation(context),
                          builder: (context, AsyncSnapshot snapshot) {
                            position = snapshot.data;
                            if (snapshot.data == null) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 18,
                                  top: 8,
                                ),
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Style.Colors.mainColor),
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, left: 8),
                                child: Text(
                                  '${snapshot.data.latitude}/${snapshot.data.longitude}',
                                  style:
                                      TextStyle(color: Style.Colors.mainColor),
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ImageIcon(
                      AssetImage('assets/icon/squares.png'),
                    ),
                  ),
                  Flexible(
                    child: element.status.currentType != ''
                        ? Padding(
                            padding: const EdgeInsets.only(top: 28, left: 8),
                            child: Container(
                              child: Text('Check In'),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 15),
                            child: Container(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white))),

                                selectedItemBuilder: (value) {
                                  return [
                                    _selectedType == null
                                        ? Text('Select Type')
                                        : Text(_selectedType.toString()),
                                    Text(_selectedType.toString()),
                                  ];
                                },
                                isExpanded: true,
                                hint: Text('Select Type'),
                                // Not necessary for Option 1
                                value: _checkInList[0],
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedType = newValue;
                                  });
                                },
                                items: _checkInList.map((element) {
                                  return DropdownMenuItem<String>(
                                    child: Row(
                                      children: [
                                        Text(element),
                                        Spacer(),
                                        _selectedType == element
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                color: Style.Colors.mainColor,
                                              )
                                            : Icon(
                                                Icons.radio_button_off,
                                                color: Colors.grey[500],
                                              ),
                                      ],
                                    ),
                                    value: element,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icon/map.png'),
                      color: Colors.grey[700],
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Container(
                          child: Text('${element.address}\r\n'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
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
                          if (element.status.currentType != "") {
                            if (position != null) {
                              loading(context);
                              await model.routeCheckin(
                                  position, element, _selectedType);
                              if (model.statusCode == 200) {
                                if (_selectedType == "Store Closed") {
                                  getToast(context, "Store Close Successful");
                                  Navigator.pop(context, true);
                                  Navigator.pop(context, true);
                                } else {
                                  getToast(context, "Check In Successful");
                                  await model.addcheckInStatus(CheckInStatus(
                                      element.status.task.inventoryCheck,
                                      element.status.task.merchandizing,
                                      element.status.task.orderPlacement,
                                      element.status.task.print));

                                  if (model.getLoginDetail.userType ==
                                      "storeowner") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StoreOwnerVisitCard()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SalePersonVisitCard()));
                                  }
                                }
                              } else {
                                getToast(
                                    context, "Server error !. Try again later");
                                Navigator.pop(context, true);
                                Navigator.pop(context, true);
                              }
                            } else if (position == null) {
                              getToast(
                                  context, 'Please check location permission');
                            }
                          } else if (element.status.currentType == "") {
                            if (position == null) {
                              getToast(
                                  context, "Please check location permission");
                            }
                            if (_selectedType == null) {
                              getToast(context, "Please select type");
                            } else if (position != null &&
                                _selectedType != null) {
                              loading(context);

                              await model.routeCheckin(
                                  position, element, _selectedType);
                              if (model.statusCode == 200) {
                                if (_selectedType == "Store Closed") {
                                  getToast(context, "Store Close Successful");
                                  Navigator.pop(context, true);
                                  Navigator.pop(context, true);
                                } else {
                                  getToast(context, "Check In Successful");
                                  await model.addcheckInStatus(CheckInStatus(
                                      element.status.task.inventoryCheck,
                                      element.status.task.merchandizing,
                                      element.status.task.orderPlacement,
                                      element.status.task.print));
                                  if (model.getLoginDetail.userType ==
                                      "storeowner") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StoreOwnerVisitCard()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SalePersonVisitCard()));
                                  }
                                }
                              } else {
                                getToast(
                                    context, "Server error !. Try again later");
                                Navigator.pop(context, true);
                                Navigator.pop(context, true);
                              }
                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        );
      }),
      contentPadding: EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 15),
    ),
  );
}

Future<Position> getCurrentLocation(BuildContext context) async {
  Position position;
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    await Geolocator.requestPermission()
        .then((LocationPermission permission) async {
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        getToast(context, "Please allow location permission");
        Navigator.pop(context, true);
      } else if (permission == LocationPermission.always) {
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        ).then((value) => position = value).timeout(Duration(seconds: 15),
            onTimeout: () {
          getToast(context, "failed to get location.Please try again !");
          Navigator.pop(context, true);
          return position;
        });
      }
    });
  } else {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((value) => position = value).timeout(Duration(seconds: 15),
        onTimeout: () {
      getToast(context, "failed to get location.Please try again !");
      Navigator.pop(context, true);
      return position;
    });
  }

  return position;
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  elevation: 0,
                  key: key,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
                    ))
                  ]));
        });
  }
}
