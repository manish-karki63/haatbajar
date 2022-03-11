import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/models/orderModel.dart';
import 'package:haatbajar/ui/ReviewAndRatings/ReviewAndRatings.dart';
import 'package:haatbajar/ui/products/productDetailBottomSheet.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderDetails extends StatefulWidget {
  final OrderModel order;
  OrderDetails({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  ApiService service;
  bool tappedYes = false;
  bool clicked = false;
  bool liked = false;
  var number = 3;
  final myController = TextEditingController();
  int pnumber = 0;
  double userratedvalue;
  String fetchedrating;
  @override
  void initState() {
    super.initState();
    service = ApiService();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      pnumber = widget.order.product.id;
    });
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: new AppBar(
        title: new Text("Order Details"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: FutureBuilder(
        future: service.getProductById(widget.order.product.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.black),
            );
          } else if (snapshot.hasData) {
            fetchedrating = snapshot.data.rating.toStringAsFixed(1);
            List<String> imagepath = snapshot.data.images;
            List<NetworkImage> images = List<NetworkImage>();
            for (var i = 0; i < imagepath.length; i++) {
              images.add(NetworkImage(
                  "http://rijalroshan.com.np:8082/" + imagepath[i]));
            }
            return ListView(
              padding: EdgeInsets.only(top: 0.0),
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  height: 270.0,
                  width: 355.0,
                  child: GridTile(
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: true,
                      animationCurve: Curves.fastLinearToSlowEaseIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 8.0,
                      dotIncreasedColor: Color(0xFFFF335C),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.topRight,
                      dotVerticalPadding: 2.0,
                      showIndicator: true,
                      indicatorBgPadding: 4.0,
                      images: images,
                    ),
                    footer: new Container(
                        height: 45,
                        color: Colors.white54,
                        child: ListTile(
                          title: new Row(
                            children: <Widget>[
                              new Text(snapshot.data.rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontFamily: 'Helvetica',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                              new SmoothStarRating(
                                isReadOnly: true,
                                size: 24,
                                starCount: 5,
                                borderColor: Colors.red,
                                color: Colors.red,
                                rating: double.parse(fetchedrating),
                              ),
                            ],
                          ),
                          trailing: new Text(
                              snapshot.data.views.toString() + " \u2764",
                              style: TextStyle(
                                fontFamily: 'Helvetica',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              )),
                        )),
                  ),
                ),
                new Container(
                  height: 40.0,
                  color: Colors.white,
                  child: ListTile(
                    leading: new Text(snapshot.data.title,
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        )),
                    title: new Text(
                        snapshot.data.quantity.toString() +
                            " " +
                            snapshot.data.metric,
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        )),
                    trailing: new Text("Rs. " + snapshot.data.price.toString(),
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        )),
                  ),
                ),
                ProductDetailButtomSheet(
                  context: context,
                  product: snapshot.data,
                ),
                new ListTile(
                  title: new Text("Product Description"),
                  subtitle: new Text(snapshot.data.description),
                ),
                Divider(),
                new Row(
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      leading: new Text(snapshot.data.category.categoryName),
                      trailing: new Text(snapshot.data.dateToDisplay),
                    )),
                  ],
                ),
                Divider(),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Message to seller",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new Text("Quantity Ordered : " +
                          widget.order.quantity.toString()),
                      new Text("Message : " + widget.order.message),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              leading: new Text(
                                "Reviews & Ratings",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ReviewAndRatingsUser(
                        clicked: clicked,
                        pnumber: snapshot.data.id,
                      ),
                    ],
                  ),
                ),
                clicked
                    ? Container(
                        height: 0,
                        width: 0,
                      )
                    : InkWell(
                        child: Container(
                          height: 42.0,
                          child: ListTile(
                            title: new Text(
                              "Load More Reviews & Ratings",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(
                              Icons.arrow_drop_down,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            clicked = true;
                          });
                          ReviewAndRatingsUser(
                            clicked: clicked,
                            pnumber: snapshot.data.id,
                          );
                        },
                        splashColor: Colors.red,
                      ),
                Divider(),
                ListTile(
                  leading: new Text("Rate Product: "),
                  title: new SmoothStarRating(
                    size: 36,
                    starCount: 5,
                    borderColor: Colors.red,
                    color: Colors.red,
                    onRated: (value) {
                      userratedvalue = value.toDouble();
                    },
                  ),
                ),
                ListTile(
                  leading: new Text("Review Product:"),
                  title: TextField(
                    autofocus: false,
                    controller: myController,
                    maxLength: 50,
                    maxLines: 2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write Your Review...',
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () async {
                            String Reviewofproduct = myController.text;
                            if ((Reviewofproduct == "" &&
                                userratedvalue == null)) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please write your review and rate the product",
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            } else if ((Reviewofproduct != "" &&
                                userratedvalue == null)) {
                              Fluttertoast.showToast(
                                  msg: "Please rate the product",
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            } else if ((Reviewofproduct == "" &&
                                userratedvalue != null)) {
                              Fluttertoast.showToast(
                                  msg: "Please review the product",
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            } else {
                              service
                                  .reviewProduct(snapshot.data.id,
                                      Reviewofproduct, userratedvalue)
                                  .then(
                                (value) {
                                  if (!value == true) {
                                    Fluttertoast.showToast(
                                        msg: "Failed to Rate and Review",
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Thank you for a review",
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                    setState(() {
                                      clicked = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                  }
                                },
                              );
                            }
                          },
                          color: Colors.red,
                          elevation: 0.2,
                          child: new Text(
                            "Submit",
                            style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         new MaterialPageRoute(
      //             builder: (context) => new OrderPage(
      //                   productid: widget.product.id,
      //                   sellerId: widget.product.sellerId,
      //                 )));
      //   },
      //   child: Icon(
      //     Icons.question_answer,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.red,
      // ),
    );
  }
}
