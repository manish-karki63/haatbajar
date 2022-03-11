import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/products/order/received/orderWidget.dart';

class ReceivedOrders extends StatefulWidget {
  @override
  _ReceivedOrdersState createState() => _ReceivedOrdersState();
}

class _ReceivedOrdersState extends State<ReceivedOrders> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Orders Received");
  ApiService service;
  @override
  void initState() {
    super.initState();
    service = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: FutureBuilder(
          future: service.receivedOrders(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Error Found",
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              return new ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print("List layout");
                  return new Container(
                    child: Card(
                      margin: EdgeInsets.all(5.0),
                      color: Colors.grey[200],
                      child: OrderWidget(order: snapshot.data[index]),
                    ),
                  );
                },
              );
            } else if (!snapshot.hasData) {
              return Container(
                child: Text(
                  "no data found",
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Container(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 5,
              ),
              alignment: Alignment.center,
            );
          },
        ),
      ),
    );
  }
}
