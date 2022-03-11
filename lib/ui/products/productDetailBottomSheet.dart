import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:haatbajar/ui/products/Constants.dart';
import 'package:haatbajar/ui/products/Delete/deleteAlart.dart';
import 'package:haatbajar/ui/products/editProduct.dart';
import 'package:haatbajar/ui/profile/userProfile.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailButtomSheet extends StatelessWidget {
  final BuildContext context;
  final Product product;
  ProductDetailButtomSheet({Key key, this.context, this.product})
      : super(key: key);

  ApiService service;
  @override
  Widget build(BuildContext context) {
    debugPrint("from bottom sheet page: "+product.title);
    final rating = product.seller.rating;
    service = ApiService();
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              onPressed: () {
                displayModalBottomSheet(context);
              },
              color: Colors.lightBlue[900],
              elevation: 2.0,
              child: new Text(
                "Know Seller \u25BC",
                style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          new IconButton(
              icon: Icon(Icons.favorite_border),
              color: Colors.red,
              iconSize: 30.0,
              onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  Widget displayModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 280.0,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: new Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Center(
                      // child: CircleAvatar(
                      //   radius: 45,
                      //   backgroundImage: NetworkImage(
                      //       "https://www.princefxea.com/wp-content/uploads/2017/10/robot-png-hd-300x225.png"),
                      // ),
                    ),
                  ),
                  ListTile(
                    title: Center(
                      child: new Text(
                        product.seller.firstName +
                            " " +
                            product.seller.lastName,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Center(
                      child: SmoothStarRating(
                        isReadOnly: true,
                        size: 24,
                        starCount: 5,
                        borderColor: Colors.red,
                        color: Colors.red,
                        rating: product.seller.rating!=null?product.seller.rating.toDouble():0.0,
                      ),
                    ),
                  ),
                  Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.phone),
                              color: Colors.lightBlue[900],
                              iconSize: 26.0,
                              onPressed: () {}),
                          new Text(product.seller.phoneNo,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.email),
                              color: Colors.lightBlue[900],
                              iconSize: 26.0,
                              onPressed: () {}),
                          new Text(product.seller.email,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.location_on),
                                  color: Colors.lightBlue[900],
                                  iconSize: 26.0,
                                  onPressed: () {}),
                              FutureBuilder<String>(
                                future: getsellerAddress(product.location.lat,
                                    product.location.long),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return Text(
                                        "Loading...",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.lightBlue[900],
                                        ),
                                      );
                                    default:
                                      if (snapshot.hasData) {
                                        print("after hasdata ${snapshot.data}");
                                        if (snapshot.data == null) {
                                          return new Text(
                                            "Unavailable",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.lightBlue[900],
                                            ),
                                          );
                                        } else
                                          return new Text(
                                            snapshot.data,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.lightBlue[900],
                                            ),
                                          );
                                      } else
                                        print(" ${snapshot.error}");
                                  }
                                },
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              MaterialButton(
                                color: Colors.lightBlue[900],
                                elevation: 0.2,
                                child: new Text(
                                  "Review & Rate Seller",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  debugPrint("From product detail buttom sheet "+product.seller.id.toString());
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => new UserProfile(
                                                id: product.seller.id,
                                              )));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void choiceAction(String choice) async {
    int userId = await getId();
    if (product.sellerId == userId) {
      if (choice == Constants.edit) {
        int abc = product.id;
        print(abc);
        print('Edit');
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new EditProduct(product: product)));
      } else {
        print("Delete");
        final action = await DeleteAlert.yesAbortDialog(
            context, "Are You Sure You want to delete this product");
        if (action == dialogAction.yes) {
          print("Yes");
          service
              .deleteProduct(
            product.id,
          )
              .then((value) {
            if (!value.success) {
              Fluttertoast.showToast(
                  msg: value.message,
                  textColor: Colors.black,
                  backgroundColor: Colors.amber);
            } else {
              Fluttertoast.showToast(
                  msg: "Deleted Successfully",
                  textColor: Colors.black,
                  backgroundColor: Colors.amber);
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new HomePage()));
            }
          });
        } else {
          print("No");
        }
      }
    } else {
      print(userId);
      if (choice == Constants.edit) {
        errorMessage("edit");
      } else {
        errorMessage("delete");
      }
    }
  }

  void errorMessage(String msg) {
    Fluttertoast.showToast(
        msg: "You are not authorize to ${msg} this product",
        textColor: Colors.white,
        backgroundColor: Colors.red);
    Navigator.pop(context);
  }
}
