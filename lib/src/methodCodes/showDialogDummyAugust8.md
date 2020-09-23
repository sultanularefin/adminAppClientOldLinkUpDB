


## august 8 =>2020 =>

```dart



    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container
                  (
//                    color:Colors.green,
                    width: 200,
                    height:40,
                    child: Image.memory(restaurantNameImageByte2)
                ),

                Divider(
                  height:10,
                  thickness:5,
                  color:Colors.black,
                ),


                Container(
                  child:

                  // 2 ends here.
                  Text('Order No: Cloud Function generated..',

                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',),
                  ),

                ),

                Divider(
                  height:10,
                  thickness:5,
                  color:Colors.black,
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                    ],
                  ),
                ),

                Container(
                  child:

                      // 2 ends here.
                      Text('${oneOrderForReceipt.formattedOrderPlacementDate}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                ),


                SizedBox(
                  height: 10,
                ),





                // ADDRESS: BEGINS HERE.

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'address: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${((customerForReciteGeneration.address == null) ||
                            (customerForReciteGeneration.address.length == 0)) ?
                        '----' : customerForReciteGeneration.address.length > 21 ?
                        customerForReciteGeneration.address.substring(0, 18) + '_ _' :
                        customerForReciteGeneration.address}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                      // 2 ends here.
                      Text('${customerForReciteGeneration.flatOrHouseNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                    ],
                  ),
                ),

                // ADDRESS: ENDS HERE.

                // PHONE: BEGINS HERE.



                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'phone: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${customerForReciteGeneration.phoneNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),

                // PHONE: ENDS HERE.


                Divider(
                  height:30,
                  thickness:10,
                  color:Colors.black,
                ),


                //  ORDEREDITEMS BEGINS HERE..

//                orderedItems.map((e) => null)




                Container(
                    width: 350,
                    height:580,
                    child: processFoodForRecite(orderedItems)
                ),



                //  ORDEREDITEMS endS HERE..

                Divider(
                  height:30,
                  thickness:8,
                  color:Colors.black,
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'SUBTOTAL: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${oneOrderForReceipt.totalPrice.toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'DELIVERY: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${oneOrderForReceipt.deliveryCost.toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'ALV: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',),
                      ),
                      Text(
                        '${oneOrderForReceipt.tax.toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'TOTAL: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 30, fontFamily: 'Itim-Regular',),
                      ),

                      // TODO: PROBLEM CODE NEEDS CHECKING....
                      Text(
                        '${(oneOrderForReceipt.priceWithTaxAndDelivery).toStringAsFixed(2)}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',),
                      ),

                    ],
                  ),
                ),







                Container(
                  height:70,
                  width: 400,
                  child: Row(
                    children: <Widget>[
                      Container(
                        color:Colors.red,
                        //sss
                        width: 70,
                        height:70,
                        child: Image.asset(
                          oneOrderForReceipt.paidType.toLowerCase() == 'card' ?
                          'assets/unpaid_cash_card/card.png'
                              :oneOrderForReceipt.paidType.toLowerCase() == 'cash'?
                          'assets/unpaid_cash_card/cash.png':'assets/unpaid_cash_card/unpaid.png',

//                color: Colors.black,
                          width: 50,
                          height:50,

                        ),
                      ),
                      Row(
                        children: <Widget>[


                          Text(
                            oneOrderForReceipt.paidType.toLowerCase() == 'card' ?
                            'card'
                                :oneOrderForReceipt.paidType.toLowerCase() == 'cash'?
                            'cash':'unpaid',

//                            oneOrderForReceipt.paidType.toLowerCase() == 'paid' ?
//                            'paid' : 'unpaid',

                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
//                          color: Color(0xffF50303),
                              fontSize: 20, fontFamily: 'Itim-Regular',),
                          ),

                          SizedBox(width: 50),

                          Text(
                            (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery')
                                ? 'Delivery'
                                :
                            (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                            'Phone' : (oneOrderForReceipt.orderBy.toLowerCase() ==
                                'takeaway') ? 'TakeAway' : 'DinningRoom',
//                    oneOrderForReceipt.orderBy
//                    'dinningRoom',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
//                        color: Color(0xffF50303),
                              fontSize: 20, fontFamily: 'Itim-Regular',),
                          ),



                        ],
                      ),

                      Container(
//                      color: Colors.black,
                        width: 70,
                        height:70,

                        child: (oneOrderForReceipt.orderBy.toLowerCase() == 'delivery') ?
                        Image.asset(
                          'assets/orderBYicons/delivery.png',
                          color: Colors.black,
                          width: 50,
                          height:50,) :
                        (oneOrderForReceipt.orderBy.toLowerCase() == 'phone') ?
                        Image.asset(
                            'assets/phone.png',
                            color: Colors.black,
                            width: 50,
                            height:50) : (oneOrderForReceipt.orderBy
                            .toLowerCase() == 'takeaway')
                            ? Image.asset(
                          'assets/orderBYicons/takeaway.png',
                          color: Colors.black,
                          width: 50,
                          height:50,
                        )
                            : Image.asset('assets/orderBYicons/diningroom.png',
                          color: Colors.black,
                          width: 50,
                          height:50,),

                      ),


                    ],
                  ),
                ),

//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



```

