import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/profile/selleraddress.dart';
import 'package:haatbajar/ui/profile/userWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class UserProfile extends StatefulWidget {
  final int id;
  UserProfile({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ApiService service;
  final myController = TextEditingController();
  double userratedvalue;
  bool clicked = false;
  String Reviewofproduct;

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
        title: Text("Seller Profile"),
      ),
      body: FutureBuilder(
        future: service.getUserDetail(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.red),
            );
          } else if (snapshot.hasData) {
            debugPrint("UserProfile page rating value checking: " +snapshot.data.rating.toString());//--working
            debugPrint("UserProfile page id checking: " +
                widget.id.toString()); //--ok till here
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 70.0,
                              backgroundColor: Colors.lightBlue[900],
                              child: ClipOval(
                                child: Image.network(
                                  "http://rijalroshan.com.np:8082/api/" +
                                      snapshot.data.profilePicture,
                                  height: 120,
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            snapshot.data.firstName +
                                " " +
                                snapshot.data.lastName,
                            style: TextStyle(
                              color: Colors.lightBlue[900],
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: new SmoothStarRating(
                            isReadOnly: true,
                            size: 24,
                            starCount: 5,
                            borderColor: Colors.red,
                            color: Colors.red,
                            rating: snapshot.data.rating,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                          ),
                          UserWidget(
                              value: snapshot.data.phoneNo,
                              iconValue: Icons.phone),
                          UserWidget(
                              value: snapshot.data.email,
                              iconValue: Icons.email),
                          SellerAddress(
                            lat: snapshot.data.location.lat,
                            long: snapshot.data.location.long,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        //color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: new Text("Rate User: ",
                                  style: TextStyle(
                                    color: Colors.lightBlue[900],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,

                                  )),
                              title: new SmoothStarRating(
                                size: 32,
                                starCount: 5,
                                borderColor: Colors.red,
                                color: Colors.red,
                                onRated: (value) {
                                  userratedvalue = value.toDouble();
                                  debugPrint(userratedvalue
                                      .toString()); //------ok till here
                                },
                              ),
                            ),
                            ListTile(
                              leading: new Text("Review User:",
                                  style: TextStyle(
                                    color: Colors.lightBlue[900],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  )),
                              title: TextField(
                                autofocus: false,
                                controller: myController,
                                maxLength: 50,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  hintText: 'Write Your Review...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.lightBlue[900],
                                    ),
                                  ),
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
                                        String Reviewofproduct = myController
                                            .text;
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
                                              .reviewSeller(
                                              snapshot.data.id, Reviewofproduct,
                                              userratedvalue)
                                              .then(
                                                (value) {
                                              if (value == true) {
                                                Fluttertoast.showToast(
                                                    msg: "Thank you for a review",
                                                    textColor: Colors.white,
                                                    backgroundColor: Colors
                                                        .red);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Failed to Rate and Review",
                                                    textColor: Colors.white,
                                                    backgroundColor: Colors
                                                        .red);
                                                setState(() {
                                                  clicked = false;
                                                });
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (
                                                            BuildContext context) =>
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
                        ),
                      )
                    ],
                  ),
                ],
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
    );
  }
}
