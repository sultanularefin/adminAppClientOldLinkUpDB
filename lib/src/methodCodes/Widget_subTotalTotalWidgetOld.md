

## july 27 -> Subtotal Total Recite Widget TO IMage:

```dart

  Widget subTotalTotalDeliveryCost(double subtotal,
      {double deliveryCost: 2.50}) {
    Path customPathTotalCost = Path()
      ..moveTo(200, 120)
      ..lineTo(0, 120);

    return Directionality(

      textDirection: TextDirection.ltr,
      child:
      Container(
//        color:Colors.green,
        height: 170,

//        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        width: 300,
        /*
        decoration: BoxDecoration(
          border: Border.all(

            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,

          ),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(35.0),

        ),
        */
        child:

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[


            //rounded rectangle border and text conted inside it begins here.


            Container(
//                    height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'SUBTOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                            fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 14, fontFamily: 'Itim-Regular',),
                    ),
                  ),

                  // qwe
//                          '${
//                              (unObsecuredInputandPayment.totalPrice
//                                  /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
//                              '\u20AC',
                  Text(subtotal.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                          fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 14, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            // 1st row ends here.


            Container(
//                    height: 50,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'Delivery Cost',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 14, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(deliveryCost.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 14, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            /*
              DottedBorder(
//                dashPattern: [6, 3,2, 3],
                dashPattern: [9, 6,],
                customPath: (size) => customPath2,
                child: Text('abc',style:TextStyle(
                  color:Colors.indigo,
                )
                  ,),
              ),

              */
            /*
              DottedBorder(
                customPath: (size) => customPath, // PathBuilder
                color: Colors.indigo,
                dashPattern: [8, 4],
                strokeWidth: 2,
                child: Container(
                  height: 220,
                  width: 120,
                  color: Colors.green.withAlpha(20),
                ),
              ),

*/

//              DottedBorder(
//              child:StrokeCap.Butt),


            //2nd row ends here.


            Container(
//              height: 50,
//              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'TOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 17, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(
                    (deliveryCost + subtotal).toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 17, fontFamily: 'Itim-Regular',),
                  ),
                ],
              ),
            ),

            // total ends here.


          ],
        ),

      ),
    );
  }

```