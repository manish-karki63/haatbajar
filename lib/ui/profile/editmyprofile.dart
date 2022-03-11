import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:haatbajar/ui/profile/myprofile.dart';
import 'package:haatbajar/utilities/utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditBuyerProfilePage extends StatefulWidget {
  @override
  State createState() => new EditBuyerProfilePageState();
}

class EditBuyerProfilePageState extends State<EditBuyerProfilePage> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = new FocusNode();
  TextEditingController _firstNameController,
      _lastNameController,
      _emailController;
  TextEditingController _phoneController, _contryCodeController;
  Country _selected;
  bool isLoading = false;
  ApiService service;
  SharedPreferences pref;
  var firstName = "",
      lastName = "",
      email = "",
      phone = "",
      countryCode = "",
      userName = "";

  @override
  void initState() {
    super.initState();
    service = ApiService();
    getPref();
    print(email);
  }

  void setValue() {
    setState(() {
      print(email);
      print(userName);
      if (userName.length == 0) {
        return;
      }
      var value = userName.split(" ");
      print(value.length);
      firstName = value[0];
      lastName = value[1];
      _firstNameController = TextEditingController(text: firstName);
      _lastNameController = TextEditingController(text: lastName);
      _emailController = TextEditingController(text: email);
      _phoneController = TextEditingController(text: phone);
      _contryCodeController = TextEditingController(text: countryCode);
    });
  }

  void getPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString("userName");
      email = pref.getString('email');
      print(email);
      phone = pref.getString('phone');
      countryCode = pref.getString('countryCode');
    });
    setValue();
  }

  void open_camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void open_gallery() async {
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text('Edit Profile'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 110,
                                width: 110,
                                child: new CircleAvatar(
                                  radius: 70.0,
                                  backgroundColor: Colors.lightBlue[900],
                                  backgroundImage: _image == null
                                      ? ExactAssetImage(
                                          'lib/assets/HomeImg/avatar00.png')
                                      : FileImage(_image),
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
                                      _onButtonPressed();
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
                        ),
                      ],
                    ),
                  ),
                  new Column(
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
                                      color: Colors.lightBlue[900],
                                      fontSize: 20.0))),
                          child: new Container(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: <Widget>[
                                new TextFormField(
                                  style:
                                      TextStyle(color: Colors.lightBlue[900]),
                                  controller: _firstNameController,
                                  decoration: new InputDecoration(
                                      icon: Icon(Icons.person,
                                          color: Colors.lightBlue[900]),
                                      labelText: "First Name",
                                      labelStyle: TextStyle(
                                          color: Colors.lightBlue[900])),
                                  keyboardType: TextInputType.text,
                                ),
                                new TextFormField(
                                  style:
                                      TextStyle(color: Colors.lightBlue[900]),
                                  controller: _lastNameController,
                                  decoration: new InputDecoration(
                                      icon: Icon(Icons.person,
                                          color: Colors.lightBlue[900]),
                                      labelText: "Last Name",
                                      labelStyle: TextStyle(
                                          color: Colors.lightBlue[900])),
                                  keyboardType: TextInputType.text,
                                ),
                                new TextFormField(
                                  style:
                                      TextStyle(color: Colors.lightBlue[900]),
                                  controller: _contryCodeController,
                                  decoration: new InputDecoration(
                                      icon: Icon(Icons.language,
                                          color: Colors.lightBlue[900]),
                                      labelText: "Country Code",
                                      labelStyle: TextStyle(
                                          color: Colors.lightBlue[900])),
                                  readOnly: true,
                                  onTap: () {
                                    _countryCodePicker();
                                  },
                                ),
                                new TextFormField(
                                  style:
                                      TextStyle(color: Colors.lightBlue[900]),
                                  controller: _phoneController,
                                  decoration: new InputDecoration(
                                      icon: Icon(Icons.phone,
                                          color: Colors.lightBlue[900]),
                                      labelText: "Contact Number",
                                      labelStyle: TextStyle(
                                          color: Colors.lightBlue[900])),
                                  keyboardType: TextInputType.number,
                                ),
                                new TextFormField(
                                  style:
                                      TextStyle(color: Colors.lightBlue[900]),
                                  controller: _emailController,
                                  decoration: new InputDecoration(
                                      icon: Icon(Icons.email,
                                          color: Colors.lightBlue[900]),
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                          color: Colors.lightBlue[900])),
                                  keyboardType: TextInputType.text,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                new MaterialButton(
                                  height: 40,
                                  minWidth: 100,
                                  color: Colors.lightBlue[900],
                                  textColor: Colors.white,
                                  child: Text(
                                    "Confirm Edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    String firstName =
                                        _firstNameController.text;
                                    String lastName = _lastNameController.text;
                                    String email = _emailController.text;
                                    String phone = _phoneController.text;
                                    String countryCode =
                                        _contryCodeController.text;

                                    setState(() {
                                      isLoading = true;
                                    });

                                    service
                                        .editUser(firstName, lastName, phone,
                                            email, countryCode, _image)
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
                                        } else
                                          Fluttertoast.showToast(
                                              msg: value.message,
                                              textColor: Colors.white,
                                              backgroundColor: Colors.red);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.black,
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.add_a_photo,
                        color: Colors.red,
                      ),
                      title: Text(
                        "Open Camera",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      onTap: () {
                        open_camera();
                        Navigator.pop(context);
                      }),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Open Gallery",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    onTap: () {
                      open_gallery();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _countryCodePicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.black,
            height: 120,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
              child: new FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      icon: Icon(Icons.language),
                      labelText: 'Select Country',
                    ),
                    child: CountryPicker(
                      showDialingCode: true,
                      nameTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                      onChanged: (Country country) {
                        setState(() {
                          _selected = country;
                          countryCode = "+" + _selected.dialingCode;
                          _contryCodeController =
                              TextEditingController(text: countryCode);
                          Navigator.pop(context);
                        });
                      },
                      selectedCountry: _selected,
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
