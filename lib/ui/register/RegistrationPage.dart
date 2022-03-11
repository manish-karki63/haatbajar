import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State createState() => new RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  File _image;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController countrycodeController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Country _selected = Country.NP;
  ApiService service;
  @override
  void initState() {
    super.initState();
    service = ApiService();
  }

  void openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.lightBlue[900],
          textTheme: TextTheme(
              title: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          )),
          centerTitle: true,
          title: new Text("Haatbajar"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  /*new Image(
              image: new AssetImage("lib/assets/login/login2.jpg"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),*/
                  SingleChildScrollView(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Form(
                          key: _formKey,
                          child: new Theme(
                            data: new ThemeData(
                                primaryColor: Colors.lightBlue[900],
                                accentColor: Colors.red,
                                inputDecorationTheme: new InputDecorationTheme(
                                    labelStyle: new TextStyle(
                                        color: Colors.black, fontSize: 20.0))),
                            child: new Container(
                              padding: const EdgeInsets.all(10.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new Text(
                                    "Create Your Profile",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 30.0)),
                                  new TextFormField(
                                    controller: firstnameController,
                                    decoration: new InputDecoration(
                                        icon: Icon(Icons.person),
                                        labelText: "Enter First Name",
                                        labelStyle: TextStyle(
                                            color: myFocusNode.hasFocus
                                                ? Colors.lightBlue[900]
                                                : Colors.black)),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Some Text';
                                      }
                                      return null;
                                    },
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new TextFormField(
                                    controller: lastnameController,
                                    decoration: new InputDecoration(
                                        icon: Icon(Icons.person),
                                        labelText: "Enter Last name",
                                        labelStyle: TextStyle(
                                            color: myFocusNode.hasFocus
                                                ? Colors.lightBlue[900]
                                                : Colors.black)),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Some Text';
                                      }
                                      return null;
                                    },
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new TextFormField(
                                    controller: emailController,
                                    decoration: new InputDecoration(
                                        icon: Icon(Icons.email),
                                        labelText: "Enter Email",
                                        labelStyle: TextStyle(
                                            color: myFocusNode.hasFocus
                                                ? Colors.lightBlue[900]
                                                : Colors.black)),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Some Text';
                                      }
                                      return null;
                                    },
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new TextFormField(
                                    controller: userController,
                                    decoration: new InputDecoration(
                                        icon: Icon(Icons.phone),
                                        labelText: "Enter Phone Number",
                                        labelStyle: TextStyle(
                                            color: myFocusNode.hasFocus
                                                ? Colors.lightBlue[900]
                                                : Colors.black)),
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Your Phone Number';
                                      } else if (value.length != 10) {
                                        return 'Please Enter 10 Digit Number';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.language),
                                            labelText: 'Select Country',
                                            labelStyle: TextStyle(
                                                color: myFocusNode.hasFocus
                                                    ? Colors.lightBlue[900]
                                                    : Colors.black)),
                                        child: CountryPicker(
                                          showDialingCode: true,
                                          nameTextStyle: TextStyle(
                                              // color: Colors.white,
                                              fontSize: 15.0,
                                              color: myFocusNode.hasFocus
                                                  ? Colors.lightBlue[900]
                                                  : Colors.black),
                                          onChanged: (Country country) {
                                            setState(() {
                                              _selected = country;
                                            });
                                          },
                                          selectedCountry: _selected,
                                        ),
                                      );
                                    },
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new TextFormField(
                                    controller: passwordController,
                                    decoration: new InputDecoration(
                                        icon: Icon(Icons.lock),
                                        labelText: "Enter Password",
                                        labelStyle: TextStyle(
                                            color: myFocusNode.hasFocus
                                                ? Colors.lightBlue[900]
                                                : Colors.black)),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Some Text';
                                      }
                                      return null;
                                    },
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 20.0)),
                                  new TextFormField(
                                    controller: confirmpasswordController,
                                    decoration: new InputDecoration(
                                        icon: Icon(Icons.lock),
                                        labelText: "Confirm Password",
                                        labelStyle: TextStyle(
                                            color: myFocusNode.hasFocus
                                                ? Colors.lightBlue[900]
                                                : Colors.black)),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Enter Some Text';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(padding: const EdgeInsets.all(10.0)),
                                  Text(
                                    "Add your profile picture",
                                    style: TextStyle(
                                      fontSize: 18,
                                      // color: Colors.white,
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.all(5.0)),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.transparent,
                                    child: _image == null
                                        ? Icon(Icons.add,
                                            color: Colors.lightBlue[900],
                                            size: 50)
                                        : Image.file(_image),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.white12,
                                        onPressed: () {
                                          openCamera();
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Take Picture ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Icon(Icons.add_a_photo,
                                                color: Colors.red),
                                          ],
                                        ),
                                      ),
                                      FlatButton(
                                        color: Colors.white12,
                                        onPressed: () {
                                          openGallery();
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Open Gallery ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                /*color: Colors.white*/
                                              ),
                                            ),
                                            Icon(Icons.photo_library,
                                                color: Colors.red),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Padding(
                                      padding:
                                          const EdgeInsets.only(top: 30.0)),
                                  new MaterialButton(
                                    height: 40,
                                    minWidth: 100,
                                    color: Colors.lightBlue[900],
                                    textColor: Colors.white,
                                    child: new Text("Continue"),
                                    onPressed: () {
                                      String phonenumber = userController.text;
                                      String password = passwordController.text;
                                      String confirmPassword =
                                          confirmpasswordController.text;
                                      String firstName =
                                          firstnameController.text;
                                      String lastName = lastnameController.text;
                                      String email = emailController.text;
                                      String countryCode =
                                          _selected.dialingCode;
                                      print(_formKey.currentState.validate());
                                      if (_formKey.currentState.validate()) {
                                        Fluttertoast.showToast(
                                            msg: "Processing",
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Invalid Input",
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      }

                                      setState(() {
                                        isLoading = true;
                                      });
                                      ApiService()
                                          .register(
                                              phonenumber,
                                              firstName,
                                              lastName,
                                              email,
                                              countryCode,
                                              password,
                                              confirmPassword,
                                              _image)
                                          .then(
                                        (value) {
                                          print(value.data);
                                          if (!value.success) {
                                            Fluttertoast.showToast(
                                                msg: value.message,
                                                textColor: Colors.white,
                                                backgroundColor: Colors.red);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: value.message,
                                                textColor: Colors.white,
                                                backgroundColor: Colors.red);
                                            Navigator.pop(context);
                                          }
                                        },
                                      );
                                    },
                                    splashColor: Colors.redAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
