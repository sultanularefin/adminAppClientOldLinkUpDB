//food_gallery.dart

// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
//import 'package:foodgallery/src/BLoC/app_bloc.dart';
//import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
//import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';
//import 'file:///C:/Users/Taxi/Progrms/linkup/lib/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';
//import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
//import 'package:foodgallery/src/screens/foodGallery/UNPaidPage.dart';
//import 'package:foodgallery/src/screens/shoppingCart/ShoppingCart.dart';
import 'package:logger/logger.dart';
//import 'package:neumorphic/neumorphic.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImageSmaller.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/MyBullet.dart';

//sizeConstantsList

// SCREEN FILES AND MODLE FILES AND UTILITY FILES.
//import 'package:foodgallery/src/screens/ingredients_more/more_ingredients.dart';
//import 'package:foodgallery/src/DataLayer/IngredientItem.dart';
//import 'package:foodgallery/src/DataLayer/SizeConstants.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
//import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import './../../DataLayer/itemData.dart';

//import './../../shared/category_Constants.dart' as Constants;

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';

final Firestore firestore = Firestore();

class FoodItemDetails2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;
//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(

  FoodItemDetails2({Key key, this.child}) : super(key: key);
  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState();

//  _FoodItemDetailsState createState() => _FoodItemDetailsState();

}

class _FoodItemDetailsState extends State<FoodItemDetails2> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  String _currentSize;
//  int _itemCount= 0;
  double priceBySize = 0.0;
  double priceBasedOnCheeseSauceIngredientsSizeState = 0.0;

  List<String> allSubGroups1 = new List<String>();

//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false

  @override
  void initState() {
    setallSubgroups();

    super.initState();
  }

  Future<void> setallSubgroups() async {
    debugPrint("Entering in retrieveIngredients1");
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    List<String> allSubGroups2 = blocD.getAllSubGroups;

    print('done: ');

    setState(() {
      allSubGroups1 = allSubGroups2;
    });
  }

  double tryCast<num>(dynamic x, {num fallback}) {
//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if (status) {
      return x.toDouble();
    }

    if (x is int) {
      return x.toDouble();
    } else if (x is double) {
      return x.toDouble();
    } else
      return 0.0;
  }

  bool showUnSelectedIngredients = false;
  bool showPressWhenFinishButton = false;

  @override
  Widget build(BuildContext context) {
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return Container(
        child: StreamBuilder<FoodItemWithDocIDViewModel>(
            stream: blocD.currentFoodItemsStream,
            initialData: blocD.currentFoodItem,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new LinearProgressIndicator());
              } else {
                //   print('snapshot.hasData FDetails: ${snapshot.hasData}');

                final FoodItemWithDocIDViewModel oneFood = snapshot.data;

                final Map<String, dynamic> foodSizePrice =
                    oneFood.sizedFoodPrices;

                priceBasedOnCheeseSauceIngredientsSizeState =
                    oneFood.priceBasedOnCheeseSauceIngredientsSize;

                priceBySize = oneFood.itemPriceBasedOnSize;

                _currentSize = oneFood.itemSize;

                return GestureDetector(
                  onTap: () {
                    print('s');
                    print('navigating to FoodGallery 2 again with block');

                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
//                  Navigator.pop(context);

                    }

                    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD =
//                          BlocProvider2.of(context).getFoodItemDetailsBlockObject;

                    SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

                    print('temp is $temp');

                    print(
                        'temp.selectedIngredients: ${temp.selectedIngredients}');
                    print(
                        'temp.selectedCheeseItems: ${temp.selectedCheeseItems}');
                    print(
                        'temp.selectedSauceItems:  ${temp.selectedSauceItems}');

                    print('temp.unitPrice:  ${temp.unitPrice}');
                    print('temp.unitPriceWithoutCheeseIngredientSauces: '
                        ' ${temp.unitPriceWithoutCheeseIngredientSauces}');
                    print('temp.quantity:  ${temp.quantity}');

                    print('temp.foodItemSize:  ${temp.foodItemSize}');
                    print('temp.subTotalPrice:  ${temp.subTotalPrice}');

                    SelectedFood tempSelectedFood = (temp == null)
                        ? new SelectedFood()
                        : temp /*.selectedFoodInOrder.first*/;

                    print(
                        'CLEAR SUBSCRIPTION ... before going to food gallery page..');
                    blocD.clearSubscription();

                    return Navigator.pop(context, tempSelectedFood);
                  },
                  child: Scaffold(
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
                            child: Container(
                              // FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
                              width: displayWidth(context) / 1.01,

                              child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 1000),
//
                                  child: showUnSelectedIngredients
                                      ? otherView(
                                          oneFood, /*unSelectedIngredients*/
                                        )
                                      : initialView(oneFood, foodSizePrice)),
                            ),
//
                          )),
                    ),
                  ),
                );
              }
            }));
//    }
  }

  Widget otherView(
    FoodItemWithDocIDViewModel oneFood,
    /*List<NewIngredient> unselectedOnly */
  ) {
//    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return Container(
        height: displayHeight(context) -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,

//        height: displayHeight(context) / 7 +
//            displayHeight(context) / 6.6 +
//            displayHeight(context)/2.5 +
//            50 +
//            displayHeight(context)/18 +
//            displayHeight(context)/18,

        // FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
        width: displayWidth(context) / 1.01,
//                  color:Colors.lightGreen,
        margin: EdgeInsets.fromLTRB(0, displayHeight(context) / 16, 10, 5),

        //      color:Colors.white,
//      height: displayHeight(context) / 2.1,
//                                  color:Colors.yellow,
//                                    duration: Duration(seconds: 1),

        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
//                                    color: Colors.purple,
          color: Colors.white,
        ),
        child: Neumorphic(
          curve: Neumorphic.DEFAULT_CURVE,
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            depth: 8,
            lightSource: LightSource.topLeft,
            color: Colors.white,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.all(Radius.circular(5)),
            ),
          ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(

          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
//                                            color: Colors.redAccent,
                  color: Colors.white,
                  height: displayHeight(context) / 18,
//                                              width: displayWidth(context)*0.57,
//                  width: displayWidth(context)/2.4 ,
                  width: displayWidth(context) / 1.01,

//                  RRRR HHHHH
                  // /1.07 is the width of this
                  // uppper container.

                  child:
                      // YELLOW NAME AND PRICE BEGINS HERE.
                      Row(
                    children: [
                      Container(
                        width: displayWidth(context) /
                            2.2 /*+  displayWidth(context)/8 */,

                        decoration: BoxDecoration(
                          color: Color(0xffFFE18E),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10)),
//
                        ),

                        height: displayHeight(context) / 18,
//                                          height: displayHeight(context)/40,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: displayWidth(context) / 3.9,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text('${oneFood.itemName}',
                                  //.toUpperCase(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                    fontFamily: 'poppins',
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 0.0,
                                  right: 10.0,
                                  top: 0.0,
                                  bottom: 0.0),
                              padding: EdgeInsets.fromLTRB(
                                  0, 4, displayWidth(context) / 40, 0),
                              child: Text(
                                  '${priceBasedOnCheeseSauceIngredientsSizeState.toStringAsFixed(2)}' +
                                      '\u20AC',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                    color: Colors.black,
                                    fontFamily: 'poppins',
                                  )),
                            ),
                          ],
                        ),
                      ),

                      // multiselect portion... begins here.

                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                                      padding::::
                        color: Colors.white,
//                        color:Colors.blue,
                        width: displayWidth(context) / 2,
                        height: displayHeight(context) / 20,
//                                                  width: displayWidth(context) /1.80,

//                                                      Card(child: _buildMultiSelectOptions()),

                        // Text('_buildMultiSelectOptions()')
                      ),

                      // multiselect portion...ends here.
                    ],
                  ),
                ),

//          ;;;;;;;

//MULTI SELECT ROW ---> BEGINS HERER....
                Row(
                  children: [
                    Container(
                      width: displayWidth(context) /
                          2.4 /*+  displayWidth(context)/8 */,
                      height: displayHeight(context) / 29,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                                      padding::::
//                        color:Colors.white,
//                      color:Colors.blue,
                      width: displayWidth(context) / 1.9,
                      height: displayHeight(context) / 29,
//                                                  width: displayWidth(context) /1.80,
                      child: _buildMultiSelectOptions(),
//                                                      Card(child: _buildMultiSelectOptions()),

                      // Text('_buildMultiSelectOptions()')
                    ),
                  ],
                ),

                //MULTI SELECT ROW ---> BEGINS HERER....

