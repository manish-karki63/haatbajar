import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';

class EditOrderPage extends StatefulWidget {
  final int productid;
  final int sellerId;
  EditOrderPage({Key key, @required this.productid, @required this.sellerId})
      : super(key: key);

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  TextEditingController itemnameController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  ApiService service;

  @override
  void initState() {
    super.initState();
    service = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Edit a Order"),
      ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("lib/assets/login/login2.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Form(
                  child: new Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.teal, fontSize: 20.0))),
                    child: new Container(
                      padding: const EdgeInsets.all(20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(top: 50.0)),
                          new Padding(
                              padding: const EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: quantityController,
                            decoration: new InputDecoration(
                              labelText: "item quantity",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: messageController,
                            decoration: new InputDecoration(
                              labelText: "message",
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 30.0)),
                          new MaterialButton(
                              height: 40,
                              minWidth: 100,
                              color: Colors.teal,
                              textColor: Colors.white,
                              child: new Text("order now"),
                              onPressed: () async {
                                String message = messageController.text;
                                int quantity =
                                int.parse(quantityController.text);
                                service
                                    .orderProduct(widget.productid,
                                    widget.sellerId, quantity, message)
                                    .then(
                                      (value) {
                                    if (!value == true) {
                                      Fluttertoast.showToast(
                                          msg: "failed to edit order",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.amber);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "order edited successfully",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.amber);
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              }),
                        ],
                      ),
                    ),
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
