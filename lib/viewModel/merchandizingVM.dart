import 'package:retailer/models/merchandizing_M.dart';

class MerchandizingVM {
  MerchandizingM _newMerchandizingM;

  MerchandizingVM({MerchandizingM article}) : _newMerchandizingM = article;

  String get data {
    return _newMerchandizingM.data;
  }

  List<ListModel> get list {
    return _newMerchandizingM.list;
  }

  String get status {
    return _newMerchandizingM.status;
  }

  String get cause {
    return _newMerchandizingM.cause;
  }

  int get totalcount {
    return _newMerchandizingM.totalcount;
  }
}

class ListVM {
  ListModel _listModel;

  ListVM({ListModel article}) : _listModel = article;

  double get id {
    return _listModel.id;
  }

  String get campaignId {
    return _listModel.campaignId;
  }

  String get brandOwnerId {
    return _listModel.brandOwnerId;
  }

  String get taskId {
    return _listModel.taskId;
  }

  String get syskey {
    return _listModel.syskey;
  }

  String get brandOwnerCode {
    return _listModel.brandOwnerCode;
  }

  String get t1 {
    return _listModel.t1;
  }

  String get t2 {
    return _listModel.t2;
  }

  String get t3 {
    return _listModel.t3;
  }

  String get brandOwnerName {
    return _listModel.brandOwnerName;
  }

  String get createdDate {
    return _listModel.createdDate;
  }

  String get shopSysKey {
    return _listModel.shopSysKey;
  }

  String get campaignSysKey {
    return _listModel.campaignSysKey;
  }

  // String get userType {
  //   return _listModel.userType;
  // }

  String get campaignsyskey {
    return _listModel.campaignsyskey;
  }

  String get userSysKey {
    return _listModel.userSysKey;
  }

  List get pictureList {
    return _listModel.pictureList;
  }

  String get modifiedDate {
    return _listModel.campaignId;
  }

  List get lmc002 {
    return _listModel.lmc002;
  }

  List<TaskList> get taskList {
    return _listModel.taskList;
  }

  Mc002 get mc002 {
    return _listModel.mc002;
  }

  String get n1 {
    return _listModel.n1;
  }

  String get n2 {
    return _listModel.n2;
  }

  String get n3 {
    return _listModel.n3;
  }

  double get recordStatus {
    return _listModel.recordStatus;
  }

  String get taskCode {
    return _listModel.taskCode;
  }

  String get taskName {
    return _listModel.taskName;
  }
}

class TaskListVM {
  TaskList _taskList;

  TaskListVM({TaskList taskList}) : _taskList = taskList;

  String get syskey {
    return _taskList.syskey;
  }

  String get createddate {
    return _taskList.createddate;
  }

  String get modifieddate {
    return _taskList.modifieddate;
  }

  String get userid {
    return _taskList.userid;
  }

  String get username {
    return _taskList.username;
  }

  String get t1 {
    return _taskList.t1;
  }

  String get t2 {
    return _taskList.t2;
  }

  String get t3 {
    return _taskList.t3;
  }

  String get taskCode {
    return _taskList.taskCode;
  }

  String get taskName {
    return _taskList.taskName;
  }

  double get n1 {
    return _taskList.n1;
  }

  double get n2 {
    return _taskList.n2;
  }

  String get n3 {
    return _taskList.n3;
  }

  double get recordStatus {
    return _taskList.recordStatus;
  }

  String get usersyskey {
    return _taskList.usersyskey;
  }

  double get syncStatus {
    return _taskList.syncStatus;
  }

  String get syncBatch {
    return _taskList.syncBatch;
  }
}

class Mc002VM {
  Mc002 _mc002;

  Mc002VM({Mc002 mc002}) : _mc002 = mc002;

  String get campaignId {
    return _mc002.campaignId;
  }

  String get createdDate {
    return _mc002.createdDate;
  }

  String get modifiedDate {
    return _mc002.modifiedDate;
  }

  String get syskey {
    return _mc002.syskey;
  }

  double get recordStatus {
    return _mc002.recordStatus;
  }

  String get userKey {
    return _mc002.userKey;
  }

  String get t1 {
    return _mc002.t1;
  }

  String get t2 {
    return _mc002.t2;
  }

  String get t3 {
    return _mc002.t3;
  }

  String get n1 {
    return _mc002.n1;
  }

  double get n2 {
    return _mc002.n2;
  }

  double get n3 {
    return _mc002.n3;
  }

  List get mc003 {
    return _mc002.mc003;
  }
}