//                SizedBox(height: 50,),
//              smallIMage and others in a row begins here=>

                // 2nd ROW CONTAINING IMAGE CONTAINER
                // AS ONE CHILD AND SIZED COMPONENTS ADN
                // DEFAULT INGREDIENTS IN ANOTHER PLACE.
                Container(
//                                            color:Colors.deepPurpleAccent,
                    height: displayHeight(context) / 7,
//                        displayHeight(context) / 6.6,
//                    height: displayHeight(context) / 7 +
//                        displayHeight(context) / 6.6,

//                displayHeight(context)/2.5
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // THIS ROW HAVE 2 PARTS -> 1ST PART HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                        // , 2ND PART(ROW) HANDLES THE
                        // DIFFERENT SIZES OF PRODUCTS. BEGINS HERE.

                        Container(
//                          color:Colors.red,
                          width: displayWidth(context) / 5.4,

                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                          child: FoodDetailImageSmaller(
                              oneFood.imageURL, oneFood.itemName),
                        ),

                        // SIZED COMPONENTS AND
                        // DEFAULT INGREDIENTS IN ANOTHER PLACE. BEGINS.
                        // HERE.

                        // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, BEGINS HERE:

                        Container(
//                          color:Colors.pink,

                          width: displayWidth(context) / 3.5,
//                                                    width: displayWidth(context) /1.80,
                          //  width: displayWidth(context) /1.80, aLSO MULITISELECT WIDTH 1.80
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //pppp

                              _buildOneSizeForOtherView(_currentSize,
                                  priceBasedOnCheeseSauceIngredientsSizeState),

                              animatedWidgetPressToFinish(),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              left: 0.0, top: 30.0, right: 0.0, bottom: 0.0),
                          width: displayWidth(context) / 2.13,
//                                                    width: displayWidth(context) /1.80,
                          //  width: displayWidth(context) /1.80, aLSO MULITISELECT WIDTH 1.80
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //pppp
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
//                                      color:Colors.blue,
//                                                            height: displayHeight(context) / 10,
//                                       height: displayHeight(context) / 30,
                                      height: displayHeight(context) / 30,
                                      width: displayWidth(context) / 2.39,
                                      child:
                                          selectedIngredientsNameOnly(context)
                                      //Text('buildDefaultIngredients('
                                      //    'context'
                                      //')'),
                                      ),
                                ],
                              ),

                              // 'CHEESE BEGINS HERE.

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
//                                                            height: displayHeight(context) / 10,
                                          height: displayHeight(context) / 23,
                                          width: displayWidth(context) / 4.39,
                                          child:
                                              buildSelectedCheeseItemsNameOnly(
                                                  context)
                                          //Text('buildDefaultIngredients('
                                          //    'context'
                                          //')'),
                                          ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),

                /*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */

                //smallImage and other's in a row ends here ==>

//              ark

//UNSELECTED INGREDIENTS BEGINS HERE..
                Container(
//                  color:Colors.indigoAccent,

                  height: displayHeight(context) / 1.5,
                  /*-
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
*/
                  width: displayWidth(context) / 1.01,

                  margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 20),

                  child: _buildSubGroups(),
                  //        }

                  //        else {
                  //          return Container(child: Text('no extra ingredients'),);
                  //        }
                ),
              ]),
        ));
  }

  Widget initialView(
      FoodItemWithDocIDViewModel oneFood, Map<String, dynamic> foodSizePrice) {
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return Container(
//      color:Colors.white,
//      height: displayHeight(context) / 2.1,
//                                  color:Colors.yellow,
//                                    duration: Duration(seconds: 1),
      height: displayHeight(context) -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom,

      // FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
      width: displayWidth(context) / 1.01,
//                  color:Colors.lightGreen,
      margin: EdgeInsets.fromLTRB(0, displayHeight(context) / 16, 10, 5),

      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
//                                    color: Colors.purple,
        color: Colors.white,
      ),

      child: Neumorphic(
        curve: Neumorphic.DEFAULT_CURVE,
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          depth: 8,
          lightSource: LightSource.topLeft,
          color: Colors.white,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.all(Radius.circular(5)),
          ),
        ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
//                                            color: Colors.redAccent,
              color: Colors.white,
              height: displayHeight(context) / 18,
//                                              width: displayWidth(context)*0.57,
//              width: displayWidth(context)/2.4 ,
              width: displayWidth(context) / 1.07,
              // /1.07 is the width of this
              // uppper container.

              child:
                  // YELLOW NAME AND PRICE BEGINS HERE.
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: displayWidth(context) / 2.8,

                    decoration: BoxDecoration(
                      color: Color(0xffFFE18E),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(10)),
//
                    ),

                    height: displayHeight(context) / 18,
//                                          height: displayHeight(context)/40,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: displayWidth(context) / 4.4,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text('${oneFood.itemName}',
                              //.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontFamily: 'poppins',
                              )),
                        ),
                        Container(
//                          color:Colors.yellow,
                          padding: EdgeInsets.fromLTRB(
                              0, 4, displayWidth(context) / 40, 0),
                          child: Text(
                              '${priceBasedOnCheeseSauceIngredientsSizeState.toStringAsFixed(2)}' +
//                              '${priceBasedOnCheeseSauceIngredientsSizeState.toStringAsFixed(2)}12' +
                                  '\u20AC',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                color: Colors.black,
                                fontFamily: 'poppins',
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
//                    color:Colors.green,
                    width: displayWidth(context) / 2.1,
                    height: displayHeight(context) / 18,
//                    height: displayHeight(context)/20,
                  )
                ],
              ),

            ),

            // multiselect portion... begins here.
            Container(
//                                            alignment: Alignment.centerRight,

//               color: Colors.lightBlue,
              height: displayHeight(context) / 24,

              width: displayWidth(context) / 1.07,
              child:
                  // YELLOW NAME AND PRICE BEGINS HERE.
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
//                                                  color:Colors.green,
                    width: displayWidth(context) / 2.9,
                    height: displayHeight(context) / 24,
                  ),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    margin: EdgeInsets.fromLTRB(0, 3, 0, 2),

//                                                      padding::::
//                    color:Colors.redAccent,
                    width: displayWidth(context) / 2,
//                    height: displayHeight(context)/20,

                    height: displayHeight(context) / 22,
//                                                  width: displayWidth(context) /1.80,
                    child: _buildMultiSelectOptionsInitialView(),
//                                                      Card(child: _buildMultiSelectOptions()),

                    // Text('_buildMultiSelectOptions()')
                  ),
                ],
              ),
            ),
            // multiselect portion...ends here.

            SizedBox(height: 10),

            Container(
//              color: Colors.lightBlue,
              height: displayHeight(context) / 8,

              width: displayWidth(context) / 1.07,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
//                                                  color:Colors.green,
                    width: displayWidth(context) / 3.9,
                    height: displayHeight(context) / 20,
                  ),
                  Container(
//                                                                  color: Colors.pink,

                      padding: EdgeInsets.fromLTRB(
                          0, 10, displayWidth(context) / 40, 5),
                      height: displayHeight(context) / 8.8,
//                                                        width: displayWidth(context) /1.80,
                      width: displayWidth(context) / 1.07 -
                          displayWidth(context) / 3.9,
                      child: _buildProductSizes(context, foodSizePrice)
                      //Text('_buildProductSizes('
                      //    'context,'
                      //    'foodSizePrice)'),
                      ),
                ],
              ),
            ),

            // 2nd ROW CONTAINING IMAGE CONTAINER
            // AS ONE CHILD AND SIZED COMPONENTS ADN
            // DEFAULT INGREDIENTS IN ANOTHER PLACE.
            Container(

//                                              color:Colors.deepPurpleAccent,
                width:
                    displayWidth(context) / 2.49 + displayWidth(context) / 1.91,
//                                              height: displayHeight(context) / 7 +
//                                                  displayHeight(context) / 6.6
//                                                  + displayHeight(context) / 8,

                height: displayHeight(context) / 1.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // THIS ROW HAVE 2 PARTS -> 1ST PART HANDLES THE IMAGES, SOME HEADING TEXT(PRICE AND NAME)
                    // , 2ND PART(ROW) HANDLES THE
                    // DIFFERENT SIZES OF PRODUCTS. BEGINS HERE.

                    Container(
//                                                    width: displayWidth(context)/4,
                      width: displayWidth(context) / 2.49,
//                                                    width: displayWidth(context)/3.29,
//                      color:Colors.blue,
                      child: Container(
                        height: displayHeight(context) / 2.1,
//                       color: Colors.red,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                        child:
                            FoodDetailImage(oneFood.imageURL, oneFood.itemName),

                        //),
                      ),
                    ),

                    // SIZED COMPONENTS AND
                    // DEFAULT INGREDIENTS IN ANOTHER PLACE. BEGINS.
                    // HERE.

                    // 2ND ROW, FOR FOR OTHER ITEMS, WILL BE A COLUMN ARRAY, BEGINS HERE:

                    Container(
//                      color:Colors.purpleAccent,
                      height: displayHeight(context) / 2.1,

                      /*
                      height: displayHeight(context) / 7 +
                          displayHeight(context) / 6.6
                          + displayHeight(context) / 8,
                      */

                      width: displayWidth(context) / 1.91,
//                                                    width: displayWidth(context) /1.49,
//                                                    width: displayWidth(context) /1.80,
                      //  width: displayWidth(context) /1.80, aLSO MULITISELECT WIDTH 1.80
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          //pppp

//                                  Text('ss'),

//                          SizedBox(height: 40,),
                          Container(
                            width: displayWidth(context) / 1.6,
                            height: displayHeight(context) / 40,
//                            color:Colors.lightGreenAccent,

//                            color: Color(0xffffffff),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: Text(
//                                        'Täytteet'.toUpperCase(),
                                        'ingredients'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                      )),

                                  /*
                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongHeaderPainterAfterShoppingCartPage(
                                        context),
                                  ),

                                  */
                                ]),
                          ),

                          Container(
                            child: Column(
                              children: [
                                Container(
//                                                            height: displayHeight(context) / 13,
                                    height: displayHeight(context) / 11,
                                    width: displayWidth(context) / 1.50,
//                                                            width: displayWidth(context) * 0.57,
//                                                            color: Color(0xfff4444aa),
//                                                            color:Colors.lightBlueAccent,
//                                                        alignment: Alignment.center,
                                    child: buildDefaultIngredients(context)
                                    //Text('buildDefaultIngredients('
                                    //    'context'
                                    //')'),
                                    ),
                                Container(
//
                                  height: displayHeight(context) / 35,
                                  width: displayWidth(context) / 1.50,
//
                                ),
                              ],
                            ),
                          ),

