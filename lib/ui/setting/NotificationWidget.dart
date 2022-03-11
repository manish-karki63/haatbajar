import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haatbajar/models/Message.dart';

class NotificationWidget extends StatefulWidget{
  @override
  NotificationWidgetState createState() => NotificationWidgetState();
}
class NotificationWidgetState extends State<NotificationWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic>message)async{
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
            title: notification['title'],body: notification['body']
          ));
        });
      },
      onLaunch: (Map<String,dynamic>message)async{
        print("onLaunch: $message");
        final notification = message['data'];
        setState(() {
          messages.add(Message(
              title: notification['title'],body: notification['body']
          ));
        });
      },
      onResume: (Map<String,dynamic>message)async{
        print("onResume: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'],body: notification['body']
          ));
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true,badge: true,alert: true)
    );

  }
  Widget build(BuildContext context) => ListView(
    children: messages.map(buildMessage).toList()!=null?messages.map(buildMessage).toList():"",
  );
  Widget buildMessage(Message message)=>ListTile(
    title: Text(message.title!=null?message.title:""),
    subtitle: Text(message.body!=null?message.body:""),
  );
}
