import 'package:flutter/material.dart';
import 'package:haatbajar/ui/setting/NotificationWidget.dart';

class Notifications extends StatefulWidget{
  @override
  State createState() => NotificationsState();
}
class NotificationsState extends State<Notifications> {
  Widget build(BuildContext context)=> Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.lightBlue[900],
      title: Text("Notifications"),
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
    ),
    body: NotificationWidget(),
  );

}
