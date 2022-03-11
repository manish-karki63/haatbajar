import 'package:flutter/material.dart';

enum dialogAction { yes, abort}

class DeleteAlert{
  static Future<dialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      ) async{
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
    builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop(dialogAction.abort);
              },
              color: Colors.teal,
              child: const Text(
                  "No",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
              ),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pop(dialogAction.yes);
              },
              color: Colors.teal,
              child: const Text(
                  "Yes",
                  style: TextStyle(
                      color: Colors.red,
                    fontSize: 16.0,
                  ),
              ),
            ),
          ],
        );
    });
    return (action != null) ? action : dialogAction.abort;
  }
}