//                          SizedBox(height: 40,),
                          // 'CHEESE BEGINS HERE.
                          Container(
                            width: displayWidth(context) / 1.4,
                            height: displayHeight(context) / 40,
                            color: Color(0xffffffff),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: Text(
//                                        'juusto'.toUpperCase(),

                                        'cheeses'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                      )),

                                  /*
                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongHeaderPainterAfterShoppingCartPage(
                                        context),
                                  ),

                                  */
                                ]),
                          ),

                          Container(
                            child: Column(
                              children: [
                                Container(
                                    height: displayHeight(context) / 11,
                                    width: displayWidth(context) / 1.50,
                                    child: buildCheeseItems(context)),
                                Container(
                                  height: displayHeight(context) / 20,
                                  width: displayWidth(context) / 1.50,
                                ),
                              ],
                            ),
                          ),

//                          SizedBox(height: 40,),

                          Container(
                            width: displayWidth(context) / 1.6,
                            height: displayHeight(context) / 40,
//                            color: Color(0xffffffff),
//                            color:Colors.blue,

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: Text(
//                                        'kastike'.toUpperCase(),
                                        'sauces'.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18,
                                          fontFamily: 'poppins',
                                          color: Colors.black,
                                        ),
                                      )),

                                  /*
                                  CustomPaint(
                                    size: Size(0, 19),
                                    painter: LongHeaderPainterAfterShoppingCartPage(
                                        context),
                                  ),

                                  */
                                ]),
                          ),

                          Container(
                            child: Column(
                              children: [
                                Container(
                                  height: displayHeight(context) / 11,
                                  width: displayWidth(context) / 1.50,
                                  child: buildSauceItems(context),
                                ),
                                Container(
                                  height: displayHeight(context) / 43,
                                  width: displayWidth(context) / 1.50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),

            Container(
              width: displayWidth(context) / 1.01,
//                height: 45,
//              height: displayHeight(context) / 19,
//              margin:EdgeInsets.fromLTRB(10, 0, 0, 10),
//              color:Colors.lightGreenAccent,
//VVVVV
//                                            color:Color(0xffC27FFF)
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

//                      color:Colors.lightGreenAccent,
//                  margin: EdgeInsets.only(right: 10),
                      child: animatedWidgetMoreIngredientsButton()),
                  Container(
//                  margin: EdgeInsets.fromLTRB(20,0,0,0),
//                  color:Colors.lightBlueAccent,
                    child: StreamBuilder<SelectedFood>(
                        stream: blocD.getCurrentSelectedFoodStream,
                        initialData: blocD.getCurrentSelectedFoodDetails,
                        builder: (context, snapshot) {
                          if ((snapshot.hasError) || (!snapshot.hasData)) {
                            return Center(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('WRNG'),
                              ),
                            );
                          } else {
                            SelectedFood incrementCurrentFoodProcessing =
                                snapshot.data;

                            int itemCountNew;

                            print(
                                'incrementCurrentFoodProcessing==null ${incrementCurrentFoodProcessing == null}');

                            if (incrementCurrentFoodProcessing == null) {
                              itemCountNew = 0;
                            } else {
                              itemCountNew =
                                  incrementCurrentFoodProcessing.quantity;
                            }

                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),

                              width: displayWidth(context) / 4,
//                height: 45,
                              height: displayHeight(context) / 21,

//                                            color:Color(0xffC27FFF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // todo shopping.

//                                                                          SizedBox(
//
//                                                                            width: 3,
//                                                                          ),
                                  // WORK 1
//TTTTT
                                  Container(
                                    width: displayWidth(context) / 12,
                                    height: displayHeight(context) / 22,
                                    child: OutlineButton(
                                      padding: EdgeInsets.all(0),
                                      splashColor: Colors.indigoAccent,
                                      highlightElevation: 12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),

                                      borderSide: BorderSide(
                                        color: Colors.grey,
//                                        color:Color(0xff707070),
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                      ),

                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Color(0xffF50303),
                                        size: 48,
                                      ),
//                                                                            icon: Icon(Icons.remove),
//                                      iconSize: 48,
//                                      tooltip: 'Decrease product count by 1',
                                      onPressed: () {
                                        final foodItemDetailsbloc = BlocProvider
                                            .of<FoodItemDetailsBloc>(context);
                                        print(
                                            'Decrease button pressed related to _itemCount');
                                        if (itemCountNew >= 1) {
//                                if (itemCountNew == 1) {
                                          print('itemCountNew== $itemCountNew');

                                          foodItemDetailsbloc
                                              .decrementOneSelectedFoodForOrder(
                                                  itemCountNew);
                                        }
                                      },
//                              size: 24,
                                      color: Colors.grey,
//                                      color: Color(0xff707070),
                                    ),
                                  ),

                                  Container(
//
//                                                                        width:60,
                                    width: displayWidth(context) / 12,
                                    height: displayHeight(context) / 22,

                                    decoration: BoxDecoration(
                                      border: Border.all(
//                    color: Colors.black,
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                      ),
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      itemCountNew.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: displayWidth(context) / 12,
                                    height: displayHeight(context) / 22,
                                    child: OutlineButton(
                                      padding: EdgeInsets.all(0),
                                      splashColor: Colors.indigoAccent,
                                      highlightElevation: 12,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),

                                      borderSide: BorderSide(
                                        color: Colors.grey,
//                                        color:Color(0xff707070),
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                      ),

                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xff85B20A),
                                        size: 48,
                                      ),
//                                      iconSize: 48,

//                                      tooltip: 'Increase product count by 1 ',
                                      onPressed: () {
//                            final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

//                              incrementOrderProcessing.selectedFoodInOrder.isEmpty

                                        SelectedFood
                                            incrementCurrentFoodProcessing =
                                            snapshot.data;
//                              Order incrementOrderProcessing = snapshot.data;
//                              int lengthOfSelectedItemsLength = incrementOrderProcessing.selectedFoodListLength;

                                        if (incrementCurrentFoodProcessing
                                                .quantity ==
                                            0) {
                                          print(
                                              ' JJJJ at lengthOfSelectedItemsLength  == 0 ');

                                          print(
                                              'itemCountNew JJJJ $itemCountNew');

                                          int initialItemCount = 0;

                                          int quantity = 1;
                                          // INITIAL CASE FIRST ITEM FROM ENTERING THIS PAGE FROM FOOD GALLERY PAGE.
                                          SelectedFood oneSelectedFoodFD =
                                              new SelectedFood(
                                            foodItemName:
                                                blocD.currentFoodItem.itemName,
                                            foodItemImageURL:
                                                blocD.currentFoodItem.imageURL,
                                            unitPrice:
                                                priceBasedOnCheeseSauceIngredientsSizeState,
                                            unitPriceWithoutCheeseIngredientSauces:
                                                priceBySize,
                                            foodDocumentId: blocD
                                                .currentFoodItem.documentId,
                                            quantity: quantity,
                                            foodItemSize: _currentSize,
                                            categoryName: blocD
                                                .currentFoodItem.categoryName,
//                                                                                discount:blocD
//                                                                                    .currentFoodItem.discount,
                                            // index or int value not good enought since size may vary best on Food Types .
                                          );

                                          blocD
                                              .incrementOneSelectedFoodForOrder(
                                                  oneSelectedFoodFD,
                                                  initialItemCount);
                                        } else {
                                          print(' at else RRRRR');

//                                itemCountNew = incrementOrderProcessing
//                                    .selectedFoodInOrder[lengthOfSelectedItemsLength-1]
//                                    .quantity;

                                          int oldQuantity =
                                              incrementCurrentFoodProcessing
                                                  .quantity;
//                                int oldQuantity = incrementOrderProcessing.
//                                selectedFoodInOrder[lengthOfSelectedItemsLength-1].quantity;

                                          int newQuantity = oldQuantity + 1;

                                          SelectedFood oneSelectedFoodFD =
                                              new SelectedFood(
                                            foodItemName:
                                                blocD.currentFoodItem.itemName,
                                            foodItemImageURL:
                                                blocD.currentFoodItem.imageURL,
                                            unitPrice:
                                                priceBasedOnCheeseSauceIngredientsSizeState,
//                                                                                unitPrice: priceBasedOnCheeseSauceIngredientsSizeState,
                                            unitPriceWithoutCheeseIngredientSauces:
                                                priceBySize,
                                            foodDocumentId: blocD
                                                .currentFoodItem.documentId,
                                            quantity: newQuantity,
                                            foodItemSize: _currentSize,
                                            categoryName: blocD
                                                .currentFoodItem.categoryName,
//                                                                                discount:blocD
//                                                                                    .currentFoodItem.discount,
                                            // index or int value not good enought since size may vary best on Food Types .
                                          );

                                          //incrementCurrentFoodProcessing.quantity= newQuantity;

                                          // TODO TODO TODO.
                                          // TO DO SOME CODES CAN BE OMITTED HERE, LIKE WE DON'T NEED TO PASS THIS PARAMETER OR
                                          // NEITHER NEED TO RECREATE IT ABOVE, WE NEED TO PASS BUT NOT CREATE IT ABOVE.
                                          blocD.incrementOneSelectedFoodForOrder(
                                              oneSelectedFoodFD /*
                                              THIS oneSelectedFoodFD WILL NOT BE USED WHEN SAME ITEM IS INCREMENTED AND

                                              QUANTITY IS MORE THAN ONE.
                                              */
                                              ,
                                              oldQuantity);
                                        }
                                      },
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                  ),
                  Container(
//                      color: Colors.redAccent,
                      child: pressToContinueInitialDetailPage()),
                ],
              ),
            ),

            /*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */
          ],
        ),
      ),
    );
  }

  Widget animatedWidgetPressToFinish() {
    return RaisedButton(
        color: Colors.blue,
        highlightColor: Color(0xff525FFF),
        splashColor: Color(0xffB47C00),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        highlightElevation: 12,
        child: Container(
          width: displayWidth(context) / 3.8,
          height: displayHeight(context) / 24,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
//                'jatka'.toUpperCase(),
                'continue shopping'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
//

          final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//            final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//            final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
          blocD.finishMoreDefaultIngredientItems(/*oneSelected,index*/);

          setState(() {
            showUnSelectedIngredients = !showUnSelectedIngredients;
            showPressWhenFinishButton = !showPressWhenFinishButton;

//                ::::A
//                          myAnimatedWidget1 = myAnimatedWidget2;
          });
        });
  }

  Widget continueShoppingButton() {
    ///sdfsdfsdf
    return RaisedButton(
        color: Color(0xff5D9EFF),
        highlightColor: Color(0xff525FFF),
        splashColor: Color(0xffB47C00),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        highlightElevation: 12,
        child: Container(
          width: displayWidth(context) / 4,
          height: displayHeight(context) / 24,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //  SizedBox(width: 5,),

              Text(
//                'jatka'.toUpperCase(),
                'continue shopping'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
//                    color: Color(0xffF50303),
                  color: Colors.white,
                  fontSize: 18, fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

          SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

          logger.i('temp.multiSelct.length: ${temp.multiSelct.length}');

          print('temp.unitPrice:  ${temp.unitPrice}');
          print('temp.unitPriceWithoutCheeseIngredientSauces: '
              ' ${temp.unitPriceWithoutCheeseIngredientSauces}');
          print('temp.quantity:  ${temp.quantity}');

          print('temp.foodItemSize:  ${temp.foodItemSize}');
          print('temp.subTotalPrice:  ${temp.subTotalPrice}');

          SelectedFood tempSelectedFood = (temp == null)
              ? new SelectedFood()
              : temp /*.selectedFoodInOrder.first*/;

          // WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
          // WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
          // FROM FOOD ITEM PAGE.

          print('CLEAR SUBSCRIPTION ... before going to food gallery page..');
          blocD.clearSubscription();

          return Navigator.pop(context, tempSelectedFood);
        });
  }

  Widget moreIngredientsButton() {
    ///sdfsdfsdf
    return RaisedButton(
        color: Color(0xffFCF5E4),
        highlightColor: Color(0xff525FFF),
        splashColor: Color(0xffB47C00),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        highlightElevation: 12,
        child: Container(
          width: displayWidth(context) / 4,
          height: displayHeight(context) / 24,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
//                'lisä täytteet'.toUpperCase(),
                'more ingredients'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'poppins',
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
//                                                                        logger.i('s  =>   =>   => ','ss');

          setState(() {
            // toggle..
            showUnSelectedIngredients = !showUnSelectedIngredients;
            showPressWhenFinishButton = !showPressWhenFinishButton;
//                        myAnimatedWidget2 = myAnimatedWidget1();
          });
          print('xyz');
        });
  }

  Widget pressToContinueInitialDetailPage() {
    return Container(
      width: displayWidth(context) / 4,
//            child: moreIngredientsButton(),

      child: continueShoppingButton(),
    );
  }

  Widget animatedWidgetMoreIngredientsButton() {
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
    return Container(
//            width:displayWidth(context)/3.5,
      width: displayWidth(context) / 4,

      child: moreIngredientsButton(),
      /*AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
//
              child: showPressWhenFinishButton? animatedWidgetPressToFinish():
              moreIngredientsButton(),
              // Text('showPressWhenFinishButton? animatedWidgetPressToFinish():'
              //     'animatedWidgetMoreIngredientsButton(),'),

            ),

            */
    );

    /*
          Container(
            width: displayWidth(
                context) /14,

            height: displayHeight(context)/25.4,
            child:
            IconButton(

              padding: EdgeInsets.symmetric(
                  horizontal: 0, vertical: 0),
              icon: Icon(
                Icons.check_circle,
                color: Color(0xff525FFF)
                ,
              ),
              iconSize: 48,

              tooltip: 'press to see the selected ingredients. ',

//                                                                        logger.i('s  =>   =>   => ','ss');
              onPressed: () {
//
                final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD =
//                          BlocProvider2.of(context).getFoodItemDetailsBlockObject;

                SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

                print('temp is $temp');



                SelectedFood tempSelectedFood = (temp == null)? new SelectedFood():
                temp /*.selectedFoodInOrder.first*/;



                // WE DON'T NEED TO CREATE THE ORDER OBJECT AND STORE SELECTED ITEMS, RATHER,
                // WE JUST NEED TO SENT THE SELECTED ITEM IN FOOD GALLERY PAGE.
                // FROM FOOD ITEM PAGE.




                return Navigator.pop(context,tempSelectedFood);

//
                print(
                    'finish button pressed');

              },

            ),


          ),

          */
  }

  int calculateHeightBySize(int length) {
    if (length <= 5) {
      return 1;
    } else if ((length > 5) && (length <= 10)) {
      return 2;
    } else if ((length > 10) && (length <= 15)) {
      return 3;
    } else
      return 4;
  }

  Widget _buildOneSubGroup(String subGroup, List<NewIngredient> unSelectedOnly,
      int lengthForHeight, int index) {
    print('unSelectedOnly.length: ${unSelectedOnly.length}');

    unSelectedOnly.forEach((oneIng) {
      print('oneIng name => : ${oneIng.ingredientName} \n');
    });

    List<NewIngredient> withCertainSubgropus = unSelectedOnly
        .where((e) =>
            (e.subgroup.toLowerCase().trim() == subGroup.toLowerCase().trim()))
        .toList();

    print('/ ?  /   ?   / ?   /   ?   /   ? ');

    print('subGroup: $subGroup');
    print('withCertainSubgropus.length: ${withCertainSubgropus.length}');

    return Container(
      margin: EdgeInsets.all(10.0),
      height: (((displayHeight(context) / 1.5) / lengthForHeight) *
          calculateHeightBySize(withCertainSubgropus.length)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(subGroup.toUpperCase(),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                )),
          ),
          Container(
//        color:Colors.purple,

            height: (calculateHeightBySize(withCertainSubgropus.length) == 1)
                ? ((displayHeight(context) / 2) / lengthForHeight)
                : (calculateHeightBySize(withCertainSubgropus.length) == 2)
                    ? ((((displayHeight(context) / 2) / lengthForHeight) + 15) *
                        2)
                    : (calculateHeightBySize(withCertainSubgropus.length) == 3)
                        ? ((((displayHeight(context) / 2) / lengthForHeight) +
                                15) *
                            3)
                        : ((((displayHeight(context) / 2) / lengthForHeight) +
                                15) *
                            4),

            child: GridView.builder(
              itemCount: withCertainSubgropus.length,
              itemBuilder: (_, int index) {
                return _buildOneUNSelected(withCertainSubgropus[index],
                    index /*, unSelectedIngredients*/
                    );
              },
              gridDelegate:
//                                            new SliverGridDelegateWithFixedCrossAxisCount(
//                                              crossAxisCount: 3,
                  new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                crossAxisSpacing: 23,
                childAspectRatio: 140 / 125,
                mainAxisSpacing: 23,
//                                  ///childAspectRatio:
//                                  /// The ratio of the cross-axis to the main-axis extent of each child.
//                                  /// H/V
                // horizontal / vertical
//                                              childAspectRatio: 280/360,
              ),
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubGroups() {
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

//    print('categoryWiseSubGroups.length: ${categoryWiseSubGroups.length}');
    return StreamBuilder(
        stream: blocD.getUnSelectedIngredientItemsStream,
        initialData: blocD.unSelectedIngredients,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: new LinearProgressIndicator());
          } else {
            List<NewIngredient> unSelectedIngredients = snapshot.data;

            print(
                '-------- unSelectedIngredients.length: ${unSelectedIngredients.length} ------------');

            return ListView.builder(
              scrollDirection: Axis.vertical,
//              reverse: true,
              shrinkWrap: false,
              itemCount: allSubGroups1.length,

              itemBuilder: (_, int index) {
                return _buildOneSubGroup(allSubGroups1[index],
                    unSelectedIngredients, allSubGroups1.length, index);
              },
            );
          }
        });
  }

  Widget _buildOneUNSelected(NewIngredient unSelectedOneIngredient, int index
      /*,
      List<NewIngredient> allUnSelected */
      ) {
    int currentAmount = unSelectedOneIngredient.ingredientAmountByUser;

    String imageURLFinalNotSelected = (unSelectedOneIngredient.imageURL == '')
        ? 'https://thumbs.dreamstime.com/z/smiling-orange-fruit-'
            'cartoon-mascot-character-holding-blank-sign-smiling-orange-'
            'fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        : storageBucketURLPredicate +
            Uri.encodeComponent(unSelectedOneIngredient.imageURL) +
            '?alt=media';

    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 0.2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//                              SizedBox(height: 10),

            Container(
              padding: EdgeInsets.only(top: 5),
              height: displayHeight(context) / 20,
              width: displayWidth(context) / 14,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageURLFinalNotSelected,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => new LinearProgressIndicator(),
                  errorWidget: (context, url, error) => Image.network(
                      'https://img.freepik.com/free-vector/404-error-design-with-donut_76243-30.jpg?size=338&ext=jpg'),
//                    https://img.freepik.com/free-vector/404-error-design-with-donut_76243-30.jpg?size=338&ext=jpg
//                    https://img.freepik.com/free-vector/404-error-page-found-with-donut_114341-54.jpg?size=626&ext=jpg

//                    errorWidget:(context,imageURLFinalNotSelected,'Error'),
                ),
              ),
            ),

            Container(
// TO Be
              padding: EdgeInsets.only(top: 5),
//          height:45, // same as the heidth of increment decrement button.
              width: displayWidth(context) / 6.5,
              height: displayHeight(context) / 55,
//              color:Colors.purple,
//              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                unSelectedOneIngredient.ingredientName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xff707070),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,

                  fontSize: 14,
                ),
              ),
            ),

            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- BELOW.
            Container(
              padding: EdgeInsets.only(top: 5),
//              color:Colors.deepOrangeAccent,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

//                                              height: displayHeight(context) *0.11,
              height: displayHeight(context) / 42,
              width: displayWidth(context) / 5.9,
              // same as the heidth of increment decrement button. // 45
              // later changed height to 40.

              /*
              decoration: BoxDecoration(
//                                              color: Colors.black54,
                color:Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(25),

              ),


*/
//                                            color:Color(0xffC27FFF),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: Icon(Icons.add),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {
                      print('Add button pressed in unselected Ing');

                      final blocD =
                          BlocProvider.of<FoodItemDetailsBloc>(context);
//                      final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//                      final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                      blocD.incrementThisIngredientItem(unSelectedOneIngredient);

//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
                    },
                    color: Color(0xff707070),
                  ),

