import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;

class CheckinShop extends StatefulWidget {
  @override
  _CheckinShopState createState() => _CheckinShopState();
}

class _CheckinShopState extends State<CheckinShop> {
  ViewModelFunction model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(width: 70, child: Text("Shop")),
                  Container(width: 20, child: Text("-")),
                  Text(model.activeShop.shopname,
                      style: Style.secondBoldTextStyle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(width: 70, child: Text("Phone")),
                  Container(width: 20, child: Text("-")),
                  Text(
                    model.activeShop.personph,
                    style: Style.secondBoldTextStyle,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 70, child: Text("Address")),
                Container(width: 20, child: Text("-")),
                Flexible(
                    child: Text("${model.activeShop.address}\r\n",
                        style: Style.secondBoldTextStyle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
