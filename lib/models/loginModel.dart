class LoginModel {
  final String userType;
  final String userName;
  final String userId;
  final String syskey;
  final String orgId;
  final String teamSyskey;
  final String merchandizer;

  LoginModel({
    this.userType,
    this.userName,
    this.userId,
    this.syskey,
    this.orgId,
    this.teamSyskey,
    this.merchandizer,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userType: json['userType'],
      userName: json['userName'],
      userId: json['userId'],
      syskey: json['syskey'],
      orgId: json['orgId'],
      teamSyskey: json['teamSyskey'],
      merchandizer: json['merchandizer'],
    );
  }
}
