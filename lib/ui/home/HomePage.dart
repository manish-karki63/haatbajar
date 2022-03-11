import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:haatbajar/ui/category/category.dart';
import 'package:haatbajar/ui/home/homePageContainer.dart';
import 'package:haatbajar/ui/login/loginPage.dart';
import 'package:haatbajar/ui/products/myProducts.dart';
import 'package:haatbajar/ui/products/order/sent/orderedProducts.dart';
import 'package:haatbajar/ui/products/order/received/receivedorders.dart';
import 'package:haatbajar/ui/products/productHistory.dart';
import 'package:haatbajar/ui/products/searchProduct.dart';
import 'package:haatbajar/ui/profile/myprofile.dart';
import 'package:haatbajar/ui/setting/setting.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strings/strings.dart';

class HomePage extends StatefulWidget {
  // final ProductModel _product;
  // HomePage(this._product);
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  String drawerSelected = "Home";
  String mainProfilePicture = "lib/assets/HomeImg/avatar00.png";
  String otherProfilePicture = "lib/assets/HomeImg/avatar01.png";
  int selectedBarIndex = 0;
  GlobalKey<ScaffoldState> _key;
  Widget currentPage = HomePageContainer();
  var token, userName, email;

  void switchUser() {
    String backupString = mainProfilePicture;
    this.setState(() {
      mainProfilePicture = otherProfilePicture;
      otherProfilePicture = backupString;
    });
  }

  void getValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      print(pref.getString("token"));
      setState(() {
        token = pref.getString("token");
        userName = pref.getString("userName");
        email = pref.getString("email");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedBarIndex = 0;
    getValue();
    getAddress();
    _key = GlobalKey<ScaffoldState>();
    //getValue();
  }

  @override
  Widget build(BuildContext context) {
    //var _drawerName =['Home','Sellup Store','Category','Location','Reviews','Wishlist','Product History','Setting','Logout'];
    // var _iconName =['home','shop','category','my_location','info','star_border','show_chart','settings','exit_to_app'];

    return new Scaffold(
      key: _key,
      appBar: new AppBar(
        title: new Text(drawerSelected),
        backgroundColor: Colors.lightBlue[900],
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchProductWidget(token: token),
              );
            },
          ),
        ],
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
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.height / 2.3,
        child: Drawer(
          child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              token != null
                  ? new UserAccountsDrawerHeader(
                      accountName: new Text(userName != null
                          ? capitalize(userName)
                          : "Profile Name"),
                      accountEmail: new Text(email != null
                          ? capitalize(email)
                          : "Profilename@gmail.com"),
                      currentAccountPicture: new GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new BuyerProfile())),
                        },
                        child: new CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: ExactAssetImage(mainProfilePicture),
                        ),
                      ),
                      otherAccountsPictures: <Widget>[
                        new GestureDetector(
                          onTap: () => switchUser(),
                          child: new CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                ExactAssetImage(otherProfilePicture),
                          ),
                        ),
                      ],
                      decoration: new BoxDecoration(
                        /*image: new DecorationImage(
                  // image: ExactAssetImage('lib/assets/HomeImg/table.jpg'),
                  fit: BoxFit.cover,
                ),*/
                        color: Colors.lightBlue[900],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 30.0),
                    ),
              new ListTile(
                title: new Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                ),
                leading: new Icon(Icons.home, color: Colors.black),
                onTap: () {
                  setState(() {
                    drawerSelected = "Home";
                    Navigator.pop(context);
                    currentPage = HomePageContainer();
                  });
                },
              ),
              new ListTile(
                title: new Text("Category"),
                leading: new Icon(Icons.category, color: Colors.black),
                onTap: () {
                  setState(() {
                    drawerSelected = "Category";
                    Navigator.pop(context);
                    currentPage = CategoryPage();
                  });
                },
              ),
              token != null
                  ? new ListTile(
                      title: new Text("My Product"),
                      leading:
                          new Icon(Icons.shopping_cart, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new MyProducts()));
                      },
                    )
                  : Container(),
              token != null
                  ? new ListTile(
                      title: new Text("Product History"),
                      leading: new Icon(Icons.show_chart, color: Colors.black),
                      onTap: () {
                        setState(() {
                          drawerSelected = "Product History";
                          Navigator.pop(context);
                          currentPage = ProductHistoryPage();
                        });
                      },
                    )
                  : Container(),
              token != null
                  ? new ListTile(
                      title: new Text("Ordered Products"),
                      leading: new Icon(Icons.show_chart, color: Colors.black),
                      onTap: () {
                        setState(() {
                          drawerSelected = "Ordered Products";
                          Navigator.pop(context);
                          currentPage = OrderedProducts();
                        });
                      },
                    )
                  : Container(),
              token != null
                  ? new ListTile(
                      title: new Text("Orders Received"),
                      leading: new Icon(Icons.show_chart, color: Colors.black),
                      onTap: () {
                        setState(() {
                          drawerSelected = "Orders Received";
                          Navigator.pop(context);
                          currentPage = ReceivedOrders();
                        });
                      },
                    )
                  : Container(),
              token != null
                  ? new ListTile(
                      title: new Text("Setting"),
                      leading: new Icon(Icons.settings, color: Colors.black),
                      onTap: () {
                        setState(() {
                          drawerSelected = "Setting";
                          Navigator.pop(context);
                          currentPage = SettingPage();
                        });
                      },
                    )
                  : Container(),
              token != null
                  ? new ListTile(
                      title: new Text("My Profile"),
                      leading:
                          new Icon(Icons.person_outline, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new BuyerProfile()));
                      },
                    )
                  : Container(),
              token != null
                  ? new ListTile(
                      title: new Text("Logout"),
                      leading: new Icon(Icons.exit_to_app, color: Colors.black),
                      onTap: () {
                        setState(() {
                          drawerSelected = "Logout";
                          clearToken(context);
                        });
                      },
                    )
                  : new ListTile(
                      title: new Text("Login"),
                      leading: new Icon(Icons.exit_to_app, color: Colors.black),
                      onTap: () {
                        setState(() {
                          drawerSelected = "Login";
                        });
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new LoginPage()));
                      },
                    ),
            ],
          ),
        ),
      ),
      body: currentPage,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.lightBlue[900],
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.white,
        height: 50,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: 0,
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 28,
            color: Colors.white,
          ),
          Icon(Icons.show_chart, size: 28, color: Colors.white),
          Icon(Icons.category, size: 28, color: Colors.white),
          Icon(Icons.settings, size: 28, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            selectedBarIndex = index;
            if (index == 0) {
              drawerSelected = "Home";
              currentPage = HomePageContainer();
            } else if (index == 1) {
              drawerSelected = "Product History";
              currentPage = token != null
                  ? ProductHistoryPage()
                  : Alert(
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
            } else if (index == 2) {
              drawerSelected = "Category";
              currentPage = CategoryPage();
            } else if (index == 3) {
              drawerSelected = "Setting";
              currentPage = token != null
                  ? SettingPage()
                  : Alert(
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
            }
          });
        },
      ),
    );
  }
}

void clearToken(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref);
  pref.setString('token', null);
  pref.setInt("userId", null);
  pref.setString("email", null);
  pref.setString("profile", null);
  pref.setString("userName", null);
  pref.setString("countryCode", null);

  Navigator.pop(context);
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => new LoginPage()));
}
