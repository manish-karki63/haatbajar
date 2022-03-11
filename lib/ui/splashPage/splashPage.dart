import 'package:flutter/material.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:haatbajar/ui/introScreen/introScreenPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool value = false;

  @override
  void initState() {
    super.initState();
     getPref();
    _navigateToMain();
  }
  void getPref() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = await pref.getBool("introScreen")!=null?pref.getBool("introScreen"):false;
  }
  void _navigateToMain() async{
    await Future.delayed(Duration(seconds: 3),(){
      if(!value) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => IntroScreenPage(),
            )
        );
      } else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
           )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            width: 200.0,
            height: 100.0,
            child: Shimmer.fromColors(
              baseColor: Colors.lightBlue[900],
              highlightColor: Colors.red,
              child: Column(
                children: [
                  FlutterLogo(
                    size: 50,
                  ),
                  Text(
                    'Haatbajar',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black12,
                          offset: Offset.fromDirection(120, 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

