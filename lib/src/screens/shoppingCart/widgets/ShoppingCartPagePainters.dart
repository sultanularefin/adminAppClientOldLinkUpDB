

import 'package:flutter/material.dart';
//import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
//import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';


/*
Widget animatedWidgetShowFullOrderType(BuildContext context) {
//    print ('at animatedWidgetShowFullOrderType() ');

  return
    Container(
      height: displayHeight(context) / 20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +  displayHeight(context) /7 /* HEIGHT OF MULTI SELECT PORTION */,
      child: Column(
        children: <Widget>[
          Container(
            width: displayWidth(context) / 1.1,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .start
              ,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <Widget>[


                Container(
                  width: displayWidth(context) /
                      1.5,
                  height: displayHeight(
                      context) / 20,
                  color: Color(0xffffffff),

                  child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start
                      ,
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets
                              .fromLTRB(
                              20, 0, 10, 0),
                          alignment: Alignment
                              .center,
                          child: Text(
                              'Choose Order Type',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(
                                    0xff000000),
                              )
                          ),
                        ),

                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForChooseOrderType(
                              context),
                        ),




                      ]
                  ),

                ),

                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                /*
                                                        Container(
//                                                  alignment: Alignment.center,
                                                          padding: EdgeInsets.fromLTRB(
                                                              0, 2, 0, 0),
                                                          width: displayWidth(context) /
                                                              16,
//                                                height: displayHeight(context)/20,
                                                          color: Color(0xffffffff),
//                                                    child:Row(
//                                                      mainAxisAlignment: MainAxisAlignment.end,
//                                                      children: <Widget>[
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 0, 200, 0),
                                                            child: Icon(

                                                              Icons.add_shopping_cart,
                                                              size: 30,
                                                              color: Color(0xff54463E),
                                                            ),
                                                          ),


                                                        ),
                                                        */


                // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.


                ////WWWEEEQQQ




              ],
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
            color:Colors.white,
//                                            height: 200,
            height: displayHeight(context) /7,
            width: displayWidth(context)
                - displayWidth(context) /
                    5,
//                                            width: displayWidth(context) * 0.57,
            child:  _buildOrderTypeSingleSelectOption(),

          ),
        ],
      ),
    );
}



*/


class LongPainterForPaymentUnSelected extends CustomPainter {

  final BuildContext context;
  LongPainterForPaymentUnSelected(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.3, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(5, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongPainterForChooseOrderTypeAdress extends CustomPainter {

  final BuildContext context;
  LongPainterForChooseOrderTypeAdress(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.3, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(5, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}

class LongPainterForDinning extends CustomPainter {

  final BuildContext context;
  LongPainterForDinning(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/3, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(5, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongPainterForETA extends CustomPainter {

  final BuildContext context;
  LongPainterForETA(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/9.3, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(5, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongPainterForPhone extends CustomPainter {

  final BuildContext context;
  LongPainterForPhone(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/9.3, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(5, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongPainterForChooseOrderTypeUpdated extends CustomPainter {

  final BuildContext context;
  LongPainterForChooseOrderTypeUpdated(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.3, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}

class LongPainterForChooseOrderType extends CustomPainter {

  final BuildContext context;
  LongPainterForChooseOrderType(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.9, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}



//LongHeaderPainterAfterShoppingCartPage
class LongHeaderPainterAfterShoppingCartPage extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfterShoppingCartPage(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/2.8, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }



}



class LongPainterForanimatedWidgetShowSelectedOrderType extends CustomPainter {

  final BuildContext context;
  LongPainterForanimatedWidgetShowSelectedOrderType(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/3.9, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}




class LongHeaderPainterBefore extends CustomPainter {


  final BuildContext context;
  LongHeaderPainterBefore(this.context);


  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(-displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(-10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}