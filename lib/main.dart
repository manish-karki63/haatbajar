import 'package:flutter/material.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:haatbajar/ui/splashPage/splashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
        theme: new ThemeData(primarySwatch: Colors.blue));
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Future<SharedPreferences> preference = SharedPreferences.getInstance();
  Future<String> token;
  void initState() {
    super.initState();
    token = preference.then((SharedPreferences prefs) {
      return (prefs.getString('token'));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
            body: FutureBuilder<String>(
                future: token,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      return HomePage();
                        //return new LoginPage();
                  }
                }));
  }
}


