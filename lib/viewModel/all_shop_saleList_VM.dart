import 'package:retailer/models/all_shop_saleList.dart';
import 'package:retailer/models/shopByListModel.dart';

class AllShopViewModel {
  AllShopSaleList _allShopSaleList;

  AllShopViewModel({AllShopSaleList allShopSaleList})
      : _allShopSaleList = allShopSaleList;

  List<ShopByListM> get shopsByUser {
    return _allShopSaleList.shopsByUser;
  }

  List<ShopByListM> get shopsByTeam {
    return _allShopSaleList.shopsByTeam;
  }

  String get status {
    return _allShopSaleList.status;
  }

  String get cause {
    return _allShopSaleList.cause;
  }

  int get totalcount {
    return _allShopSaleList.totalcount;
  }
}
