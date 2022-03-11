import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haatbajar/api/api_service.dart';
import 'package:haatbajar/ui/deactivation/deactivateList.dart';
import 'package:haatbajar/utilities/utilities.dart';

class DeactivateReason extends StatefulWidget {
  @override
  _DeactivateReasonState createState() => _DeactivateReasonState();
}

class _DeactivateReasonState extends State<DeactivateReason> {
  int selectedRadio;
  ApiService service;

  String radioItem = 'This is temporary.I\'ll be back.';
  int id =1;
  List<DeactivateList> _list =[
    DeactivateList(index:1, reasons:'This is temporary.I\'ll be back.',),
    DeactivateList(index:2, reasons: 'My account was hacked.',),
    DeactivateList(index:3, reasons: 'I have another Haatbajar account.',),
    DeactivateList(index:4, reasons: 'I get too many emails.',),
    DeactivateList(index:5, reasons: 'I don\'t feel safe on Haatbajar.',),
    DeactivateList(index:6, reasons: 'I don\'t find Haatbajar useful.',),
    DeactivateList(index:7, reasons:'I spend to much time using Haatbajar.',),
    DeactivateList(index:8, reasons: 'I don\'t understand how to use Haatbajar.',),
    DeactivateList(index:9, reasons: 'I have privacy concern.',),
    DeactivateList(index:10, reasons: 'Other.'),
  ];

  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
    service = ApiService();
  }
  setSelectedRadio(int val){
    setState((){
      selectedRadio = val;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
              fontSize:20.0,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        title: Text("Enter Reason"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Container(
              child: Text(
                  "Please Select One Reason",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Column(
                children:  _list.map((data) => RadioListTile(
                  title: Text("${data.reasons}",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black)
                  ),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      radioItem = data.reasons ;
                      id = data.index;
                    });
                  },
                )).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new MaterialButton(
                      height: 40,
                      minWidth: 100,
                      color: Colors.lightBlue[900],
                      textColor: Colors.white,
                      child: new Text("Back"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new MaterialButton(
                      height: 40,
                      minWidth: 100,
                      color: Colors.lightBlue[900],
                      textColor: Colors.white,
                      child: new Text("Continue"),
                      onPressed: () {
                        service
                            .deleteAccount()
                            .then(
                              (value) {
                            if (!value == true) {
                              Fluttertoast.showToast(
                                  msg: "Failed to Deactivate account",
                                  textColor: Colors.black,
                                  backgroundColor: Colors.amber);
                            } else if(value==true){
                              Fluttertoast.showToast(
                                  msg: "Successfully deactivated",
                                  textColor: Colors.black,
                                  backgroundColor: Colors.amber);
                              setState(() {
                                clearToken(context);
                              });
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Something Wrong",
                                  textColor: Colors.black,
                                  backgroundColor: Colors.amber);
                            }
                          },
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