## AUGUST 8 +> PROCESSRECITE

```dart

//  DUMMY RECITE RELATED PRINT CODES ARE HERE ==> LINE # 11264 ==>
//  showExtraIngredients(oneFood.selectedIngredients)
//  showExtraCheeseItems(oneFood.selectedCheeses)
//  showExtraSauces(oneFood.defaultSauces)

  Widget showExtraIngredients(List <NewIngredient> reciteIngrdients,int quantity){

    print('reciteIngrdients.length: ${reciteIngrdients.length}');
    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteIngrdients.length,


      itemBuilder: (_,int index) {
        return displayOneExtraIngredientInRecite(reciteIngrdients[index], index,quantity);
      },

    );

  }
  Widget showExtraCheeseItems(List<CheeseItem> reciteCheeseItems,int quantity){
    print('reciteCheeseItems.length: ${reciteCheeseItems.length}');
    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteCheeseItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraCheeseItemInRecite(reciteCheeseItems[index], index,quantity);
      },
    );
  }
  Widget showExtraSauces(List<SauceItem> reciteSauceItems,int quantity){
    print('reciteSauceItems.length: ${reciteSauceItems.length}');
    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteSauceItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraSauceItemInRecite(reciteSauceItems[index], index,quantity);
      },
    );
  }



  Widget displayOneExtraIngredientInRecite(NewIngredient oneIngredientForRecite, int index,int quantity){

    print('oneIngredientForRecite.ingredientName: ${oneIngredientForRecite.ingredientName}');

    if(oneIngredientForRecite.isDefault==false) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
//              '+SauceItem: $quantity'+'X',
              '+Ingre.: $quantity'+'X',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

            Text('${((oneIngredientForRecite.ingredientName == null) ||
      (oneIngredientForRecite.ingredientName.length == 0)) ?
      '----' : oneIngredientForRecite.ingredientName.length > 18 ?
      oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
      oneIngredientForRecite.ingredientName}',
            /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 17, fontFamily: 'Itim-Regular',),
            ),
            Text(
              '  +${(oneIngredientForRecite.price *quantity).toStringAsFixed(2)}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

          ],
        ),
      );
    }
    else return Container(
        height: 0,
        width: 0
    );
  }

  Widget displayOneExtraSauceItemInRecite(SauceItem oneSauceItemForRecite, int index,int quantity){

    print('oneSauceItemForRecite.ingredientName: ${oneSauceItemForRecite.sauceItemName}');

    if(oneSauceItemForRecite.isDefaultSelected !=true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
              '+SauceItem: $quantity'+'X',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

        Text('${((oneSauceItemForRecite.sauceItemName == null) ||
            (oneSauceItemForRecite.sauceItemName.length == 0)) ?
        '---' : oneSauceItemForRecite.sauceItemName.length > 18 ?
        oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
        oneSauceItemForRecite.sauceItemName}',
          /*
          Text(
              '${oneSauceItemForRecite.sauceItemName} ',
              */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),
            Text(
              '  +${(oneSauceItemForRecite.price * quantity).toStringAsFixed(2)}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

          ],
        ),
      );
    }
    else return Container(
        height: 0,
        width: 0
    );
  }


  Widget displayOneExtraCheeseItemInRecite(CheeseItem oneCheeseItemForRecite, int index,int quantity){

    print('oneCheeseItemForRecite.ingredientName: ${oneCheeseItemForRecite.cheeseItemName}');
    if(oneCheeseItemForRecite.isDefaultSelected !=true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(
              '+cheese: $quantity'+'X',
//              '+Ingre.: $quantity'+'X',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),
        Text('${((oneCheeseItemForRecite.cheeseItemName == null) ||
            (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
        '---' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
        oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
        oneCheeseItemForRecite.cheeseItemName}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

            /*

            Text('${((oneIngredientForRecite.ingredientName == null) ||
      (oneIngredientForRecite.ingredientName.length == 0)) ?
      '----' : oneIngredientForRecite.ingredientName.length > 18 ?
      oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
      oneIngredientForRecite.ingredientName}',
            /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 17, fontFamily: 'Itim-Regular',),
            ),

            */
            Text(
              '  +${(oneCheeseItemForRecite.price * quantity).toStringAsFixed(2)}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),

          ],
        ),
      );
    }
    else return Container(
        height: 0,
        width: 0
    );
  }

  Widget displayOneFoodInformation(OrderedItem oneFood, int index){
    print('index: : : : $index');

    List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
    List<SauceItem>     extraSauces       = oneFood.selectedSauces;
    List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;


    print('extraIngredient: $extraIngredient');

    print('extraSauces: $extraSauces');

    print('extraCheeseItems: $extraCheeseItems');

    List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();
    List<SauceItem> onlyExtraSauces       = extraSauces.where((e) => e.isDefaultSelected != true).toList();
    List<CheeseItem>    onlyExtraCheeseItems  = extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();


    print('onlyExtraIngredient: $onlyExtraIngredient');

    print('onlyExtraSauces: $onlyExtraSauces');

    print('onlyExtraCheeseItems: $onlyExtraCheeseItems');


    /*
    List<NewIngredient> defaultIngredientsLaterAdded
    = defaultIngredients.where((oneDefaultIngredient) =>
    oneDefaultIngredient.isDefault!=true).toList();

    */









//    List<String> categories = [];
//    orderedItems.forEach((oneFood) {
//
//
//      if((categories==null) || (categories.length==0) || (categories.contains(oneFood.category)==false) ) {
//        ticket.text('${oneFood.category.toString()}',
//            styles: PosStyles(
//              height: PosTextSize.size1,
//              width: PosTextSize.size1,
//              bold: true,
//              align: PosAlign.center,
//            )
//        );
//      }
//
//      categories.add(oneFood.category);

//    List<String> categories = [];


    return Container(

      height:940,
      width: 350,

      child: Column(
        children: <Widget>[


          Container(
            height: 50,
            width: 350,
            alignment: Alignment.center,
            child: Text(
              '${oneFood.category.toString()}',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',),
            ),
          ),
          Container(
            height: 50,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  '${oneFood.name.toString()}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),
                Text(
                  'X${oneFood.quantity}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

              ],
            ),
          ),


          Container(
            height: 50,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  '${oneFood.foodItemSize}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),
                Text(
                  '${(oneFood.unitPriceWithoutCheeseIngredientSauces * oneFood.quantity).toStringAsFixed(2)}',
                  // '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

              ],
            ),
          ),



          Container(
            height:700,
            color:Colors.redAccent,
            padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
            child:ListView(
              children: <Widget>[
                Container(
                    width: 350,
                    height:210,
                    color:Colors.blue,
                    child: showExtraIngredients(onlyExtraIngredient,oneFood.quantity)),



                Divider(
                  height:10,
//            width: 220,
                  thickness:5,
                  color:Colors.black,
                ),
                Container(
                    width: 350,
                    height:210,
                    color:Colors.orange,
                    child: showExtraCheeseItems(onlyExtraCheeseItems,oneFood.quantity)
                ),

                Divider(
                  height:10,
//            width: 220,
                  thickness:5,
                  color:Colors.black,
                ),
                Container(
                    width: 350,

                    height:210,
                    color:Colors.deepPurpleAccent,
                    child: showExtraSauces(onlyExtraSauces,oneFood.quantity)
                ),


              ],
            )
          ),


          Divider(
            height:20,
//            width: 220,
            thickness:5,
            color:Colors.black,
          ),


        ],
      ),
    );
  }



  Widget processFoodForRecite(List<OrderedItem> orderedItems){

    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: orderedItems.length,

      itemBuilder: (_,int index) {
        return displayOneFoodInformation(orderedItems[index], index);
      },
    );
  }
```