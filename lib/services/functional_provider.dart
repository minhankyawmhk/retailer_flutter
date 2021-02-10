import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:retailer/models/all_shop_saleList.dart';
import 'package:retailer/models/checkIn_status_task.dart';
import 'package:retailer/models/get_allstock.dart';
import 'package:retailer/models/loginModel.dart';
import 'package:retailer/models/merchandizing_M.dart';
import 'package:retailer/models/shopByListModel.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewModelFunction with ChangeNotifier {
  CheckInStatus _checkInStatus;
  LoginModel getLoginDetail;
  MerchandizingM merchandizingM;
  List<ListModel> listModel;
  AllShopSaleList allShopSaleList;
  List<ShopByListM> shopsByTeam;
  List<ShopByListM> shopsByUser;
  List<GetAllStock> allStock;
  int statusCode;
  String signUpDetail;
  String status;
  String param;
  String sessionId;
  ShopByListM _activeShop;

  CheckInStatus get checkInStatus => _checkInStatus;

  ShopByListM get activeShop => _activeShop;

  set checkInStatus(CheckInStatus setposition) {
    _checkInStatus = setposition;
    notifyListeners();
  }

  set activeShop(ShopByListM setActiveShop) {
    _activeShop = setActiveShop;
    notifyListeners();
  }

  addcheckInStatus(CheckInStatus addCheckInStatus) {
    _checkInStatus = addCheckInStatus;
    notifyListeners();
  }

  addActiveShop(ShopByListM addActiveShop) {
    _activeShop = addActiveShop;
    notifyListeners();
  }

  Future login(String userId, String pass) async {
    // print("work");
    param = jsonEncode({
      "userId": '$userId',
      "password": '$pass',
    });
    final http.Response response =
        await httpRequest('main/logindebug/mit', param, '');
    if (response != null) {
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        getLoginDetail = LoginModel.fromJson(result);
        statusCode = response.statusCode;
      } else {
        statusCode = response.statusCode;
      }
    } else {
      statusCode = 0;
    }
    notifyListeners();
  }

  Future getShopKey(String shopSysKey, String userType) async {
    param = jsonEncode({"shopSysKey": '$shopSysKey', "userType": '$userType'});
    final http.Response response =
        await httpRequest('campaign/getshopKey/', param, getLoginDetail.orgId);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      merchandizingM = MerchandizingM.fromJson(result);
      this.listModel =
          merchandizingM.list.map((el) => ListModel.fromJson(el)).toList();
      statusCode = response.statusCode;
    } else {
      statusCode = response.statusCode;
    }
    notifyListeners();
  }

  setTaskOfShop(String inventoryCheck, String merchandizing,
      String orderplacement) async {
    // print("$inventoryCheck , $merchandizing, $orderplacement");
    // print(sessionId);
    param = jsonEncode({
      "sessionId": sessionId,
      "task": {
        "inventoryCheck": "$inventoryCheck",
        "merchandizing": "$merchandizing",
        "orderPlacement": "$orderplacement",
        "print": "COMPLETED"
      }
    });
    final http.Response response =
        await httpRequest('/route/settask', param, getLoginDetail.orgId);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['status'] == 'SUCCESS') {
        await getMainList();
      }
      statusCode = response.statusCode;
    } else {
      statusCode = response.statusCode;
    }
    notifyListeners();
  }

  resetPassword(String currentPass, String newpass) async {
    param = jsonEncode({
      "id": getLoginDetail.userId,
      "oldpass": '$currentPass',
      "newpass": '$newpass'
    });
    final http.Response response =
        await httpRequest('main/reset/mit', param, getLoginDetail.orgId);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      statusCode = response.statusCode;
      status = result['status'];
    } else {
      statusCode = response.statusCode;
    }
    notifyListeners();
  }

  Future routeCheckin(
      Position position, ShopByListM element, String checkInType) async {
    String state;
    if (checkInType == null) {
      state = "CHECKIN";
    }
    if (checkInType == "Check In") {
      state = "CHECKIN";
    }
    if (checkInType == "Store Closed") {
      state = "STORECLOSED";
    } else {
      state = "CHECKIN";
    }

    param = jsonEncode({
      "lat": position.latitude.toString(),
      "lon": position.longitude.toString(),
      "address": element.address,
      "shopsyskey": element.shopsyskey,
      "usersyskey": getLoginDetail.syskey,
      "checkInType": "$state",
      "register": false,
      "task": {
        "inventoryCheck": "COMPLETED",
        "merchandizing": "COMPLETED",
        "orderPlacement": "COMPLETED",
        "print": "COMPLETED"
      }
    });
    final http.Response response =
        await httpRequest('/route/checkin', param, getLoginDetail.orgId);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      status = result['status'];
      sessionId = result['data']["sessionid"];
      statusCode = response.statusCode;
    } else {
      statusCode = response.statusCode;
    }
  }

  shopTransfer(String shopSysKey, String teamSysKey) async {
    param = jsonEncode({
      "date": "$getDate",
      "t1": "",
      "userSyskey": getLoginDetail.syskey,
      "shopSyskey": "$shopSysKey",
      "n1": "$teamSysKey",
      "n2": "",
      "n3": ""
    });
    final http.Response response = await httpRequest(
        'shopPerson/insertUJUN002/', param, getLoginDetail.orgId);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      status = result['status'];
      statusCode = response.statusCode;
    } else {
      statusCode = response.statusCode;
    }
  }

  getStockList() async {
    param = jsonEncode({
      'code': '',
      'desc': '',
      'vendorSyskey': '',
      'brandSysey': '',
      'categorySyskey': '',
      'packTypeSyskey': '0',
      'packSizeSyskey': '0',
      'flavorSyskey': '0',
    });
    final http.Response response =
        await httpRequest('stock/getstockall', param, getLoginDetail.orgId);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final Iterable list = result['list'];
      this.allStock = list.map((el) => GetAllStock.fromJson(el)).toList();
    

      status = result['status'];
      statusCode = response.statusCode;
    } else {
      statusCode = response.statusCode;
    }
  }

  Future getMainList() async {
    this.allShopSaleList = await getMainScreenList(
            spsysKey: getLoginDetail.syskey,
            teamsysKey: getLoginDetail.teamSyskey,
            userType: getLoginDetail.userType,
            date: getDate,
            orgId: getLoginDetail.orgId)
        .timeout(Duration(seconds: 8), onTimeout: () {
      return null;
    });
    this.shopsByTeam = allShopSaleList.shopsByTeam
        .map((el) => ShopByListM.fromJson(el))
        .toList();
    this.shopsByUser = allShopSaleList.shopsByUser
        .map((e) => ShopByListM.fromJson(e))
        .toList();
  }

  signUp(
    String userName,
    String phone,
    String pass,
  ) async {
    param = jsonEncode({
      "userId": phone,
      "userName": userName,
      "password": pass,
      "passcode": getLoginDetail.orgId
    });
    final http.Response response =
        await httpRequest('main/signup/mit', param, '');
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      signUpDetail = result['message'];
      statusCode = response.statusCode;
    } else {
      statusCode = response.statusCode;
    }
    notifyListeners();
  }

  Future<http.Response> httpRequest(urlname, param, String ordId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var mainUrl = preferences.getString('mainUrl') ??
        "http://52.255.142.115:8084/madbrepository/";
    try {
      String url = mainUrl + urlname;
      return http
          .post(Uri.encodeFull(url), body: param, headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Content-Over": "$ordId",
          })
          .timeout(Duration(seconds: 5))
          .catchError((error) {});
    } catch (e) {
      return throw (e);
    }
  }

  Future<AllShopSaleList> getMainScreenList(
      {String spsysKey,
      String teamsysKey,
      String userType,
      String date,
      String orgId}) async {
    param = jsonEncode({
      "spsyskey": "$spsysKey",
      "teamsyskey": "$teamsysKey",
      "usertype": "$userType",
      "date": "$date",
    });

    final http.Response response =
        await httpRequest('shop/getshopall', param, orgId);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      // print(result);
      statusCode = response.statusCode;

      AllShopSaleList allShopSaleList = AllShopSaleList.fromJson(result);
      notifyListeners();

      return allShopSaleList;
    } else {
      statusCode = response.statusCode;
      notifyListeners();

      throw Exception(response);
    }
  }
}
