//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/HistoryDetailsBloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:qr_flutter/qr_flutter.dart';


//import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:foodgallery/src/screens/history/HistoryDetailImage.dart';


//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
//import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';

import 'package:logger/logger.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

class HistoryDetailsPage extends StatefulWidget {

  final Widget child;
  HistoryDetailsPage({Key key, this.child}) : super(key: key);
  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState();

}


class _FoodItemDetailsState extends State<HistoryDetailsPage> {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String _currentSize;
//  int _itemCount= 0;
//  double priceBySize = 0.0;
//  double priceBasedOnCheeseSauceIngredientsSizeState = 0.0;
//
//  List<String> allSubGroups1 = new List<String>();

/*

  @override
  void initState() {

//    setallSubgroups();

    super.initState();
  }


   */







  double tryCast<num>(dynamic x, {num fallback }) {


    bool status = x is num;

    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}


    else return 0.0;
  }

  bool showUnSelectedIngredients = false;
  bool showPressWhenFinishButton = false;



  @override
  Widget build(BuildContext context) {


    final blocHD = BlocProvider.of<HistoryDetailsBloc>(context);


    return Container(

        child: StreamBuilder<OneOrderFirebase>(


            stream:       blocHD.getCurrentOrderStream,
            initialData:  blocHD.getCurrentFireBaseOrder,

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new LinearProgressIndicator());
              }
              else {

                final OneOrderFirebase oneFireBaseOrderDetail = snapshot.data;



//                priceBasedOnCheeseSauceIngredientsSizeState =  oneFireBaseOrderDetail.priceBasedOnCheeseSauceIngredientsSize;
//
//                priceBySize = oneFireBaseOrderDetail.itemPriceBasedOnSize;
//
//                _currentSize = oneFireBaseOrderDetail.itemSize;


                return GestureDetector(
                  onTap: () {
                    print('s');
                    print('navigating to FoodGallery 2 again with block');

                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

// WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
// WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
// FROM FOOD ITEM PAGE.


                    print('CLEAR SUBSCRIPTION ... before going to food gallery page..');


                    return Navigator.pop(context);


                  },
                  child:
                  Scaffold(

                    backgroundColor: Colors.white.withOpacity(0.05),
// this is the main reason of transparency at next screen.
// I am ignoring rest implementation but what i have achieved is you can see.

                    body: SafeArea(

// smaller container containing all modal FoodItem Details things.
                      child: Container(
                          height: displayHeight(context) -
                              MediaQuery.of(context).padding.top -
                              MediaQuery.of(context).padding.bottom,
//                            kToolbarHeight

                          child: GestureDetector(
                            onTap: () {
                              print('GestureDetector for Stack working');
                              print('no navigation now');


                            },
                            child:

                            Container(

// FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
                                width: displayWidth(context)/1.03,

                                child:
                                initialView(oneFireBaseOrderDetail)
                            ),



                          )


                      ),
                    ),
                  ),
                );
              }
            }
        )
    );
