import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/user/profile/shopDetail.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:retailer/style/theme.dart' as Style;

class UserShop extends StatefulWidget {
  @override
  _UserShopState createState() => _UserShopState();
}

class _UserShopState extends State<UserShop> {
  ViewModelFunction model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);
    return model.shopsByUser.isEmpty ? getnotfound() : getUserShopList();
  }

  Widget getnotfound() {
    var height =MediaQuery.of(context).size.height;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: height* .3),
        child: Center(
          child: Column(
            children: [
              ImageIcon(
                AssetImage('assets/icon/shop.png'),
                color: Colors.grey,
                size: 65,
              ),
              Container(height: 5),
              Text(
                'No Shop found !',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUserShopList() {
    return ListView.builder(
      itemBuilder: (context, index) => Container(
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset("assets/notfound.png"),
              ),
              title: Text(
                model.shopsByUser[index].shopname,
                style: Style.secondTextStyle,
              ),
              subtitle: Text(
                model.shopsByUser[index].phoneno,
                style: Style.secondTextStyle,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShopDetailScreen(model.shopsByUser[index])));
              },
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
      itemCount: model.shopsByUser.length,
    );
  }
}
