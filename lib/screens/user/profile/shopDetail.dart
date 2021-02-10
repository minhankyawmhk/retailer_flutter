import 'package:flutter/material.dart';
import 'package:retailer/models/shopByListModel.dart';

class ShopDetailScreen extends StatefulWidget {
  final ShopByListM shopByListM;

  ShopDetailScreen(this.shopByListM);

  @override
  _ShopDetailScreenState createState() =>
      _ShopDetailScreenState(this.shopByListM);
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final ShopByListM shopByListM;

  _ShopDetailScreenState(this.shopByListM);

  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Detail'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            getTextLine('Name', shopByListM.shopname),
            getTextLine('Phone', shopByListM.phoneno),
            getTextLine('Code', shopByListM.shopcode),
            getTextLine('Adress', shopByListM.address),
            getTextLine('Latitude', "0.0"),
            getTextLine('Longitude', "0.0"),
          ],
        ),
      ),
    );
  }

  Widget getTextLine(String title, String value) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width * 0.25,
            child: Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              '-',
              style: TextStyle(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
                width: width * 0.6,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }
}
