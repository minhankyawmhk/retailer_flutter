class MerchandizingM {
  final String data;
  final List list;
  final String status;
  final String cause;
  final int totalcount;

  MerchandizingM(
      {this.data, this.list, this.status, this.cause, this.totalcount});

  factory MerchandizingM.fromJson(Map<String, dynamic> json) {
    return MerchandizingM(
      data: json["data"],
      list: json["list"],
      status: json['status'],
      cause: json['cause'],
      totalcount: json['totalcount'],
    );
  }
}

class ListModel {
  final double id;
  final String campaignId;
  final String brandOwnerId;
  final String taskId;
  final String syskey;
  final String t1;
  final String t2;
  final String t3;
  final String brandOwnerCode;
  final String brandOwnerName;
  final String createdDate;
  final String shopSysKey;
  final String campaignSysKey;
  final String campaignsyskey;
  final String userSysKey;
  final List pictureList;
  final String modifiedDate;
  final List lmc002;
  final List taskList;
  final Mc002 mc002;
  final String n1;
  final String n2;
  final String n3;
  final double recordStatus;
  final String taskCode;
  final String taskName;

  ListModel({
    this.id,
    this.campaignId,
    this.brandOwnerId,
    this.taskId,
    this.syskey,
    this.t1,
    this.t2,
    this.t3,
    this.brandOwnerCode,
    this.brandOwnerName,
    this.shopSysKey,
    this.createdDate,
    this.campaignSysKey,
    // this.userType,
    this.campaignsyskey,
    this.userSysKey,
    this.pictureList,
    this.modifiedDate,
    this.lmc002,
    this.taskList,
    this.mc002,
    this.n1,
    this.n2,
    this.n3,
    this.recordStatus,
    this.taskCode,
    this.taskName,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json["id"],
      campaignId: json["campaignId"],
      brandOwnerId: json["brandOwnerId"],
      taskId: json["taskId"],
      syskey: json["syskey"],
      t1: json["t1"],
      t2: json["t2"],
      t3: json["t3"],
      brandOwnerCode: json["brandOwnerCode"],
      brandOwnerName: json["brandOwnerName"],
      shopSysKey: json["shopSysKey"],
      createdDate: json["createdDate"],
      campaignSysKey: json["campaignSysKey"],
      // userType: json["userType"],
      campaignsyskey: json["campaignsyskey"],
      userSysKey: json["userSysKey"],
      pictureList: json["pictureList"],
      modifiedDate: json["modifiedDate"],
      lmc002: json["lmc002"],
      taskList: json["taskList"],
      mc002: Mc002.fromJson(json['mc002']),
      n1: json["n1"],
      n2: json["n2"],
      n3: json["n3"],
      recordStatus: json["recordStatus"],
      taskCode: json["taskCode"],
      taskName: json["taskName"],
    );
  }
}

class TaskList {
  final String syskey;
  final String createddate;
  final String modifieddate;
  final String userid;
  final String username;
  final String t1;
  final String t2;
  final String t3;
  final String taskCode;
  final String taskName;
  final double n1;
  final double n2;
  final String n3;
  final double recordStatus;
  final String usersyskey;
  final double syncStatus;
  final String syncBatch;

  TaskList(
      {this.syskey,
      this.createddate,
      this.modifieddate,
      this.userid,
      this.username,
      this.t1,
      this.t2,
      this.t3,
      this.taskCode,
      this.taskName,
      this.n1,
      this.n2,
      this.n3,
      this.recordStatus,
      this.usersyskey,
      this.syncStatus,
      this.syncBatch});

  factory TaskList.fromJson(Map<String, dynamic> json) {
    return TaskList(
        syskey: json["syskey"],
        createddate: json["createddate"],
        modifieddate: json["modifieddate"],
        userid: json["userid"],
        username: json["username"],
        t1: json["t1"],
        t2: json["t2"],
        t3: json["t3"],
        taskCode: json["taskCode"],
        taskName: json["taskName"],
        n1: json["n1"],
        n2: json["n2"],
        n3: json["n3"],
        recordStatus: json["recordStatus"],
        usersyskey: json["usersyskey"],
        syncStatus: json["syncStatus"],
        syncBatch: json["syncBatch"]);
  }
}

class Mc002 {
  final String campaignId;
  final String brandOwnerId;
  final String createdDate;
  final String modifiedDate;
  final String syskey;
  final double recordStatus;
  final String userKey;
  final String n1;
  final double n2;
  final double n3;
  final String t1;
  final String t2;
  final String t3;
  final List mc003;

  Mc002(
      {this.campaignId,
      this.brandOwnerId,
      this.createdDate,
      this.modifiedDate,
      this.syskey,
      this.recordStatus,
      this.userKey,
      this.n1,
      this.n2,
      this.n3,
      this.t1,
      this.t2,
      this.t3,
      this.mc003});

  factory Mc002.fromJson(Map<String, dynamic> json) {
    return Mc002(
      campaignId: json["campaignId"],
      brandOwnerId: json["brandOwnerId"],
      createdDate: json["createdDate"],
      modifiedDate: json["modifiedDate"],
      syskey: json["syskey"],
      recordStatus: json["recordStatus"],
      userKey: json["userKey"],
      t1: json["t1"],
      t2: json["t2"],
      t3: json["t3"],
      n1: json["n1"],
      n2: json["n2"],
      n3: json["n3"],
      mc003: json["mc003"],
    );
  }
}
