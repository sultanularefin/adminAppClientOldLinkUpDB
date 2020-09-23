

## customerInforMationReciteTopImage:

```dart

  Widget orderInformationAndCustomerInformationWidget(
      OneOrderFirebase oneOrderForReceipt) {
    print(
        'at paidUnpaidDeliveryType: && oneOrderForReceipt.orderBy: ${oneOrderForReceipt
            .orderBy}'
            'oneOrderForReceipt.paidStatus: ${oneOrderForReceipt.paidStatus}');

    CustomerInformation customerForReciteGeneration = oneOrderForReceipt
        .oneCustomer;
//  Widget paidUnpaidDeliveryType =
    return new Directionality(
      textDirection: TextDirection.ltr,
      child:
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
        height: 170,

//        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // previously it was little bit middle ... with center..
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(6, 15, 0,0),

              height: 152,
              width: 105,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                        ? 'Delivery'
                        :
                    (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                    'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                        'takeaway') ? 'TakeAway' : 'Dinning Room',
//                    oneOrderForReceipt.orderBy
//                    'dinning room',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),

                  // 1 ends here.


                  Text(
                    '${oneOrderForReceipt
                        .formattedOrderPlacementDatesTimeOnly}',

                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),


                  // 2 ends here.
                  Text('${oneOrderForReceipt.orderProductionTime} min',

                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),

                  // 3 ends here.
                ],
              ),
            ),


            /// toDo: multiline. maxlines
            Container(

              padding: EdgeInsets.fromLTRB(0, 8, 0,0),
//            color:Colors.yellow,

//            color:Colors.yellowAccent,
              height: 160,
              width: 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height:49,
                    width: 160,
                    padding:EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      ((customerForReciteGeneration.address == null) ||
                          (customerForReciteGeneration.address.length == 0)) ?
                      'EMPTY' :customerForReciteGeneration.address.length>39?
                      customerForReciteGeneration.address.substring(0,35) +'...':
                      customerForReciteGeneration.address,

                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
//                      fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 20, fontFamily: 'Itim-Regular',),
//                      maxLines: 2,
//                      textAlign: TextAlign.left,
                    ),
                  ),

                  // 1 ends here.

//                    .length>12?
////              stringifiedFoodItemIngredients.substring(0,12)+'...':

                  Container(
                    height:49,
                    width: 160,
                    padding:EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      ((customerForReciteGeneration.flatOrHouseNumber == null) ||
                          (customerForReciteGeneration.flatOrHouseNumber.length ==
                              0)) ?
                      'EMPTY' :customerForReciteGeneration.flatOrHouseNumber.length>39?
                      customerForReciteGeneration.flatOrHouseNumber.substring(0,35) +'...':
                      customerForReciteGeneration.flatOrHouseNumber,

                      maxLines:2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
//                      fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 20, fontFamily: 'Itim-Regular',),

                    ),
                  ),

                  Container(
                    height:50,
                    width: 160,
                    padding:EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(

                      ((customerForReciteGeneration.phoneNumber == null) ||
                          (customerForReciteGeneration.phoneNumber.length == 0)) ?
                      'EMPTY' :customerForReciteGeneration.phoneNumber.length>39?
                      customerForReciteGeneration.phoneNumber.substring(0,35) +'...':
                      customerForReciteGeneration.phoneNumber,
                      maxLines: 2,

                      textAlign: TextAlign.left,
                      style: TextStyle(
//                      fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 20, fontFamily: 'Itim-Regular',),

                    ),
                  ),


                  // 3 ends here.
                ],
              ),
            )

            //rounded rectangle border and text conted inside it ends here.

          ],
        ),
      ),
    );
  }

```