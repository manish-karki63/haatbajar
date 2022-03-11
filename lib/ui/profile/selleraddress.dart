import 'package:flutter/material.dart';
import 'package:haatbajar/utilities/utilities.dart';

class SellerAddress extends StatefulWidget {
  final double lat,long;
  SellerAddress({Key key,this.lat,this.long}) : super(key: key);
  @override
   SellerAddressState createState() => SellerAddressState();
}

class SellerAddressState extends State<SellerAddress> {
  @override
  Widget build(BuildContext context) {
    print("I am from seller address${widget.lat}");
    print("I am from seller address${widget.long}");
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
      child: Container(
        height: 60,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.lightBlue[900],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                ),
                FutureBuilder<String>(
                    future: getsellerAddress(widget.lat, widget.long),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text("Loading...",style: TextStyle(
                            fontSize: 16.0,
                            fontWeight:
                            FontWeight.w600,
                            color: Colors
                                .lightBlue[900],
                          ),);
                        default:
                          if (snapshot.hasData) {
                            print("after hasdata ${snapshot.data}");
                            if (snapshot.data == null) {
                              return new Text(
                                "Unavailable",style: TextStyle(
                                fontSize: 16.0,
                                fontWeight:
                                FontWeight.w600,
                                color: Colors
                                    .lightBlue[900],
                              ),);
                            } else
                              return new Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight:
                                  FontWeight.w600,
                                  color: Colors
                                      .lightBlue[900],
                                ),
                              );
                          } else
                            print(" ${snapshot.error}");
                      return Container(
                      child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 5,
                      ),
                      alignment: Alignment.center,
                      );
                      //return new LoginPage();
                    }
                    }),
                /*Text(
                  ,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlue[900],
                  ),
                ),*/
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          border: Border.all(
            width: 1.0,
            color: Colors.lightBlue[900],
          ),
        ),
      ),
    );
  }

}