import 'package:flutter/material.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/home/chipPagehome.dart';
import 'package:haatbajar/ui/home/homePageWidget.dart';
import 'package:haatbajar/ui/login/loginPage.dart';
import 'package:haatbajar/ui/products/addProduct.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePageContainer extends StatefulWidget {
  @override
  HomePageContainerState createState() => HomePageContainerState();
}

class HomePageContainerState extends State<HomePageContainer> {
  ApiService service;
  var token;
  void getValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      print(pref.getString("token"));
      setState(() {
        token = pref.getString("token");
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getValue();
    service = ApiService();
    //getValue();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: service.getHomePageData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(
                'Error Found ',
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              debugPrint(snapshot.data.newProduct.length.toString());
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          color: Colors.black87,
                          height: 272.0,
                        ),
                        ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset('lib/assets/HomeImg/dashain.jpg',
                              height: 260.0, fit: BoxFit.cover),
                        ),
                        RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'Nepal',
                            style: TextStyle(
                                fontSize: 75,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.3),
                                letterSpacing: 10.0),
                          ),
                        ),
                        Positioned(
                          top: 150.0,
                          left: 40.0,
                          child: Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Text('Welcome ',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent)),
                                Text('to',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(width: 10.0),
                              ]),
                              Text('Haatbajar',
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ],
                          ),
                        ),
                      ],
                    ),
                    ChipPageHome(),

                    subheading("Trending"),
                   HomePageWidget(product: snapshot.data.trendingProduct, length: snapshot.data.trendingProduct.length,token:token),

                    subheading("Product Near Me"),
                    HomePageWidget(product: snapshot.data.nearMeProduct, length: snapshot.data.nearMeProduct.length,token:token),

                    subheading("New Products"),
                   HomePageWidget(product: snapshot.data.newProduct, length: snapshot.data.newProduct.length,token:token),

                  ],
                ),
              );
            }
            return Container(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 3,
              ),
              alignment: Alignment.center,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(token==null){
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
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new LoginPage()));
                  },
                  width: 100,
                  color: Colors.lightBlue[900],
                )

              ],
            ).show();
          }else
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new AddProduct()));
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.red,
        elevation: 6.0,
      ),
    );
  }

  Widget subheading(String text){
    return Text(text,
        style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          /*color: Colors.white*/
        )
    );
  }
}