//    }
  }


  Widget initialView(OneOrderFirebase oneFireBaseOrder){

    List<OrderedItem> orderedItems = oneFireBaseOrder.orderedItems;



    return Container(

      height: displayHeight(context) -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom,


// FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
      width: displayWidth(context)/1.03,
//                  color:Colors.lightGreen,
      margin: EdgeInsets.fromLTRB(
          0, displayHeight(context)/16, 0, 5),

      decoration:
      new BoxDecoration(
        borderRadius: new BorderRadius
            .circular(
            10.0),
//                                    color: Colors.purple,
        color: Colors.white,
      ),


      child:
      Neumorphic(
        curve: Neumorphic.DEFAULT_CURVE,
        style: NeumorphicStyle(
          shape: NeumorphicShape
              .concave,
          depth: 8,
          lightSource: LightSource
              .topLeft,
          color: Colors.white,
          boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(5)),
          ),
        ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(

        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start,
          crossAxisAlignment: CrossAxisAlignment
              .start,
          children: <Widget>[

            Container(
//              color: Colors.blue,
              height:displayHeight(context)/11,
              width: displayWidth(context)/1.07,

              child:
// YELLOW NAME AND PRICE BEGINS HERE.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context)/2.8 /*+  displayWidth(context)/8 */, /*3.9 */


                    decoration: BoxDecoration(
                      color:Color(0xffFFE18E),
                      borderRadius: BorderRadius.only(bottomRight:  Radius.circular(60)),
//
                    ),


                    height:displayHeight(context)/18,
//                                          height: displayHeight(context)/40,

                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                        Container(
                          width: displayWidth(context)/3.9,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child:

                          Text(
                              '${oneFireBaseOrder.orderBy.toLowerCase()}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                              )
                          ),
                        ),



                      ],
                    ),



                  ),




                  Container(

//                    color:Colors.green,
                    width: displayWidth(context) /2.5,
                    height:displayHeight(context)/11,
                    child:displayCustomerInformationWidget(oneFireBaseOrder.oneCustomer),
//                    height: displayHeight(context)/20,

                  )

                ],
              ),

            ),

            Divider(
              height:10,
              thickness:1,
              color:Colors.grey,
            ),



            SizedBox(height:10),

            Container(

                width: displayWidth(context) /2.49 + displayWidth(context) /1.91,

                height: displayHeight(context) / 1.6,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
//                                                    width: displayWidth(context)/4,
                      width: displayWidth(context)/3,
//                                                    width: displayWidth(context)/3.29,
//                      color:Colors.blue,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,


                        children: [
                          Container(
                            height:displayHeight(context)/6.5,
                            width: displayWidth(context)/3.59,
//                        color: Colors.red,
//                            color:Colors.blue,


                            padding: EdgeInsets
                                .fromLTRB(
                                0, 0, 0,
                                0),

//                          child: Text('FoodImageURL')

                            child:
                            HistoryDetailImage(
                              oneFireBaseOrder.formattedOrderPlacementDatesTimeOnly,
                              oneFireBaseOrder.orderBy,
                              oneFireBaseOrder.startDate,
                              oneFireBaseOrder.totalPrice,

//
                            ),
//                          formattedOrderPlacementDatesTimeOnly2
//),

                          ),


                          Container(
                            height:displayHeight(context)/4,
                            width: displayWidth(context)/2.99,
//                        color: Colors.red,


                            padding: EdgeInsets
                                .fromLTRB(
                                20, 0, 20,
                                0),

//                          child: Text('FoodImageURL')

                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Text(
                                    '${oneFireBaseOrder.formattedOrderPlacementDatesTimeOnly}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                      color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                    )
                                ),

                                Container(
                                  child: oneFireBaseOrder.orderProductionTimeFromNow !=-1?

                                  Text('${oneFireBaseOrder.orderProductionTimeFromNow} min',
                                    maxLines: 1,

                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
//                        color: Color(0xffF50303),
                                      fontSize: 20, fontFamily: 'Itim-Regular',),
                                  ):Text('${oneFireBaseOrder.timeOfDay.toString()}',

                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
//                        color: Color(0xffF50303),
                                      fontSize: 20, fontFamily: 'Itim-Regular',),
                                  ),
                                ),

                                /*
                                Text(
                                    '${oneFireBaseOrder.orderProductionTimeFromNow}:00 min',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                      color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                    )
                                ),

                                */

                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'SUBTOTAL',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.totalPrice.toStringAsFixed(2)}'+'\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),



                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'DELIVERY',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.deliveryCost.toStringAsFixed(2)}'+'\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color:Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),




                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'ALV',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '14%',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                Divider(
                                  height:5,
                                  thickness:1,
                                  color:Colors.grey,
                                ),




                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          'TOTAL',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.priceWithDelivery.toStringAsFixed(2)}'+'\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Text(
                                          '${oneFireBaseOrder.paidStatus}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrder.paidType}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),














                              ],
                            ),
