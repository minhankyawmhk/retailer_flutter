import 'package:retailer/models/get_allstock.dart';

class GetAllStockViewModel {
  GetAllStock _getAllStock;

  GetAllStockViewModel({GetAllStock getAllStock}) : _getAllStock = getAllStock;

  String get syskey {
    return _getAllStock.syskey;
  }

  String get code {
    return _getAllStock.code;
  }

  String get desc {
    return _getAllStock.desc;
  }

  String get img {
    return _getAllStock.img;
  }

  String get packTypeCode {
    return _getAllStock.packTypeCode;
  }

  String get packSizeCode {
    return _getAllStock.packSizeCode;
  }

  String get floverCode {
    return _getAllStock.floverCode;
  }
  String get brandCode {
    return _getAllStock.brandCode;
  }

  String get brandOwnerCode {
    return _getAllStock.brandOwnerCode;
  }

  String get brandOwnerName {
    return _getAllStock.brandOwnerName;
  }

  String get brandOwnerSyskey {
    return _getAllStock.brandOwnerSyskey;
  }

  String get vendorCode {
    return _getAllStock.vendorCode;
  }

  String get categoryCode {
    return _getAllStock.categoryCode;
  }

  String get subCategoryCode {
    return _getAllStock.subCategoryCode;
  }
   String get categoryCodeDesc {
    return _getAllStock.categoryCodeDesc;
  }

  String get subCategoryCodeDesc {
    return _getAllStock.subCategoryCodeDesc;
  }

  String get whCode {
    return _getAllStock.whCode;
  }

  String get whSyskey {
    return _getAllStock.whSyskey;
  }
  List get details{
    return _getAllStock.details;
  }
}