//      double.parse(doc['priceinEuro'])
//          .toStringAsFixed(2);
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      currentAmount.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    icon: Icon(Icons.remove),
                    iconSize: 30,

//                      tooltip: 'Increase Ingredient count by 1',
                    onPressed: () {
                      print('Minus button pressed in unselected ing');
                      print('Decrease button pressed InkResponse');

                      if (currentAmount >= 1) {
//                      if(currentAmount>=2)
//                      City c1 = new City()..name = 'Blum'..state = 'SC';

                        final blocD =
                            BlocProvider.of<FoodItemDetailsBloc>(context);
//                        final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//                        final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
                        blocD.decrementThisIngredientItem(
                            unSelectedOneIngredient, index);

                        /*
                          setState(() {
                            // _ingredientlistUnSelected = allUnSelected;
                          });
                          */

//                      setState(() {
//                        _ingredientlistUnSelected= allUnSelected;
//                      });
                      } else {
                        print('decrease button pressed '
                            'but nothing will happen since it is less than 1');
                      }
                    },
                    color: Color(0xff707070),
                  ),
                ],
              ),
            ),
            // PROBLEM CONTAINER WITH ROW. INCREMENT DECREMENT FUNCTIONALITY. -- ABOVE.
          ],
        ));
  }

  Widget _buildMultiSelectOptionsInitialView() {
//   height: 40,
//   width: displayWidth(context) /2.5,

//    BlocProvider.of<FoodItemDetailsBloc>
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder(
        stream: blocD.getMultiSelectStream,
        initialData: blocD.getMultiSelectForFood,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Text('multiSelect option ! found.');
          } else {
            List<FoodPropertyMultiSelect> foodItemPropertyOptions =
                snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,

              reverse: true,
              shrinkWrap: true,

//              shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
              itemCount: foodItemPropertyOptions.length,

              itemBuilder: (_, int index) {
                return oneMultiSelectInDetailsPageInitialView(
                    foodItemPropertyOptions[index], index);
              },
            );
          }
        }

        // M VSM ORG VS TODO. ENDS HERE.
        );
  }

  Widget _buildMultiSelectOptions() {
//   height: 40,
//   width: displayWidth(context) /2.5,

//    BlocProvider.of<FoodItemDetailsBloc>
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder(
        stream: blocD.getMultiSelectStream,
        initialData: blocD.getMultiSelectForFood,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Text('multiSelect option ! found.');
          } else {
            List<FoodPropertyMultiSelect> foodItemPropertyOptions =
                snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,

              reverse: true,

              shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
              itemCount: foodItemPropertyOptions.length,

              itemBuilder: (_, int index) {
                return oneMultiSelectInDetailsPageOtherView(
                    foodItemPropertyOptions[index], index);
              },
            );
          }
        }

        // M VSM ORG VS TODO. ENDS HERE.
        );
  }

  Widget _buildProductSizes(
      BuildContext context, Map<String, dynamic> allPrices) {
    final Map<String, dynamic> foodSizePrice = allPrices;

    Map<String, dynamic> listpart1 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart2 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart3 = new Map<String, dynamic>();
    // odd

    int len = foodSizePrice.length;
    print('len: $len');

    for (int i = 0; i < len; i++) {
      print('i: $i');
      String keyTest = foodSizePrice.keys.elementAt(i);
      dynamic value = foodSizePrice.values.elementAt(i);

//
      double valuePrice = tryCast<double>(value, fallback: 0.0);

      if ((valuePrice != 0.0) && (valuePrice != 0.00)) {
        listpart1[keyTest] = valuePrice;
      }
    }

    if (allPrices == null) {
      return Container(
        height: displayHeight(context) / 9.8,
//          height:190,
        width: displayWidth(context) * 0.57,

        color: Color(0xFFffffff),
        alignment: Alignment.center,

        // PPPPP

        child: Text(
          'No prices found.'.toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Itim-Regular',
            color: Colors.white,
          ),
        ),
      );
    } else {
      return

          GridView.builder(
        itemCount: listpart1.length,
        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 10, // H  direction
          crossAxisSpacing: 20,
          childAspectRatio: 190 / 50, /* (h/vertical)*/
        ),
        shrinkWrap: true,

//        reverse: true,
        itemBuilder: (_, int index) {
          String key = listpart1.keys.elementAt(index);
          double valuePrice = listpart1.values.elementAt(index);
//

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
          return _buildOneSize(key, valuePrice, index);
        },
      );

      // Todo DefaultItemsStreamBuilder

    }
  }

  Widget oneMultiSelectInDetailsPageInitialView(
      FoodPropertyMultiSelect x, int index) {
    String color1 = x.itemTextColor.replaceAll('#', '0xff');

    Color c1 = Color(int.parse(color1));

    String itemName = x.itemName;
    String itemImage2 = x.itemImage;

    return Container(
      child: x.isSelected == true
          ? Container(
              width: displayWidth(context) / 14,
//        height:displayHeight(context)/48,
              height: displayHeight(context) / 25,

              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: RaisedButton(
                color: c1,
                padding: EdgeInsets.all(0),
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: c1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    child: Image.asset(
                  itemImage2,
                  width: 43,
                  height: 43,
                )),
                onPressed: () {
                  final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
                  blocD.setMultiSelectOptionForFood(x, index);
                },
              ),
            )
          : Container(
              width: displayWidth(context) / 14,
              height: displayHeight(context) / 30,
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: OutlineButton(
                padding: EdgeInsets.all(0),
                splashColor: c1,
                highlightElevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                borderSide: BorderSide(
                  color: Color(0xff707070),
                  style: BorderStyle.solid,
                  width: 0.5,
                ),
                child: Container(
                    child: Image.asset(
                  itemImage2,
                  width: 43,
                  height: 43,
                )),
                onPressed: () {
                  print('$itemName pressed');
                  final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

                  blocD.setMultiSelectOptionForFood(x, index);
                },
              ),
            ),
    );
  }

  Widget oneMultiSelectInDetailsPageOtherView(
      FoodPropertyMultiSelect x, int index) {
    String color1 = x.itemTextColor.replaceAll('#', '0xff');

    Color c1 = Color(int.parse(color1));

    String itemName = x.itemName;
    String itemImage2 = x.itemImage;

    return Container(
      child: x.isSelected == true
          ? Container(
              width: displayWidth(context) / 15,
//        height:displayHeight(context)/48,
              height: displayHeight(context) / 29,

              margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: RaisedButton(
                color: c1,
                elevation: 2.5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: c1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    child: Image.asset(
                  itemImage2,
                  width: 35,
                  height: 35,
                )),
                onPressed: () {
                  final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
                  blocD.setMultiSelectOptionForFood(x, index);
                },
              ),
            )
          : Container(
              width: displayWidth(context) / 15,
              height: displayHeight(context) / 29,
              margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: OutlineButton(
//          clipBehavior: Clip.hardEdge,
                splashColor: c1,

                highlightElevation: 12,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),

                borderSide: BorderSide(
//            color: Colors(0x707070),
                  color: Color(0xff707070),
                  style: BorderStyle.solid,
                  width: 0.5,
                ),

                child: Container(
                    child: Image.asset(
                  itemImage2,
                  width: 35,
                  height: 35,
                )),
                onPressed: () {
                  print('$itemName pressed');
                  final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

                  blocD.setMultiSelectOptionForFood(x, index);
                },
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              ),
            ),
    );
  }

  //now now
  /* DEAFULT INGREDIENT ITEMS BUILD STARTS HERE.*/

  Widget buildSelectedSauceItemsNameOnly(
      BuildContext context /*,List<NewIngredient> defaltIngs*/) {
//    defaultIngredients
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder<List<SauceItem>>(
        stream: blocD.getSelectedSauceItemsStream,
        initialData: blocD.getAllSelectedSauceItems,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 13,
              height: displayHeight(context) / 24,
//          height:190,
              width: displayWidth(context) / 2.39,
//              width: displayWidth(context) /1.50,

              color: Color(0xFFffffff),
              alignment: Alignment.center,

              // PPPPP

              child: Text(
                'looking for sauce items, please wait...'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim-Regular',
                  color: Colors.white,
                ),
              ),
            );
          } else {
//            print('snapshot.hasData and else statement at FDetailS2');
            List<SauceItem> selectedSauceItems = snapshot.data;

            if (selectedSauceItems.length == 0) {
              return Container(
//                  height: displayHeight(context) / 13,
                height: displayHeight(context) / 24,
//          height:190,
//                  width: displayWidth(context) /1.50,
                width: displayWidth(context) / 2.39,

                color: Color(0xffFFFFFF),

                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No sauce items found'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.grey,
                        ),
                      )
                  )
                  */
              );
            } else {
              return Container(
//                color: Colors.green,
                child: ListView.builder(
                  /*

                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(


                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 8, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 160 / 180,
                    // H/V


                  ),

                  */

                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: selectedSauceItems.length,
                  itemBuilder: (_, int index) {
                    return oneSauceItemNameOnly(
                        selectedSauceItems[index], index);
                  },
                ),
              );
            }
          }
        });
  }

  Widget oneSauceItemNameOnly(SauceItem oneSauce, int index) {
    final String sauceItemName = oneSauce.sauceItemName;

    // for condition: oneSauce.isSelected==true
    return Container(
//          color:Colors.lightGreenAccent,
//            color: Color.fromRGBO(239, 239, 239, 0),
//          color: Colors.white,
      padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
          horizontal: 10,
          vertical: 0),
      child: GestureDetector(
          onTap: () {
            print('SauceItem on Tap, '
                'nothing will happen since sauce is '
                'already selected, press onLong Press: to remove');

//                            return Navigator.push(context,

//                                MaterialPageRoute(builder: (context)
//                                => FoodItemDetails())
//                            );
          },
          child: Container(
            width: displayWidth(context) / 7,
            child: Row(
              children: [
                MyBullet(),
                Text(
                  sauceItemName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff707070),
//                                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
//                    decoration: TextDecoration.underline,
//                    decorationStyle:TextDecorationStyle.double,
                  ),
                ),
              ],
            ),
          )),
    );
  }

