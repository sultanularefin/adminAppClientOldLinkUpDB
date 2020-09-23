import 'package:flutter/material.dart';

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(right: 5),
      width: 7,
      height: 7,
      decoration: new BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
    );
  }
}
