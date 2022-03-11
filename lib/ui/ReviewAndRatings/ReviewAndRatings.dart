import 'package:haatbajar/api/api_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';

class ReviewAndRatingsUser extends StatefulWidget{
  bool clicked = false;
  final pnumber;
  ReviewAndRatingsUser({Key key, this.clicked,this.pnumber}) : super(key: key);
  @override
  ReviewAndRatingsUserState createState() => ReviewAndRatingsUserState();
}
class ReviewAndRatingsUserState extends State<ReviewAndRatingsUser> {
  ApiService service;
  void initState() {
    super.initState();
    service = ApiService();
  }
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getProductReview(widget.pnumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            style: TextStyle(color: Colors.black),
          );
        } else if (snapshot.hasData) {
          return Container(
             height:  snapshot.data.length==1?110.0:snapshot.data.length==2?200.0:243.0,
            child: ListView.builder(
              itemCount: (widget.clicked ? snapshot.data.length: (snapshot.data.length>=3 ? 3:snapshot.data.length==2?2:1)),
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: new Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://www.princefxea.com/wp-content/uploads/2017/10/robot-png-hd-300x225.png"),
                            ),
                            title: new Row(
                              children: <Widget>[
                                new Text(snapshot.data[index].reviewer.firstName,
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 16.0,
                                    )),
                                VerticalDivider(),
                                new Text(snapshot.data[index].dateToDisplay,
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 10.0,
                                    ))
                              ],
                            ),
                            subtitle: new Text(
                                snapshot.data[index].review ),
                            trailing: new Column(
                              children: <Widget>[
                                new Text(snapshot.data[index].rating.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Helvetica',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                    )),
                                new SmoothStarRating(
                                  isReadOnly: true,
                                  size: 12,
                                  starCount: 5,
                                  borderColor: Colors.red,
                                  color: Colors.red,
                                  rating: snapshot.data[index].rating,
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1.4,)],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
       return Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
              ),
            alignment: Alignment.center,
        );
      },
  );
}
}
