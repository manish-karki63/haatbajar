import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/deactivation/DeactivatePage.dart';
import 'package:haatbajar/ui/password/forgotPwdPage.dart';
import 'package:haatbajar/ui/profile/editmyprofile.dart';
import 'package:haatbajar/ui/setting/NotificationPage.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingPage extends StatefulWidget {
  @override
  State createState() => new SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  bool _invisible = false;
  bool isSwitched = false;
  bool status3 = true;
  final _userPasswordController = TextEditingController();
  final _newPassword = TextEditingController();
  final _newconfirmPassword = TextEditingController();
  SharedPreferences pref;
  var prefpass = "";
  ApiService service;

  @override
  void dispose() {
    _userPasswordController.dispose();
    _newPassword.dispose();
    _newconfirmPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordVisible1 = false;
    service = ApiService();
    getPref();
  }

  void getPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      prefpass = pref.getString("password");
    });
  }

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _togglenew() {
    setState(() {
      _passwordVisible1 = !_passwordVisible1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new EditBuyerProfilePage()));
              },
              child: ListTile(
                title: new Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            new Container(
              child: ExpansionTile(
                title: new Text(
                  "Change Your Password",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                children: <Widget>[
                  ListTile(
                    subtitle: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _userPasswordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        hintText: 'Current Password',
                        // Here is key idea
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _toggle();
                          },
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _newPassword,
                      obscureText: !_passwordVisible1,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: 'New Password',
                        // Here is key idea
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _togglenew();
                          },
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _newconfirmPassword,
                      obscureText: !_invisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
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
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(  
                                          builder: (context) =>
                                              new ForgotPwdPage()));
                                },
                                color: Colors.white,
                                elevation: 0,
                                child: new Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (_newPassword.text != "" &&
                                      _newPassword.text != null) {
                                    if (_newPassword.text.length <= 4) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Cannot be less than four characters",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.amber);
                                    } else if (_newconfirmPassword.text !=
                                        _newPassword.text) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Confirm password does not match",
                                          textColor: Colors.black,
                                          backgroundColor: Colors.amber);
                                    } else {
                                      service
                                          .changePass(
                                              _userPasswordController.text,
                                              _newconfirmPassword.text)
                                          .then(
                                        (value) {
                                          if (!value == true) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Failed to change Password",
                                                textColor: Colors.black,
                                                backgroundColor: Colors.amber);
                                          } else if (value == true) {
                                            Fluttertoast.showToast(
                                                msg: "Change Successfull",
                                                textColor: Colors.black,
                                                backgroundColor: Colors.amber);
                                            setState(() {
                                              clearToken(context);
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Something Wrong",
                                                textColor: Colors.black,
                                                backgroundColor: Colors.amber);
                                          }
                                        },
                                      );
                                    }
                                  }
                                },
                                color: Colors.white,
                                elevation: 2,
                                child: new Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeactivatePage()));
              },
              child: ListTile(
                title: new Text(
                  "Deactivate Account",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(),
            new GestureDetector(
              onTap: () {
                /*Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DeactivatePage()));*/
              },
              child: ListTile(
                title: new Text(
                  "Notifications",
                  style: TextStyle(color: Colors.black),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlutterSwitch(
                      showOnOff: true,
                      activeTextColor: Colors.black,
                      valueFontSize: 11,
                      inactiveTextColor: Colors.black,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      toggleColor: Colors.red,
                      value: status3,
                      onToggle: (val) {
                        setState(() {
                          status3 = val;
                          if (status3) {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Notifications()));
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
