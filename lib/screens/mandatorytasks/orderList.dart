import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:retailer/screens/mandatorytasks/orderLIst_detail.dart';
import 'package:retailer/screens/components/checkin-shop.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String currentTime = DateFormat("dd/MM/yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: Column(
        children: [
          CheckinShop(),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Card(
                  color: Colors.red[50],
                  child: ListTile(
                    title: Text("202020020030430"),
                    trailing: Container(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("$currentTime"),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 24,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderListDetailScreen()));
                    },
                  ),
                ),
              ),
              itemCount: 15,
            ),
          )
        ],
      ),
    );
  }
}
