import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';

class OrderPage extends StatefulWidget {
  final int productid;
  final int sellerId;
  OrderPage({Key key, @required this.productid, @required this.sellerId})
      : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController itemnameController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  TextEditingController quantityController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  ApiService service;

  @override
  void initState() {
    super.initState();
    service = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: new Text("Order a Product"),
         backgroundColor: Colors.lightBlue[900],
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize:20.0,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body:  isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          :  new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /*new Image(
            image: new AssetImage("lib/assets/login/login2.jpg"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ),*/
          SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Form(
                  child: new Theme(
                    data: new ThemeData(
                        primaryColor: Colors.lightBlue[900],
                        accentColor: Colors.red,
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
                              labelText: "Item Quantity",
                                labelStyle: TextStyle(
                                    color: Colors.lightBlue[900])
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 20.0)),
                          new TextFormField(
                            controller: messageController,
                            decoration: new InputDecoration(
                              labelText: "Message",
                                labelStyle: TextStyle(
                                    color: Colors.lightBlue[900]
                                        )
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 30.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new MaterialButton(
                                  height: 40,
                                  minWidth: 100,
                                  color: Colors.lightBlue[900],
                                  textColor: Colors.white,
                                  child: new Text("order now"),
                                  onPressed: () async {
                                    String message = messageController.text;
                                    int quantity =
                                    int.parse(quantityController.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    service
                                        .orderProduct(widget.productid,
                                        widget.sellerId, quantity, message)
                                        .then(
                                          (value) {
                                        if (!value == true) {
                                          Fluttertoast.showToast(
                                              msg: "failed to order product ",
                                              textColor: Colors.black,
                                              backgroundColor: Colors.amber);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "order successfully",
                                              textColor: Colors.black,
                                              backgroundColor: Colors.amber);
                                          Navigator.pop(context);
                                        }
                                      },
                                    );
                                  }),
                            ],
                          ),
                          Padding(padding: const EdgeInsets.all(8.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new MaterialButton(
                                height: 40,
                                minWidth: 100,
                                color: Colors.redAccent,
                                textColor: Colors.white,
                                child: new Text("Cancel"),
                                onPressed: () => {
                                  Navigator.pop(context),
                                },
                                splashColor: Colors.redAccent,
                              ),
                            ],
                          ),
                          /**/
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
