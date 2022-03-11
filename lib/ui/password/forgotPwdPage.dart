import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/password/enterCodePage.dart';
//import 'main.dart';

class ForgotPwdPage extends StatefulWidget {
  @override
  State createState() => new ForgotPwdPageState();
}

class ForgotPwdPageState extends State<ForgotPwdPage> {
  TextEditingController emailController = TextEditingController();
  ApiService service;
  FocusNode myFocusNode = new FocusNode();
  String useremail;

  @override
  void initState() {
    super.initState();
    service = ApiService();
  }

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize:20.0,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        title: Text('Forgot password'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(20.0)),
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  new Form(
                    child: new Theme(
                      data: new ThemeData(
                          primaryColor: Colors.lightBlue[900],
                          accentColor: Colors.red,
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                  color: Colors.black, fontSize: 20.0))),
                      child: new TextFormField(
                        controller: emailController,
                        decoration: new InputDecoration(
                            labelText: "Enter your email address",
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Colors.lightBlue[900]
                                    : Colors.black)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  Text(
                    'We will send code in your email.',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 18.0,
                      // color: Colors.white
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.lightBlue[900],
                        textColor: Colors.white,
                        child: new Text("Continue"),
                        onPressed: () async {
                          useremail = emailController.text;
                          service.forgetPassword(useremail).then(
                            (value) {
                              if (!value == true) {
                                Fluttertoast.showToast(
                                    msg: "Unsucessfull",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "successfull",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red);
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new EnterCodePage(
                                              email: useremail,
                                            )));
                              }
                            },
                          );
                        },
                        splashColor: Colors.redAccent,
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(8.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.red,
                        textColor: Colors.white,
                        child: new Text("Not You ?"),
                        onPressed: () => {
                          Navigator.pop(context),
                        },
                        splashColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
