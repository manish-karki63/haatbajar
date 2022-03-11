import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/products/myProducts.dart';
import 'package:haatbajar/ui/profile/userWidget.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:strings/strings.dart';
import 'editmyprofile.dart';

class BuyerProfile extends StatefulWidget {
  @override
  State createState() => new BuyerProfileState();
}

class BuyerProfileState extends State<BuyerProfile> {
  ApiService service;
  SharedPreferences pref;
  var name = "", phone = "", email = "", joinDate = "";
  var address = "";

  void getPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      var join;
      name = pref.getString("userName");
      phone = pref.getString("phone");
      email = pref.getString("email");
      address = pref.getString('address') != null
          ? pref.getString('address')
          : "Location";
      print("i am from address " + address);
      join = pref.getString("joinDate");
      joinDate = "Since: " /*+ join.substring(0,10)*/;
    });
  }

  @override
  void initState() {
    super.initState();
    service = ApiService();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.lightBlue[900],
      body: FutureBuilder(
        future: service.getMyProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          print(snapshot.error);
          if (snapshot.hasError) {
            print("Error");
            return Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.black),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.lightBlue[900],
                              child: ClipOval(
                                child: Image.network(
                                  "http://rijalroshan.com.np:8082/" +
                                      snapshot.data.profilePicture,
                                  height: 120,
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: Container(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new EditBuyerProfilePage()));
                                  },
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            capitalize(snapshot.data.firstName +
                                " " +
                                snapshot.data.lastName),
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
                            rating: 4.2,
                            borderColor: Colors.red,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        //color: Colors.lightBlue[900],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.lightBlue[900],
                            Color.fromRGBO(220, 0, 40, 1)
                          ],
                        ),
                      ),*/
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      ),
                      UserWidget(value: phone, iconValue: Icons.phone),
                      UserWidget(value: email, iconValue: Icons.email),
                      UserWidget(
                          value: "Location", iconValue: Icons.location_on),
                      _userDetailWithButton(
                          "My Products", Icons.shopping_cart, 0),
                      _userDetailWithButton(
                          "Invite Friends", Icons.person_add, 1),
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.email),
        backgroundColor: Colors.red,
      ),*/
    );
  }

  Widget _userDetailWithButton(String value, iconValue, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new MyProducts()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
        child: Container(
          height: 60,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        iconValue,
                        color: Colors.lightBlue[900],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue[900],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            border: Border.all(
              width: 1.0,
              color: Colors.lightBlue[900],
            ),
          ),
        ),
      ),
    );
  }
}
