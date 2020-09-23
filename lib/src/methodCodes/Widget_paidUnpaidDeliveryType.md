
## july 26: before modification:

```dart
Widget paidUnpaidDeliveryType(OneOrderFirebase oneOrderForReceipt) {
    print(
        'at paidUnpaidDeliveryType: && oneOrderForReceipt.orderBy: ${oneOrderForReceipt
            .orderBy}'
            'oneOrderForReceipt.paidStatus: ${oneOrderForReceipt.paidStatus}');
//  Widget paidUnpaidDeliveryType =
    return new Directionality(
      textDirection: TextDirection.ltr,
      child:
      Container(
//        color: Colors.blue,
//        width: displayWidth(context) / 1.8,
        height: 60,

//        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(

//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 55,
              width: 40,

              decoration: BoxDecoration(
                border: Border.all(

                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1.0,

                ),
                shape: BoxShape.circle,
                color: Colors.black,


              ),

              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                child: Icon(
//        getIconForName(orderTypeName),
//        IconData:

                  oneOrderForReceipt.paidStatus.toLowerCase() == 'paid' ? Icons.thumb_up :
                  Icons.pan_tool,
//        FontAwesomeIcons.bookmark,
                  color: Colors.white,
                  size: 35,
                ),
              ),


            ),

            //rounded rectangle border and text conted inside it begins here.


            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 3.6,
                ),
//                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(35.0),
//                    color: Colors.black,

              ),

              width: 200,
              height: 50,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <
                    Widget>[
                  //  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      oneOrderForReceipt.paidStatus.toLowerCase() == 'paid' ?
                      'paid' : 'unpaid',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 17, fontFamily: 'Itim-Regular',),
                    ),
                  ),
                  Text(
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                        ? 'Delivery'
                        :
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                    'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                        'takeaway') ? 'TakeAway' : 'Dinning Room',
//                    oneOrderForReceipt.orderBy
//                    'dinning room',
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

            Container(

//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 55,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
//                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                shape: BoxShape.circle,
                color: Colors.black,
              ),

              child: Icon(
//        getIconForName(orderTypeName),
//        IconData:
                (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery') ? Icons
                    .motorcycle :
                (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                Icons.phone_in_talk : (oneOrderForReceipt.orderBy
                    .toLowerCase() == 'takeaway')
                    ? Icons.business_center
                    : Icons.local_dining,
//                Icons.local_dining,
//        FontAwesomeIcons.bookmark,
                color: Colors.white,
                size: 35,

              ),


            ),

            //rounded rectangle border and text conted inside it ends here.


          ],
        ),
      ),
    );
  }
```