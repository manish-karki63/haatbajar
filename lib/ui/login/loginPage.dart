import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/home/HomePage.dart';
import 'package:haatbajar/ui/password/forgotPwdPage.dart';
import 'package:haatbajar/ui/register/RegistrationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  bool rememberpwd = false;
  bool isLoading = false;
  ApiService service;
  FocusNode myFocusNode = new FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _phone = '', _password='';
  bool _showPassword = false;

  void rememberpwdChange(bool value) => setState(() => rememberpwd = value);

  @override
  void initState() {
    updateUser();
    super.initState();
    service = ApiService();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    passwordController.dispose();
  }

  void saveUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = userController.text;
    String password = passwordController.text;
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);
    print('Successful');
    print(phone);
    print(prefs.getString('phone'));
  }

  void updateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phone = (prefs.getString('phone'));
    _password = (prefs.getString('password'));
    print(_phone);
    setState(() {
      userController.text = _phone;
      passwordController.text = _password;
      if(_phone != ''){
        rememberpwd = true;
      } else
        rememberpwd = false;
    });
  }

  void removeUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', '');
    await prefs.setString('password', '');
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.only(top: 50.0)),
                new FlutterLogo(
                  size: _iconAnimation.value * 100,
                ),
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
                      padding: const EdgeInsets.all(20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(top: 50.0)),
                          new TextFormField(
                            controller: userController,
                            decoration: new InputDecoration(
                                icon: Icon(Icons.phone,/*color: Colors.white*/),
                                labelText: "Enter Phone Number",
                                labelStyle: TextStyle(
                                    color: myFocusNode.hasFocus ? Colors.lightBlue[900]: Colors.black
                                )
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Phone Number';
                              } else if(value.length != 10){
                                return 'Please Enter 10 digit Number';
                              }else {
                                return null;
                              }
                            },
                          ),
                          new TextFormField(
                            controller: passwordController,
                            decoration: new InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: "Enter Password",
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus ? Colors.lightBlue[900]: Colors.black
                              ),
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                  _showPassword ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: !_showPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Some Text';
                              }
                              return null;
                            },
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 5.0)),
                          new CheckboxListTile(
                            value: rememberpwd,
                            onChanged: rememberpwdChange,
                            title: new Text('Remember Password',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                            controlAffinity:
                            ListTileControlAffinity.leading,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top: 10.0)),
                          new MaterialButton(
                            height: 40,
                            minWidth: 100,
                            color: Colors.lightBlue[900],
                            textColor: Colors.white,
                            child: new Text("Login",style: TextStyle(fontSize: 16.0),),
                            onPressed: () {
                              String phonenumber = userController.text;
                              String password = passwordController.text;

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
                                return;
                              }

                              if(rememberpwd){
                                print("Hello");
                                saveUser();
                              } else{
                                removeUser();
                              }

                              setState(() {
                                isLoading = true;
                              });
                              service
                                  .login(phonenumber, password)
                                  .then((value) {
                                print(value);
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
                                      msg: "Login Successful",
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red);
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                          new HomePage()));
                                }
                              });
                              //set isLoading to true
                              //is is loding is true show circular progress
                              //call api
                              //set is loading false after getting response from api
                              //check response from api
                              //save user token to shared preference
                              //navigate to home
                            },
                            splashColor: Colors.redAccent,
                          ),
                          new Padding(
                              padding: const EdgeInsets.only(top:10.0)),
                          Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                            Text('Have not registered yet !! ',
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  /*color: Colors.white*/)),
                            SizedBox(width: 10.0),
                          ]),
                          new Padding(
                              padding: const EdgeInsets.only(top:10.0)),
                          Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: <Widget>[
                            new MaterialButton(
                              height: 40,
                              minWidth: 90,
                              color: Colors.lightBlue[900],
                              textColor: Color(0xFFFD3664),
                              child: new Text(
                                'Register',
                                style: TextStyle(
                                  fontFamily: 'Oswald',
                                  // fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                        new RegistrationPage()))
                              },
                            ),
                            SizedBox(width: 10.0),
                          ]),
                          /*Text('',
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w100,
                                        color: Colors.white)),*/
                          Row(children: <Widget>[
                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 55,
                                  )),
                            ),

                            Text("OR",style: TextStyle(fontSize: 15.0,fontWeight:FontWeight.w600,color:Colors.black),),

                            Expanded(
                              child: new Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 55,
                                  )),
                            ),
                          ]),

                          SignInButton(
                            Buttons.Google,
                            onPressed: () {},
                          ),
                          SignInButton(
                            Buttons.FacebookNew,
                            onPressed: () {},
                          ),
                          new MaterialButton(
                            height: 30,
                            minWidth: 100,
                            color: Colors.white,
                            elevation: 6.0,
                            textColor: Colors.red,
                            child: new Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                      new ForgotPwdPage()));
                            },
                          ),
                          SizedBox(width: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}