import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:retailer/models/checkIn_status_task.dart';
import 'package:retailer/models/shopByListModel.dart';
import 'package:retailer/screens/main/owner_visit_card.dart';
import 'package:retailer/screens/main/sale_person_visit_card.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:retailer/style/theme.dart' as Style;
import 'package:http/http.dart' as http;

import '../../custom/custom_expansion_title.dart' as custom;

var date = DateTime.now();
DateFormat dateFormat = DateFormat("yyyyMMdd");
String getDate = dateFormat.format(date);

getPhotoContainer(width, imgname) {
  return Container(
    height: 100,
    width: width * 0.23,
    child: Container(
      padding: EdgeInsets.all(2.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: 'http://52.255.142.115:8084/' + imgname,
          placeholder: (context, url) => Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
                strokeWidth: 2,
              ),
            ),
          ),
          fit: BoxFit.fill,
          errorWidget: (context, url, error) => Image.asset(
            'assets/icon/attach.png',
            color: Colors.grey[400],
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}

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

Future<ConnectivityResult> getConectivity() async {
  ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  return connectivityResult;
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

void loading(BuildContext context) {
  try {
    Dialogs.showLoadingDialog(
      context,
    );
  } catch (error) {
    return null;
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              children: <Widget>[
                Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
                ))
              ]);
        });
  }
}

checkInDialog(
  BuildContext context,
  ShopByListM element,
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
        ViewModelFunction model = Provider.of<ViewModelFunction>(
          context,
          listen: false,
        );
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
                                  await model.addActiveShop(element);

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
                              getConectivity()
                                  .then((ConnectivityResult value) async {
                                if (value == ConnectivityResult.none) {
                                  getToast(
                                      context, "Check your internet Conection");
                                  Navigator.pop(context, true);
                                } else {
                                  await model
                                      .routeCheckin(
                                          position, element, _selectedType)
                                      .timeout(Duration(seconds: 10),
                                          onTimeout: () {
                                    getToast(context,
                                        "Internet connection error !.");
                                    Navigator.pop(context, true);
                                  });
                                  if (model.statusCode == 200) {
                                    if (_selectedType == "Store Closed") {
                                      getToast(
                                          context, "Store Close Successful");
                                      Navigator.pop(context, true);
                                      Navigator.pop(context, true);
                                    } else {
                                      getToast(context, "Check In Successful");
                                      await model.addcheckInStatus(
                                          CheckInStatus(
                                              element
                                                  .status.task.inventoryCheck,
                                              element.status.task.merchandizing,
                                              element
                                                  .status.task.orderPlacement,
                                              element.status.task.print));
                                      await model.addActiveShop(element);

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
                                    getToast(context,
                                        "Server error !. Try again later");
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                  }
                                }
                              });
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
  try {
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
          ).then((value) {
            position = value;
          }).timeout(Duration(seconds: 15), onTimeout: () {
            getToast(context, "failed to get location.Please try again !");
            Navigator.pop(context, true);
          });
        }
      });
    } else {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((value) {
        position = value;
      }).timeout(Duration(seconds: 15), onTimeout: () {
        getToast(context, "failed to get location.Please try again !");
        Navigator.pop(context, true);
      });
    }
  } catch (e) {
    position = Position(longitude: 22.3453939, latitude: 96.34993439);
  }

  return position;
}

Widget getShopList(List<ShopByListM> dataList) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) => Card(
      color: Style.Colors.dropBackgroundColor,
      child: custom.ExpansionTitle(
        backgroundColor: Style.Colors.dropBackgroundColor,
        initiallyExpanded: true,
        headerBackgroundColor: Style.Colors.mainColor,
        iconColor: Style.Colors.textColor,
        title: Container(
          child: Row(
            children: [
              Text(
                "My lists of store for visit:",
                style: TextStyle(color: Style.Colors.textColor),
              ),
              Spacer(),
              Text(
                '0 / ${dataList.length}',
                style: TextStyle(color: Style.Colors.textColor),
              ),
            ],
          ),
        ),
        onExpansionChanged: (value) {},
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: InkWell(
                  onTap: () async {
                    await checkInDialog(
                      context,
                      dataList[index],
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(dataList[index].shopname,
                                style: Style.headingTextStyle),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                                getCurrentTypeSting(
                                    dataList[index].status.currentType),
                                style: getCurrentTypeTS(
                                  dataList[index].status.currentType,
                                )),
                          )
                        ],
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dataList[index].personph,
                              style: Style.secondTextStyle,
                            ),
                            Text(dataList[index].address,
                                style: Style.secondTextStyle)
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            itemCount: dataList.length,
          )
        ],
      ),
    ),
    itemCount: dataList.length >= 1 ? 1 : 0,
  );
}

