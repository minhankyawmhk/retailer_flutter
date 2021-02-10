import 'package:retailer/models/shopByListModel.dart';

class ShopByListVM {
  ShopByListM _shopByListM;

  ShopByListVM({ShopByListM shopByListM}) : _shopByListM = shopByListM;

  String get isSaleOrderLessRouteShop {
    return _shopByListM.isSaleOrderLessRouteShop;
  }

  String get address {
    return _shopByListM.address;
  }

  String get shopsyskey {
    return _shopByListM.shopsyskey;
  }

  String get long {
    return _shopByListM.long;
  }

  String get phoneno {
    return _shopByListM.phoneno;
  }

  String get zonecode {
    return _shopByListM.zonecode;
  }

  String get shopcode {
    return _shopByListM.shopcode;
  }

  String get shopname {
    return _shopByListM.shopname;
  }

  String get shopnamemm {
    return _shopByListM.shopnamemm;
  }

  String get teamcode {
    return _shopByListM.teamcode;
  }

  String get usercode {
    return _shopByListM.usercode;
  }

  String get user {
    return _shopByListM.user;
  }

  String get lat {
    return _shopByListM.lat;
  }

  String get email {
    return _shopByListM.email;
  }

  String get username {
    return _shopByListM.username;
  }

  String get pluscode {
    return _shopByListM.pluscode;
  }

  String get mimu {
    return _shopByListM.mimu;
  }

  String get street {
    return _shopByListM.street;
  }

  String get personph {
    return _shopByListM.personph;
  }

  String get personname {
    return _shopByListM.personname;
  }

  String get stateid {
    return _shopByListM.stateid;
  }

  String get districtid {
    return _shopByListM.districtid;
  }

  String get townshipid {
    return _shopByListM.townshipid;
  }

  String get townid {
    return _shopByListM.townid;
  }

  String get wardid {
    return _shopByListM.wardid;
  }

  String get tranid {
    return _shopByListM.tranid;
  }
}

class StatusVM {
  Status _status;

  StatusVM({Status status}) : _status = status;

  String get status {
    return _status.currentType;
  }

  String get message {
    return _status.message;
  }
}

class TaskVm {
  Task _task;

  TaskVm({Task task}) : _task = task;

  String get merchandizing {
    return _task.merchandizing;
  }

  String get inventoryCheck {
    return _task.inventoryCheck;
  }

  String get orderPlacement {
    return _task.orderPlacement;
  }

  String get print {
    return _task.print;
  }
}
