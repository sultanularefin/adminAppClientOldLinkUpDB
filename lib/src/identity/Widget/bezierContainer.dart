import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
//        angle: -pi / 3.5,
        angle: -pi / 5.5,
        child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height *.3,
//          width: MediaQuery.of(context).size.width,

          width: MediaQuery.of(context).size.width * 1.4,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [


//                  Color(0xfffbb448),
//
//                  Color(0xffe46b10)
                  Colors.lightGreenAccent,
                  Colors.lightBlueAccent,
                  // Colors.pinkAccent,
                  // Colors.deepOrange,


                ]
              )
            ),
        ),
      ),
      )
    );
  }
}