//                          formattedOrderPlacementDatesTimeOnly2
//),

                          ),



                        ],
                      ),
                    ),

                    VerticalDivider(
//                      height:10,
                      width:10,
                      thickness:1,
                      color:Colors.grey,
                    ),



                    Container(
//                      color:Colors.purpleAccent,
                      height:displayHeight(context)/1.7,



                      width:displayWidth(context) /1.91,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .start,
                        crossAxisAlignment: CrossAxisAlignment
                            .end,
                        children: <Widget>[



                          Container(
                              width: 550,
                              height:displayHeight(context)/1.7,
                              child: processFoodForHistoryDetailsPage(orderedItems)
                          ),

//                          FFFFF




                        ],
                      ),
                    ),




                  ],
                )

            ),



            Center(
              child: OutlineButton(
                padding: EdgeInsets.all(0),
                splashColor: Colors.lightBlueAccent,
                highlightElevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                borderSide: BorderSide(
                  color:Color(0xff707070),
                  style: BorderStyle.solid,
                  width: 1.6,
                ),

                child: Container(

                  child:
                  Column(
                    children: [
                      Container(
                        width: 150,
                        height:150,
                        child: QrImage(
                          data: "1234567890",
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                      ),

                      Text(
                        'check order',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 23,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),

                    ],
                  ),
                ),
                onPressed: () {

                  print('-------------- ---------- pressed');

                },


              ),
            ),









/*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */

          ],
        ),

      ),
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


    return Container(

      height:145,
      width: 550,
      padding:EdgeInsets.symmetric(vertical:8,horizontal: 6),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            color:Colors.amber,
            height: 30,
            width: 550,
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
                    fontSize: 20,
//                    fontFamily: 'Itim-Regular',
                  ),
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
                /*
        Text(
                  '${oneFood.foodItemSize}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

                */
                Text(
                  '${(oneFood.oneFoodTypeTotalPrice * oneFood.quantity).toStringAsFixed(2)}',
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
              height: 30,
              width: 550,
              child: showExtraIngredients(onlyExtraIngredient,oneFood.quantity)
          ),

//                Text('||'),
          Container(
              height: 30,
              width: 550,
              child: showExtraCheeseItems(onlyExtraCheeseItems,oneFood.quantity)
          ),

//                Text('||'),
          Container(
              height: 30,
              width: 550,
              child: showExtraSauces(onlyExtraSauces,oneFood.quantity)
          ),

          Divider(
            height:5,
            thickness:1,
            color:Colors.grey,
          ),

        ],
      ),
    );
  }



  Widget processFoodForHistoryDetailsPage(List<OrderedItem> orderedItems){

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



  Widget displayOneExtraIngredientInRecite(NewIngredient oneIngredientForHistoryDetailsPage, int index,int quantity){

    print('oneIngredientForRecite.ingredientName: ${oneIngredientForHistoryDetailsPage.ingredientName}');

    if(oneIngredientForHistoryDetailsPage.isDefault==false) {

      print(' oneIngredientForHistoryDetailsPage.isDefault==false  : ${oneIngredientForHistoryDetailsPage.isDefault==false} ==> '
          'oneIngredientForHistoryDetailsPage.ingredientName => ${oneIngredientForHistoryDetailsPage.ingredientName}');
      return

        Container(
          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneIngredientForHistoryDetailsPage.ingredientName == null) ||
              (oneIngredientForHistoryDetailsPage.ingredientName.length == 0)) ?
          '----' : oneIngredientForHistoryDetailsPage.ingredientName.length > 18 ?
          oneIngredientForHistoryDetailsPage.ingredientName.substring(0, 15) + '...' :
          oneIngredientForHistoryDetailsPage.ingredientName}, ',
            /*
              Text(
                '${oneIngredientForRecite.ingredientName}', */

            textAlign: TextAlign.left,
            style: TextStyle(
//                fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 17,
//                fontFamily: 'Itim-Regular',
            ),



          ),
        );
    }
    else return Text('Null');
  }

  Widget displayOneExtraSauceItemInRecite(SauceItem oneSauceItemForHistoryDetailsPage, int index,int quantity){

    print('oneSauceItemForRecite.ingredientName: ${oneSauceItemForHistoryDetailsPage.sauceItemName}');

    if(oneSauceItemForHistoryDetailsPage.isDefaultSelected !=true) {
      return

        Container(
          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneSauceItemForHistoryDetailsPage.sauceItemName == null) ||
              (oneSauceItemForHistoryDetailsPage.sauceItemName.length == 0)) ?
          '---' : oneSauceItemForHistoryDetailsPage.sauceItemName.length > 18 ?
          oneSauceItemForHistoryDetailsPage.sauceItemName.substring(0, 15) + '...' :
          oneSauceItemForHistoryDetailsPage.sauceItemName}, ',
            /*
            Text(
                '${oneSauceItemForRecite.sauceItemName} ',
                */

            textAlign: TextAlign.left,
            style: TextStyle(
//              fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 20,
//              fontFamily: 'Itim-Regular',
            ),

          ),
        );
    }
    else return Text('Null');
  }


  Widget displayOneExtraCheeseItemInRecite(CheeseItem oneCheeseItemForHistoryDetailsPage, int index,int quantity){

    print('oneCheeseItemForRecite.ingredientName: ${oneCheeseItemForHistoryDetailsPage.cheeseItemName}');
    if(oneCheeseItemForHistoryDetailsPage.isDefaultSelected !=true) {
      return
        Container(

          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneCheeseItemForHistoryDetailsPage.cheeseItemName == null) ||
              (oneCheeseItemForHistoryDetailsPage.cheeseItemName.length == 0)) ?
          '---' : oneCheeseItemForHistoryDetailsPage.cheeseItemName.length > 18 ?
          oneCheeseItemForHistoryDetailsPage.cheeseItemName.substring(0, 15) + '...' :
          oneCheeseItemForHistoryDetailsPage.cheeseItemName}, ',
            textAlign: TextAlign.left,
            style: TextStyle(
//              fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 20,
//              fontFamily: 'Itim-Regular',
            ),

          ),
        );
    }
    else return Text('Null');
  }

