import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  var value;
  var iconValue;
  UserWidget({Key key, this.value, this.iconValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  iconValue,
                  color: Colors.lightBlue[900],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.lightBlue[900],
                  ),
                ),
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
