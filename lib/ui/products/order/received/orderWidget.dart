import 'package:flutter/material.dart';
import 'package:haatbajar/models/orderModel.dart';
import 'package:haatbajar/ui/products/order/received/orderdetails.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  OrderWidget({Key key, this.order}) : super(key: key);
  int selectedProductIndex;
  var selectedProductName = "";
  var sellername = "";
  @override
  Widget build(BuildContext context) {
    if (order == null) {
      print("Hello Product Not Found");
      return Container(
        child: new Center(
          child: Text("No Data Found"),
        ),
      );
    } else {
      if (order.productId != null) {
        sellername = order.buyer.firstName;
      } else {
        sellername = "N/A";
      }

      return InkWell(
        splashColor: Colors.teal,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderDetails(order: order)),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new CircleAvatar(
                      radius: 20,
                      child: Image.asset("lib/assets/HomeImg/avatar00.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    new Text(
                      sellername,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    order.product.title,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    order.product.price.toString() +
                        " per " +
                        order.product.metric,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
