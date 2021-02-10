//   class ShopUserModel {
//   final String id;
//   final String address;
//   final String shopsyskey;
//   final String shopname;
//   final String long;
//   final String phoneno;
//   final String zonecode;
//   final String shopcode;
//   final String teamcode;
//   final String location;
//   final String usercode;
//   final String user;
//   final String lat;
//   final String email;
//   final String username;
//   final String currentType;
//   final List task;

//   ShopUserModel(
//       {this.id,
//       this.address,
//       this.shopsyskey,
//       this.shopname,
//       this.long,
//       this.phoneno,
//       this.zonecode,
//       this.shopcode,
//       this.teamcode,
//       this.location,
//       this.usercode,
//       this.user,
//       this.lat,
//       this.email,
//       this.username,
//       this.currentType,
//       this.task});

//   factory ShopUserModel.fromJson(Map<String, dynamic> json) {
//     return ShopUserModel(
//         address: json["address"],
//         shopsyskey: json["shopsyskey"],
//         shopname: json["shopname"],
//         long: json["long"],
//         phoneno: json["phoneno"],
//         zonecode: json["zonecode"],
//         shopcode: json["shopcode"],
//         teamcode: json["teamcode"],
//         location: json["location"],
//         usercode: json["usercode"],
//         user: json["user"],
//         lat: json["lat"],
//         email: json["email"],
//         username: json["username"],
//         currentType: json["currentType"],
//         task: json["status"]["task"]);
//   }
// }
