
import 'package:retailer/models/get_stock_details.dart';

class AllStockDetailsVM {
  GetStockDetails _newAllStockDetailsVM;

  AllStockDetailsVM({GetStockDetails getStockDetails})
      : _newAllStockDetailsVM = getStockDetails;

  String get u31Syskey {
    return _newAllStockDetailsVM.u31Syskey;
  }

  String get uomSyskey {
    return _newAllStockDetailsVM.uomSyskey;
  }

  String get barcode {
    return _newAllStockDetailsVM.barcode;
  }

  String get price {
    return _newAllStockDetailsVM.price;
  }

  String get uomType {
    return _newAllStockDetailsVM.uomType;
  }

  String get priceType {
    return _newAllStockDetailsVM.priceType;
  }

  String get ratio {
    return _newAllStockDetailsVM.ratio;
  }
}