//  buildCheeseItems

  Widget buildSauceItems(
      BuildContext context /*,List<NewIngredient> defaltIngs*/) {
//    defaultIngredients
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder<List<SauceItem>>(
        stream: blocD.getSauceItemsStream,
        initialData: blocD.getAllSauceItems,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 13,
              height: displayHeight(context) / 11,
//          height:190,
              width: displayWidth(context) / 1.50,

              color: Color(0xFFffffff),
              alignment: Alignment.center,

              // PPPPP

              child: Text(
                'looking for sauce items, please wait...'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim-Regular',
                  color: Colors.white,
                ),
              ),
            );
          } else {
//            print('snapshot.hasData and else statement at FDetailS2');
            List<SauceItem> selectedSauceItems = snapshot.data;

            if (selectedSauceItems.length == 0) {
              return Container(
//                  height: displayHeight(context) / 13,
                height: displayHeight(context) / 11,
//          height:190,
                width: displayWidth(context) / 1.50,

                color: Color(0xffFFFFFF),

                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No sauce items found'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.grey,
                        ),
                      )
                  )

                  */
              );
            } else {
              return Container(
//                color: Colors.green,
                child: ListView.builder(
                  /*

                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(


                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 8, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 160 / 180,
                    // H/V


                  ),

                  */
//                  reverse: true,

                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,

                  itemCount: selectedSauceItems.length,
                  itemBuilder: (_, int index) {
                    return oneSauceItem(selectedSauceItems[index], index);
                  },
                ),
              );
            }
          }
        });
  }

  Widget oneSauceItem(SauceItem oneSauce, int index) {
    final String sauceItemName = oneSauce.sauceItemName;

    final dynamic sauceItemImageURL = oneSauce.imageURL == ''
        ? 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        : storageBucketURLPredicate +
            Uri.encodeComponent(oneSauce.imageURL) +
            '?alt=media';

    if (oneSauce.isSelected == false) {
      return Container(
        width: displayWidth(context) / 8,
        height: displayHeight(context) / 11,
        decoration: BoxDecoration(
          border: Border.all(
//                    color: Colors.black,
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 0.5,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: GestureDetector(
          onTap: () {
            print('for future use');
            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

            blocD.setThisSauceAsSelectedSauceItem(oneSauce, index);
          },
          onLongPressUp: () {
            print(
                'at Long Press UP Sauce Item Item: nothing will happen already unslected.. ');
//                blocD.toggleThisSauceAsSelected(oneSauce,index);
//                blocD.addThisCheeseAsSelectedCheeseItem(oneSauce,index)
          },
          child: Column(
//            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
//                  color:Colors.blue,
                padding: EdgeInsets.only(top: 5),
                height: displayHeight(context) / 16,
                width: displayWidth(context) / 10, //S

                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: sauceItemImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        new LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                  ),
                ),
              ),
//                              SizedBox(height: 10),
              Container(
//                  color:Colors.pink,
                padding: EdgeInsets.only(top: 5),
                width: displayWidth(context) / 8,
                child: Text(
                  sauceItemName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
//                                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // for condition: oneSauce.isSelected==true
      return Container(
        width: displayWidth(context) / 8,
        height: displayHeight(context) / 11,
//          color:Colors.lightGreenAccent,
//            color: Color.fromRGBO(239, 239, 239, 0),
//          color: Colors.white,

        decoration: BoxDecoration(
//            color:Colors.white,
          color: Color(0xffFCF5E4),
          borderRadius: BorderRadius.all(Radius.circular(5)),
//
        ),

        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

        child: GestureDetector(
          onTap: () {
            print('SauceItem on Tap, '
                'nothing will happen since sauce is '
                'already selected, press onLong Press: to remove');

//                            return Navigator.push(context,

//                                MaterialPageRoute(builder: (context)
//                                => FoodItemDetails())
//                            );
          },
          onLongPressUp: () {
            print('at Long Press UP SauceItem: ');
            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

            blocD.removeThisSauceFROMSelectedSauceItem(oneSauce, index);
//                blocD.addThisCheeseAsSelectedCheeseItem(oneSauce,index)
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 5),
                height: displayHeight(context) / 16,
                width: displayWidth(context) / 10,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: sauceItemImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        new LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                  ),
                ),
              ),

//                              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: displayWidth(context) / 8,
                child: Text(
                  sauceItemName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
//                        color: Color(0xff707070),
                    color: Colors.black,
//                                    color: Colors.blueGrey[800],

                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildSelectedCheeseItemsNameOnly(
      BuildContext context /*,List<NewIngredient> defaltIngs*/) {
//    defaultIngredients
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder<List<CheeseItem>>(
        stream: blocD.getSelectedCheeseItemsStream,
        initialData: blocD.getAllSelectedCheeseItems,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 13,
              height: displayHeight(context) / 24,
//          height:190,
              width: displayWidth(context) / 2.39,
//              width: displayWidth(context) /1.50,

              color: Color(0xFFffffff),
              alignment: Alignment.center,

              // PPPPP
            );
          } else {
//            print('snapshot.hasData and else statement at FDetailS2');
            List<CheeseItem> selectedCheeseItems = snapshot.data;

            if (selectedCheeseItems.length == 0) {
              return Container(
//                  height: displayHeight(context) / 13,
                height: displayHeight(context) / 24,
//          height:190,
//                  width: displayWidth(context) /1.50,
                width: displayWidth(context) / 2.39,

                color: Color(0xffFFFFFF),
                alignment: Alignment.center,

                // PPPPP
              );
            } else {
              return Container(
//                color: Colors.green,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: selectedCheeseItems.length,
                  itemBuilder: (_, int index) {
                    return oneCheeseItemNameOnly(
                        selectedCheeseItems[index], index);
                  },
                ),
              );
            }
          }
        });
  }

  Widget oneCheeseItemNameOnly(CheeseItem oneCheese, int index) {
    final String cheeseItemName = oneCheese.cheeseItemName;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      child: GestureDetector(
        onTap: () {
          print('at onTap: ');
//                print('at Long Press UP: ');
          final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

          blocD.setThisCheeseAsSelectedCheeseItem(oneCheese, index);
        },
        onLongPressUp: () {
          print(
              'at Long Press UP: --and nothing will happen since it is not selected,');
        },
      ),
    );
  }

  Widget buildCheeseItems(
      BuildContext context /*,List<NewIngredient> defaltIngs*/) {
    print('at buildCheeseItems ------ +++ +++ +++');
//    defaultIngredients
//    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder<List<CheeseItem>>(
        stream: blocD.getCheeseItemsStream,
        initialData: blocD.getAllCheeseItems,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 13,
              height: displayHeight(context) / 11,
//          height:190,
              width: displayWidth(context) / 1.50,

              color: Color(0xFFffffff),
              alignment: Alignment.center,

              // PPPPP

              child: Text(
                'looking for sauce items, please wait...'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim-Regular',
                  color: Colors.white,
                ),
              ),
            );
          } else {
//            print('snapshot.hasData and else statement at FDetailS2');
            List<CheeseItem> selectedCheeseItems = snapshot.data;

            if (selectedCheeseItems.length == 0) {
              return Container(
//                  height: displayHeight(context) / 13,
                height: displayHeight(context) / 11,
//          height:190,
                width: displayWidth(context) / 1.50,

                color: Color(0xffFFFFFF),

                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No sauce items found'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.grey,
                        ),
                      )
                  )

                  */
              );
            } else {
              return Container(
//                color: Colors.green,
                child: ListView.builder(
                  /*

                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(


                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 8, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 160 / 180,
                    // H/V


                  ),

                  */
//                  reverse: true,

                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,

                  itemCount: selectedCheeseItems.length,
                  itemBuilder: (_, int index) {
//                    return oneSauceItem(selectedCheeseItems[index],index);
                    return oneCheeseItem(selectedCheeseItems[index], index);
                  },
                ),
              );
            }
          }
        });
  }

  Widget oneCheeseItem(CheeseItem oneCheese, int index) {
    final String cheeseItemName = oneCheese.cheeseItemName;

    final dynamic cheeseItemImageURL = oneCheese.imageURL == ''
        ? 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        : storageBucketURLPredicate +
            Uri.encodeComponent(oneCheese.imageURL) +
            '?alt=media';

    if (oneCheese.isSelected == false) {
      return Container(
        width: displayWidth(context) / 8,
        height: displayHeight(context) / 11,
        decoration: BoxDecoration(
          border: Border.all(
//                    color: Colors.black,
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 0.5,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
//
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: GestureDetector(
          onTap: () {
            print('at onTap: ');
//                print('at Long Press UP: ');
            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

            blocD.setThisCheeseAsSelectedCheeseItem(oneCheese, index);
          },
          onLongPressUp: () {
            print(
                'at Long Press UP: --and nothing will happen since it is not selected,');
          },
          child: Column(
//            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
//                  color:Colors.blue,
                padding: EdgeInsets.only(top: 5),
                height: displayHeight(context) / 16,
                width: displayWidth(context) / 10, //S

                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: cheeseItemImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        new LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                  ),
                ),
              ),
//                              SizedBox(height: 10),

              Container(
//                  color:Colors.pink,
                padding: EdgeInsets.only(top: 5),
                width: displayWidth(context) / 8,
                child: Text(
//                    maxLines: 2,
//                    textAlign: TextAlign.center,
//                    overflow: TextOverflow.ellipsis,
                  cheeseItemName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: Colors.black,
//                                    color: Colors.blueGrey[800],

                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // sauce item selected already condition.

      return Container(
          width: displayWidth(context) / 8,
          height: displayHeight(context) / 11,
//          color:Colors.lightGreenAccent,
//            color: Color.fromRGBO(239, 239, 239, 0),
//          color: Colors.white,

          decoration: BoxDecoration(
//            color:Colors.white,
            color: Color(0xffFCF5E4),
            borderRadius: BorderRadius.all(Radius.circular(5)),
//
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

          /*
        padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
            horizontal: 10, vertical: 0),

        */
          child: GestureDetector(
            onTap: () {
              print(
                  'at onTap: and nothing will happen since it is selected already. ');
//                print('at Long Press UP: ');
//            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//
//            blocD.setThisCheeseAsSelectedCheeseItem(oneCheese,index);
            },
            onLongPressUp: () {
              print(
                  'at Long Press UP selected cheese item will be removed..: ');
//            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
//
//            blocD.removeThisCheeseFROMSelectedCheeseItem(oneCheese,index);
              final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);
              blocD.removeThisCheeseFROMSelectedCheeseItem(oneCheese, index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 5),
                  height: displayHeight(context) / 16,
                  width: displayWidth(context) / 10,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: cheeseItemImageURL,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          new LinearProgressIndicator(),
                      errorWidget: (context, url, error) => Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                    ),
                  ),
                ),

//                              SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  width: displayWidth(context) / 8,
                  child: Text(
                    cheeseItemName,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
//                        color: Color(0xff707070),
                      color: Colors.black,
//                                    color: Colors.blueGrey[800],

                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double,
                    ),
                  ),
                ),
              ],
            ),
          ));
    }
  }

  Widget selectedIngredientsNameOnly(
      BuildContext context /*,List<NewIngredient> defaltIngs*/) {
//    defaultIngredients
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder(
        stream: blocD.getDefaultIngredientItemsStream,
        initialData: blocD.getDefaultIngredients,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 13,
//               height: displayHeight(context) / 30,
              height: displayHeight(context) / 30,
//          height:190,
              width: displayWidth(context) / 1.20,

              color: Color(0xFFffffff),

              /*
              alignment: Alignment.center,

              // PPPPP

              child:
              Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim-Regular',
                  color: Colors.white,

                ),


              ),
              */
            );
          } else {
//            print('snapshot.hasData and else statement at FDetailS2');
            List<NewIngredient> selectedIngredients2 = snapshot.data;
            print(
                "selectedIngredients2.length: >>> >>> <<< ${selectedIngredients2.length}");
            List<NewIngredient> selectedIngredients = selectedIngredients2
                .where((element) => element.isDeleted == false)
                .toList();

            print(
                "selectedIngredients.length: >>> >>> <<< ${selectedIngredients.length}");

            if ((selectedIngredients.length == 1) &&
                (selectedIngredients[0].ingredientName.toLowerCase() ==
                    'none')) {
              return Container(
//                  height: displayHeight(context) / 13,
//                 height: displayHeight(context) / 30,
                height: displayHeight(context) / 30,
//          height:190,
                width: displayWidth(context) / 1.20,

                color: Color(0xFFffffff),

                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.white,
                        ),
                      )
                  )
                  */
              );
            } else if (selectedIngredients.length == 0) {
              return Container(
//                  height: displayHeight(context) / 13,
//                 height: displayHeight(context) / 30,
                height: displayHeight(context) / 30,
//          height:190,
                width: displayWidth(context) / 1.20,

                color: Color(0xffFFFFFF),

                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.grey,
                        ),
                      )
                  )
                  */
              );
            } else {
              return Container(
                height: displayHeight(context) / 30,
//                color: Colors.green,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedIngredients.length,
                  itemBuilder: (_, int index) {
                    return oneDefaultIngredientNameOnly(
                        selectedIngredients[index], index);
                  },
                ),
              );
            }
          }
        });
  }

  Widget buildDefaultIngredients(
      BuildContext context /*,List<NewIngredient> defaltIngs*/) {
//    defaultIngredients
    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder(
        stream: blocD.getDefaultIngredientItemsStream,
        initialData: blocD.getDefaultIngredients,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(
//              height: displayHeight(context) / 13,
              height: displayHeight(context) / 11,
//          height:190,
              width: displayWidth(context) / 1.50,

              color: Color(0xFFffffff),

              /*
              alignment: Alignment.center,

              // PPPPP

              child:
              Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim-Regular',
                  color: Colors.white,

                ),


              ),
              */
            );
          } else {
//            print('snapshot.hasData and else statement at FDetailS2');
            List<NewIngredient> selectedIngredients2 = snapshot.data;
//            List<NewIngredient> selectedIngredients2 = snapshot.data;
            print(
                "selectedIngredients2.length: >>> >>> <<< ${selectedIngredients2.length}");
            List<NewIngredient> selectedIngredients = selectedIngredients2
                .where((element) => element.isDeleted == false)
                .toList();

//            _allSelectedSauceItems = sauceItems.where((element) => element.isSelected==true).toList();
            print(
                "selectedIngredients.length: >>> >>> <<< ${selectedIngredients.length}");

            if ((selectedIngredients.length == 1) &&
                (selectedIngredients[0].ingredientName.toLowerCase() ==
                    'none')) {
              return Container(
//                  height: displayHeight(context) / 13,
                height: displayHeight(context) / 11,
//          height:190,
                width: displayWidth(context) / 1.50,

                color: Color(0xFFffffff),

                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.white,
                        ),
                      )
                  )

                  */
              );
            } else if (selectedIngredients.length == 0) {
              return Container(
//                  height: displayHeight(context) / 13,
                height: displayHeight(context) / 11,
//          height:190,
                width: displayWidth(context) / 1.50,

                color: Color(0xffFFFFFF),
                /*
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more.'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.grey,
                        ),
                      )
                  )

                  */
              );
            } else {
              return Container(
//                color: Colors.green,
                child: ListView.builder(
                  /*
                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(


                    maxCrossAxisExtent: 160,
                    mainAxisSpacing: 8, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 160 / 180,
                    // H/V


                  ),
                  */

                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedIngredients.length,
                  itemBuilder: (_, int index) {
                    return oneDefaultIngredient(
                        selectedIngredients[index], index);
                  },
                ),
              );
            }
          }
        });
  }

  Widget oneDefaultIngredientNameOnly(NewIngredient oneIngredient, int index) {
    final String ingredientName = oneIngredient.ingredientName;

    final dynamic ingredientImageURL = oneIngredient.imageURL == ''
        ? 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        : storageBucketURLPredicate +
            Uri.encodeComponent(oneIngredient.imageURL) +
            '?alt=media';

    return Container(
      width: displayWidth(context) / 6,
      height: displayHeight(context) / 30,
      // color:Colors.lightBlueAccent,
    );
  }

  Widget oneDefaultIngredient(NewIngredient oneIngredient, int index) {
    final String ingredientName = oneIngredient.ingredientName;

    final dynamic ingredientImageURL = oneIngredient.imageURL == ''
        ? 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        : storageBucketURLPredicate +
            Uri.encodeComponent(oneIngredient.imageURL) +
            '?alt=media';

    return Container(
      height: displayHeight(context) / 11,
      width: displayWidth(context) / 8,
      decoration: BoxDecoration(
        color: Color(0xffFCF5E4),
        borderRadius: BorderRadius.all(Radius.circular(5)),
//
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: GestureDetector(
          onLongPressUp: () {
            print('at Long Press UP: ');

            final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

            blocD.removeThisDefaultIngredientItem(oneIngredient, index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                height: displayHeight(context) / 16,
                width: displayWidth(context) / 10, //S

//                      width: displayWidth(context) /10,
//                      height: displayWidth(context) /9,
//                  padding:EdgeInsets.symmetric(vertical: 0,horizontal: 0),

                child: ClipOval(
                  child: CachedNetworkImage(
//                        color: Colors.deepOrangeAccent,
//                        colorBlendMode: BlendMode.overlay ,
                    imageUrl: ingredientImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        new LinearProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                  ),
                ),
              ),

//                              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: displayWidth(context) / 8,
                child: Text(
                  ingredientName,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
//                                    color: Colors.blueGrey[800],

                    fontWeight: FontWeight.normal,
                    fontSize: 14,
//                    decoration: TextDecoration.underline,
//                    decorationStyle:TextDecorationStyle.double,
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            print('for future use');
          }),
    );
  }

  Widget _buildOneSizeForOtherView(String oneSize, double onePriceForSize) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 3, 4, 5),
      width: displayWidth(context) / 3.8,
      height: displayHeight(context) / 29,
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        color: Color(0xffFFE18E),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xffF7F0EC),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Container(
          child: Text(
            oneSize.toUpperCase(),
            style: TextStyle(
                color: Color(0xff54463E),
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                fontSize: 16),
          ),
        ),
        onPressed: () {
          print('no action but you pressed the selected size');
        },
      ),
    );
  }

  Widget _buildOneSize(String oneSize, double onePriceForSize, int index) {
    return Container(
        child: oneSize.toLowerCase() == _currentSize
            ? Container(
                margin: EdgeInsets.fromLTRB(12, 2, 12, 5),
//          padding: EdgeInsets.fromLTRB(12,2,12,5),
                width: displayWidth(context) / 3.6,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  color: Color(0xffFFE18E),
//          color: Colors.lightGreen,
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Color(0xffF7F0EC),
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(35.0),
                  ),

                  child: Container(
//              alignment: Alignment.center,
                    child: Text(
                      oneSize.toUpperCase(),
                      style: TextStyle(
//                  color:Color(0xff54463E),
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins ',
                          fontSize: 13),
                    ),
                  ),
                  onPressed: () {
//              logger.i('onePriceForSize: ',onePriceForSize);

                    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

                    blocD.setNewSizePlusPrice(oneSize);
                  },
                ),
              )
            : Container(
//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
                margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                width: displayWidth(context) / 3.6,
                child: OutlineButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  color: Color(0xffFEE295),
                  // clipBehavior:Clip.hardEdge,

                  borderSide: BorderSide(
                    color: Color(0xff53453D), // 0xff54463E
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Container(
//              alignment: Alignment.center,
                    child: Text(
                      oneSize.toUpperCase(),
                      style: TextStyle(
                          color: Color(0xff54463E),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                          fontSize: 13),
                    ),
                  ),
                  onPressed: () {
                    final blocD = BlocProvider.of<FoodItemDetailsBloc>(context);

                    blocD.setNewSizePlusPrice(oneSize);
                  },
                ),
              ));
  }
}

//  FoodDetailImage

//LongHeaderPainterAfterShoppingCartPage
class LongHeaderPainterAfterShoppingCartPage extends CustomPainter {
  final BuildContext context;
  LongHeaderPainterAfterShoppingCartPage(this.context);
  @override
  void paint(Canvas canvas, Size size) {
//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context) / 1.6, 15); //(X,Y) TO (X,Y)
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
