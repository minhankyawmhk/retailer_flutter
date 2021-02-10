// import '../models/shop-user-model.dart';

// class ShopUserResponse {
//   final List<ShopUserModel> shopbyusers;
//   final String error;

//   ShopUserResponse({this.shopbyusers, this.error});

//   ShopUserResponse.fromJson(Map<String, dynamic> json)
//       : shopbyusers = (json["data"]["shopsByUser"])
//             .map((e) => new ShopUserModel.fromJson(e))
//             .toList(),
//         error = "";

//   ShopUserResponse.withError(String errorValue)
//       : shopbyusers = List(),
//         error = errorValue;
// }
