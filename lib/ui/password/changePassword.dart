import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/main.dart';
import 'package:haatbajar/ui/login/loginPage.dart';

class ChangePasswordPage extends StatefulWidget{
  final otp;
  ChangePasswordPage({Key key, @required this.otp})
      : super(key: key);
  @override
  State createState() => new ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPassword = TextEditingController();
  final _newconfirmPassword = TextEditingController();
  bool _passwordVisible = false;
  bool _invisible = false;
  int userotp = 0;
  String newpass = "";
  String confirmnewpass = "";
  ApiService service;
  FocusNode myFocusNode = new FocusNode();
   @override
   void initState(){
     super.initState();
     service = ApiService();
   }
  void dispose() {
    _newPassword.dispose();
    _newconfirmPassword.dispose();
    super.dispose();
  }
  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _togglenew() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

    @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize:20.0,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        backgroundColor:Colors.lightBlue[900],
        title: Text('Change Password'),
        actions: <Widget>[
          IconButton(
          onPressed: (){},
          icon: Icon(Icons.cancel),
        ),
        ],
        ),
      
      body:  SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
             child: Column(
               children:<Widget>[
                 Padding(padding:const EdgeInsets.all(10.0)),
               Text('Please change your password.',style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18.0,
                                color: Colors.black),),
                Padding(padding:const EdgeInsets.all(10.0)),
               new Form(
                  child : new Theme(
                    data: new ThemeData(
                        primaryColor: Colors.lightBlue[900],
                        accentColor: Colors.red,
                      inputDecorationTheme: new InputDecorationTheme(
                        labelStyle: new TextStyle(
                          color: Colors.black,
                          fontSize: 20.0
                        )
                      )
                    ),
                  child:Column(
                    children:<Widget>[
                         new TextFormField(
                           keyboardType: TextInputType.text,
                           controller: _newPassword,
                           obscureText: !_passwordVisible,
                           decoration: InputDecoration(
                             labelText: 'New Password',
                             labelStyle: TextStyle(
                                 color: myFocusNode.hasFocus
                                     ? Colors.lightBlue[900]
                                     : Colors.black),
                             hintText: 'Type new Password',
                             hintStyle: TextStyle(
                                 color:Colors.black),
                             // Here is key idea
                             suffixIcon: IconButton(
                               icon: Icon(
                                 _passwordVisible
                                     ? Icons.visibility
                                     : Icons.visibility_off,
                               ),
                               onPressed: () {
                                 _toggle();
                               },
                             ),
                           ),
                          ),
                          new TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _newconfirmPassword,
                            obscureText: !_invisible,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  color: myFocusNode.hasFocus
                                      ? Colors.lightBlue[900]
                                      : Colors.black),
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                  color:Colors.black),
                            ),
                          ),
                    ], 
                  ),
                  ),
               ),
                Padding(padding:const EdgeInsets.all(30.0)),
                
                     new MaterialButton(
                            height: 40,
                            minWidth: 100,
                            color: Colors.lightBlue[900],
                            textColor: Colors.white,
                            child: new Text("Update Password"),
                            onPressed: () async {
                            userotp = int.parse(widget.otp);
                            newpass = _newPassword.text;
                            confirmnewpass = _newconfirmPassword.text;
                            if(newpass!=confirmnewpass){
                              Fluttertoast.showToast(
                                  msg: "Passwords does not match",
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            }else{
                              if(newpass.length!=4){
                                Fluttertoast.showToast(
                                    msg: "Password must have atleast 4 characters",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red);
                              }else{
                                service
                                    .resetPassword(userotp, newpass, confirmnewpass)
                                    .then((value){
                                if (!value == true) {
                                Fluttertoast.showToast(
                                msg: "failed to reset password",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red);
                                } else {
                                Fluttertoast.showToast(
                                msg: "Reset Successful",
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red);
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage() ));
                                }
                                },);
                              }
                            }
                             },
                            splashColor: Colors.red,
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