// DUMMY RECITE RELATED PRINT CODES ARE HERE ==> LINE # 11264 ==>

//  showExtraIngredients(oneFood.selectedIngredients)
//  showExtraCheeseItems(oneFood.selectedCheeses)
//  showExtraSauces(oneFood.defaultSauces)

  Widget showExtraIngredients(List <NewIngredient> historyDetailPageIngrdients,int quantity){

    print('reciteIngrdients.length: ${historyDetailPageIngrdients.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
//      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageIngrdients.length,


      itemBuilder: (_,int index) {
        return displayOneExtraIngredientInRecite(historyDetailPageIngrdients[index], index,quantity);
      },

    );

  }


  Widget showExtraCheeseItems(List<CheeseItem> historyDetailPageCheeseItems,int quantity){
    print('reciteCheeseItems.length: ${historyDetailPageCheeseItems.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageCheeseItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraCheeseItemInRecite(historyDetailPageCheeseItems[index], index,quantity);
      },
    );
  }

  Widget showExtraSauces(List<SauceItem> historyDetailPageSauceItems,int quantity){
    print('reciteSauceItems.length: ${historyDetailPageSauceItems.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageSauceItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraSauceItemInRecite(historyDetailPageSauceItems[index], index,quantity);
      },
    );
  }





  Widget displayCustomerInformationWidget(CustomerInformation customerForHistoryDetailsPage){



    print('customerForHistoryDetailsPage.address:  ===  ===>  ${customerForHistoryDetailsPage.address} |  |  |  |  |  |  |  |');

    return



// ADDRESS: BEGINS HERE.

      Column(
        children: [

          ((customerForHistoryDetailsPage.address!='')) ?

          Container(
            margin:EdgeInsets.fromLTRB(15,15,5,10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Row(
                  children: [
                    Text('address: ',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                        fontFamily: 'Itim-Regular',
                      ),
                    ),

                    Text(
                      '${((customerForHistoryDetailsPage.address == null) ||
                          (customerForHistoryDetailsPage.address.length == 0)) ?
                      '----' : customerForHistoryDetailsPage.address.length > 21 ?
                      customerForHistoryDetailsPage.address.substring(0, 18) + '_ _' :
                      customerForHistoryDetailsPage.address}',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                        fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text('Flat: ',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//      fontFamily: 'Itim-Regular',
                      ),
                    ),

// 2 ends here.
                    Text('${customerForHistoryDetailsPage.flatOrHouseNumber}',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ],
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'phone: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 22,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${customerForHistoryDetailsPage.phoneNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 22,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

          ):
          Container(
//            alignment: Alignment.center,

            margin:EdgeInsets.fromLTRB(15,15,5,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  'phone: ',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  '${customerForHistoryDetailsPage.phoneNumber}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),

              ],
            ),
          ),

// PHONE: ENDS HERE.
        ],
      );

  }
}


//  FoodDetailImage









//LongHeaderPainterAfterShoppingCartPage
class LongHeaderPainterAfterShoppingCartPage extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfterShoppingCartPage(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/1.6, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff707070)
//          Colors.white
      ..strokeWidth = 1.6;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}
