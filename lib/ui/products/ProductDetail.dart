import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/models/productModel.dart';
import 'package:haatbajar/ui/ReviewAndRatings/ReviewAndRatings.dart';
import 'package:haatbajar/ui/products/order/orderPage.dart';
import 'package:haatbajar/ui/products/productDetailBottomSheet.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({Key key, this.product}) : super(key: key);
  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  ApiService service;
  bool tappedYes = false;
  bool clicked = false;
  bool liked = false;
  var number = 3;
  final myController = TextEditingController();
  int pnumber = 0;
  double userratedvalue;
  String fetchedrating;
  double lat, long;
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
      pnumber = widget.product.id;
    });
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        )),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text("Product Details"),
      ),
      body: FutureBuilder(
        future: service.getProductById(widget.product.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.black),
            );
          } else if (snapshot.hasData) {
            fetchedrating = snapshot.data.rating.toStringAsFixed(1);
            /*void setPref() async{
                SharedPreferences preference = await SharedPreferences.getInstance();
                await preference.setDouble("lat",lat);
                await preference.setDouble("long",long);
              }
              setPref();*/
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
                  height:
                      (MediaQuery.of(context).size.height - kToolbarHeight) /
                          2.7,
                  width: MediaQuery.of(context).size.width,
                  child: GridTile(
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: true,
                      animationCurve: Curves.fastLinearToSlowEaseIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 8.0,
                      dotIncreasedColor: Colors.red,
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.topRight,
                      dotVerticalPadding: 2.0,
                      showIndicator: true,
                      indicatorBgPadding: 4.0,
                      images: images,
                    ),
                    footer: new Container(
                        height: MediaQuery.of(context).size.height / 13.5,
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
                              widget.product.views.toString() + " \u2764",
                              style: TextStyle(
                                fontFamily: 'oswald',
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
                    leading: new Text(widget.product.title,
                        style: TextStyle(
                          fontFamily: 'oswald',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        )),
                    title: new Text(
                        widget.product.quantity.toString() +
                            " " +
                            widget.product.metric,
                        style: TextStyle(
                          fontFamily: 'oswald',
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                        )),
                    trailing: new Text("Rs. " + widget.product.price.toString(),
                        style: TextStyle(
                          fontFamily: 'oswald',
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
                  subtitle: new Text(widget.product.description),
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
                        pnumber: widget.product.id,
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
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                            ),
                            trailing: Icon(
                              Icons.arrow_drop_down,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            clicked = true;
                            debugPrint(pnumber.toString());
                            debugPrint("Seller phone number: "+snapshot.data.seller.phoneNo);
                          });
                          ReviewAndRatingsUser(
                            clicked: clicked,
                            pnumber: widget.product.id,
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
                                  .reviewProduct(widget.product.id,
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
                          color: Colors.lightBlue[900],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new OrderPage(
                        productid: widget.product.id,
                        sellerId: widget.product.sellerId,
                      )));
        },
        child: Icon(
          Icons.question_answer,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
