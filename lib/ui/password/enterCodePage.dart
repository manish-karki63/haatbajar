import 'package:flutter/material.dart';
import 'package:haatbajar/ui/password/changePassword.dart';

class EnterCodePage extends StatefulWidget {
  final email;
  EnterCodePage({Key key, @required this.email}) : super(key: key);
  @override
  State createState() => new EnterCodePageState();
}

class EnterCodePageState extends State<EnterCodePage> {
  TextEditingController otpcontroller = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    otpcontroller.dispose();
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
        title: Text('Enter Code'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
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
            Text(
              'Please check your email with your code.',
              style: TextStyle(
                  fontFamily: 'Oswald', fontSize: 18.0, color: Colors.black),
            ),
            Container(
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.white60,
                          child: new TextFormField(
                            controller: otpcontroller,
                            decoration: new InputDecoration(
                                labelText: "Enter Your Code..",
                                labelStyle: TextStyle(
                                    color: myFocusNode.hasFocus
                                        ? Colors.lightBlue[900]
                                        : Colors.black)),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(20.0)),
                  Text(
                    'We send your code to : ' + widget.email,
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                  Padding(padding: const EdgeInsets.all(30.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.red,
                        textColor: Colors.white,
                        child: new Text("Cancel"),
                        onPressed: () => {
                          Navigator.of(context).pop(context),
                        },
                        splashColor: Colors.lightBlue[900],
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(8.0)),
                  Row(
                    children: <Widget>[
                      new MaterialButton(
                        height: 40,
                        minWidth: 100,
                        color: Colors.lightBlue[900],
                        textColor: Colors.white,
                        child: new Text("Continue"),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ChangePasswordPage(
                                        otp: otpcontroller.text,
                                      )))
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
