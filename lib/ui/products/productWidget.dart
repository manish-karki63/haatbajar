import 'package:flutter/material.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/ui/login/loginPage.dart';
import 'package:haatbajar/ui/products/ProductDetail.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  var token;
  ProductWidget({Key key, this.product, this.token}) : super(key: key);
  int selectedProductIndex;
  var selectedProductName = "";
  var sellerName = "";
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red,
      onTap: () {
        if (token == null) {
          Alert(
            context: context,
            //type: AlertType.error,
            title: "Login Required",
            desc: "You need to login to perform this operation!!",
            buttons: [
              DialogButton(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new LoginPage()));
                },
                width: 100,
                color: Colors.lightBlue[900],
              )
            ],
          ).show();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(product: product)),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Text(
                  product.quantity.toString() + " " + product.metric,
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
          Image.network(
            "http://rijalroshan.com.np:8082/" + product.images[0],
            width: 170.0,
            height: 90.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Rs." + product.price.toString(),
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.visibility,
                        size: 17.0,
                        color: Colors.red,
                      ),
                      new Text(" " + product.views.toString()),
                    ])
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FutureBuilder<String>(
                    future: getDistance(
                        product.location.lat, product.location.long),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text("Loading...");
                        default:
                          if (snapshot.hasData) {
                            if (snapshot.data == null) {
                              return new Text("Unavailable");
                            } else
                              return new Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              );
                          } else
                            return new Text("Unavailable");
                        //return new LoginPage();
                      }
                    }),
                new Text(
                  product.dateToDisplay,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
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
