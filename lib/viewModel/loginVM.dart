import 'package:retailer/models/loginModel.dart';

class LoginViewModel {
  LoginModel _newLoginModel;

  LoginViewModel({LoginModel article}) : _newLoginModel = article;

  String get merchandizer {
    return _newLoginModel.merchandizer;
  }

  String get orgId {
    return _newLoginModel.orgId;
  }

  String get syskey {
    return _newLoginModel.syskey;
  }

  String get teamSyskey {
    return _newLoginModel.teamSyskey;
  }

  String get userId {
    return _newLoginModel.userId;
  }

  String get userName {
    return _newLoginModel.userName;
  }

  String get userType {
    return _newLoginModel.userType;
  }
}
