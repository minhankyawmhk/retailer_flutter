class ShopByListM {
  final String isSaleOrderLessRouteShop;
  final String address;
  final String shopsyskey;
  final String long;
  final String phoneno;
  final String zonecode;
  final String shopcode;
  final String shopname;
  final String shopnamemm;
  final String teamcode;
  final String usercode;
  final String user;
  final String lat;
  final String email;
  final String username;
  final String pluscode;
  final String mimu;
  final String street;
  final String personph;
  final String personname;
  final String stateid;
  final String districtid;
  final String townshipid;
  final String townid;
  final String wardid;
  final String tranid;
  final Status status;

  ShopByListM({
    this.isSaleOrderLessRouteShop,
    this.address,
    this.shopsyskey,
    this.long,
    this.phoneno,
    this.zonecode,
    this.shopcode,
    this.shopname,
    this.shopnamemm,
    this.teamcode,
    this.usercode,
    this.user,
    this.lat,
    this.email,
    this.username,
    this.pluscode,
    this.mimu,
    this.street,
    this.personph,
    this.personname,
    this.stateid,
    this.districtid,
    this.townshipid,
    this.townid,
    this.wardid,
    this.tranid,
    this.status,
    // this.task,
  });

  factory ShopByListM.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShopByListM(
      isSaleOrderLessRouteShop: json['isSaleOrderLessRouteShop'],
      address: json['address'],
      shopsyskey: json['shopsyskey'],
      long: json['long'],
      phoneno: json['phoneno'],
      zonecode: json['zonecode'],
      shopcode: json['shopcode'],
      shopname: json['shopname'],
      shopnamemm: json['shopnamemm'],
      teamcode: json['teamcode'],
      usercode: json['usercode'],
      user: json['user'],
      lat: json['lat'],
      email: json['email'],
      username: json['username'],
      pluscode: json['pluscode'],
      mimu: json['mimu'],
      street: json['street'],
      personph: json['personph'],
      personname: json['personname'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      townshipid: json['townshipid'],
      townid: json['townid'],
      wardid: json['wardid'],
      tranid: json['tranid'],
      status: Status.fromJson(
        json['status'],
      ),
      // task: Task.fromJson(json['task']),
    );
  }
}

class Status {
  final String currentType;
  final String message;
  final Task task;

  Status({this.currentType, this.message, this.task});

  factory Status.fromJson(
    Map<String, dynamic> json,
  ) {
    return Status(
        currentType: json['currentType'],
        message: json['message'],
        task: Task.fromJson(json["task"]));
  }
}

class Task {
  final String inventoryCheck;
  final String merchandizing;
  final String orderPlacement;
  final String print;

  Task({
    this.inventoryCheck,
    this.merchandizing,
    this.orderPlacement,
    this.print,
  });

  factory Task.fromJson(
    Map<String, dynamic> json,
  ) {
    return Task(
        inventoryCheck: json['inventoryCheck'],
        merchandizing: json['merchandizing'],
        orderPlacement: json['orderPlacement'],
        print: json['print']);
  }
}