TextStyle getCurrentTypeTS(String currentType) {
  TextStyle textStyle;
  switch (currentType) {
    case "CHECKIN":
      {
        textStyle = Style.statuspendingTextStyle;
      }
      break;

    case "CHECKOUT":
      {
        textStyle = Style.statusSuccessTextStyle;
      }
      break;
    case "STORECLOSED":
      {
        textStyle = Style.statustmpTextStyle;
      }
      break;
    case "TEMPCHECKOUT":
      {
        textStyle = Style.statustmpTextStyle;
      }
      break;

    default:
      {
        textStyle = TextStyle();
      }
      break;
  }
  return textStyle;
}

String getCurrentTypeSting(String currentType) {
  String value;
  switch (currentType) {
    case "CHECKIN":
      {
        value = "Pending";
      }
      break;

    case "CHECKOUT":
      {
        value = "Complete";
      }
      break;
    case "STORECLOSED":
      {
        value = "Store Closed";
      }
      break;
    case "TEMPCHECKOUT":
      {
        value = "Temporary Checkout";
      }
      break;

    default:
      {
        value = '';
      }
      break;
  }
  return value;
}

Widget getRemark(controller) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 4, top: 8),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[300])),
      height: 80,
      child: TextField(
        controller: controller,
        maxLines: 8,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "Remark :",
            hintText: "Tap on a clip to paste it in the text box",
            hintStyle: TextStyle(fontWeight: FontWeight.w300),
            labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                height: 1.2,
                color: Colors.black),
            fillColor: Colors.white,
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15)),
      ),
    ),
  );
}

Widget getOtherList(List<ShopByListM> otherList) {
  List<ShopByListM> filteredList = otherList.fold([], (current, next) {
    ShopByListM isExist = current.firstWhere((element) {
      return element.usercode == next.usercode;
    }, orElse: () => null);

    if (isExist == null) {
      current.add(next);
    }
    return current;
  });

  return getShopByTeam(filteredList, otherList);
}

Widget getShopByTeam(List<ShopByListM> dataList, List<ShopByListM> mainList) {
  List<Widget> getByTeam = [];

  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) => Card(
      color: Style.Colors.dropBackgroundColor,
      child: custom.ExpansionTitle(
        backgroundColor: Style.Colors.dropBackgroundColor,
        initiallyExpanded: false,
        headerBackgroundColor: Style.Colors.mainColor,
        iconColor: Style.Colors.textColor,
        title: Container(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  "Other lists ( " + dataList[index].username + " )",
                  style: TextStyle(
                    color: Style.Colors.textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Spacer(),
              getListLength(dataList[index].usercode, mainList),
            ],
          ),
        ),
        onExpansionChanged: (value) {},
        children: [
          new FutureBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> response) {
              getByTeam.clear();
              List<ShopByListM> list = mainList
                  .where((p) => p.usercode.contains(dataList[index].usercode))
                  .toList();
              list.forEach((element) {
                getByTeam.add(
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(element.shopname,
                                      style: Style.headingTextStyle),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                      getCurrentTypeSting(
                                          element.status.currentType),
                                      style: getCurrentTypeTS(
                                        element.status.currentType,
                                      )),
                                )
                              ],
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    element.personph,
                                    style: Style.secondTextStyle,
                                  ),
                                  Text(element.address,
                                      style: Style.secondTextStyle)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });

              return Column(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  new Column(children: getByTeam),
                ],
              );
            },
          ),
        ],
      ),
    ),
    itemCount: dataList.length ?? 0,
  );
}

Widget getListLength(String userCode, List<ShopByListM> mainList) {
  String length = mainList
      .where((p) => p.usercode.contains(userCode))
      .toList()
      .length
      .toString();
  return Text(
    '0 / $length',
    style: TextStyle(color: Style.Colors.textColor),
  );
}
