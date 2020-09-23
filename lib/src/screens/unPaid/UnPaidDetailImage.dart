import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//LOCAL RESOURCES
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

class UnPaidDetailImage extends StatelessWidget {


  final String formattedOrderPlacementDatesTimeOnly3;
  final String orderBy3;
  final double totalPrice3;
  final DateTime startDate3;


  UnPaidDetailImage
      (
      this.formattedOrderPlacementDatesTimeOnly3,
      this.orderBy3,
      this.startDate3,
      this.totalPrice3
      );


  @override
  Widget build(BuildContext context) {

    String itemImage2 = (orderBy3.toLowerCase() == 'delivery') ?
    'assets/orderBYicons/delivery.png' :
    (orderBy3.toLowerCase() == 'phone') ?
    'assets/phone.png': (orderBy3.toLowerCase() == 'takeaway')
        ? 'assets/orderBYicons/takeaway.png'
        : 'assets/orderBYicons/diningroom.png';

    return
      Container(
        width: displayWidth(context) / 8,
        height: displayHeight(context) / 14,
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child:

        Hero(
          tag: startDate3.toString()+'__$totalPrice3',
//          tag: formattedOrderPlacementDatesTimeOnly3,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:
            new Container(
              width: displayWidth(context) /  4.8,
              height: displayWidth(context) / 4.8,
              decoration: BoxDecoration(
                color:Color(0xffFFE18E),
                border: Border.all(

                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 3.0,

                ),
                shape: BoxShape.circle,

              ),

              child: Image.asset(

                itemImage2,
//            width: 100,
//            height:1200,

//                              fit: BoxFit.cover,
//                              fit: BoxFit.fill,
//                fit: BoxFit.contain,
//            fit:BoxFit.fitWidth,

//            fit: BoxFit.fill,
//             placeholder: (context, url) => new CircularProgressIndicator(),
              ),


              /*
                  Icon(
                    Icons.phone_in_talk,
//                    getIconForName(orderTypeName),
                    color: Colors.black,
                    size: displayWidth(context) / 10,
                  ),

                  */
            ),


          ),
        ),
      );

    /*
    print('formattedOrderPlacementDatesTimeOnly2: $formattedOrderPlacementDatesTimeOnly3');

    print('orderBy2: $orderBy3');

    print('startDate3: ${startDate3.toString()}');

    print('totalPrice3: $totalPrice3');




    String itemImage2 = (orderBy3.toLowerCase() == 'delivery') ?
    'assets/orderBYicons/delivery.png' :
    (orderBy3.toLowerCase() == 'phone') ?
    'assets/phone.png': (orderBy3.toLowerCase() == 'takeaway')
        ? 'assets/orderBYicons/takeaway.png'
        : 'assets/orderBYicons/diningroom.png';
    return



      Hero(

//          tag: formattedOrderPlacementDatesTimeOnly3,
        tag: startDate3.toString()+'__$totalPrice3',

        child:

        Container(
          width: 200,
          decoration: new BoxDecoration(

            shape: BoxShape.circle,
            color: Color(0xffFCF5E4),
            border: new Border.all(
                color: Colors.black,
                width: 4.0,
                style: BorderStyle.solid
            ),
////                            shape: BoxShape.circle,
//
          ),

          child: Image.asset(

            itemImage2,
//            width: 400,
//            height:1200,

//                              fit: BoxFit.cover,
//                              fit: BoxFit.fill,
                                fit: BoxFit.contain,
//            fit:BoxFit.fitWidth,

//            fit: BoxFit.fill,
//             placeholder: (context, url) => new CircularProgressIndicator(),
//          ),
          ),
        ),



//

      );



     */
  }
}


class  MyClipper22 extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) {
//    return Rect.fromLTWH(left, top, width, height)
//  GOOD OPTION 1
//    return Rect.fromLTWH(-220, 0, 550, 550);

//    return Rect.fromCenter(center: Offset(0, 0),width:190,height:190);
//  GOOD OPTION 2
//    return Rect.fromCircle(center: Offset(0, 330),radius:300);

    return Rect.fromCircle(center: Offset(50, 270),radius:240);

  }
  @override
  bool shouldReclip(oldClipper) => false;
}

