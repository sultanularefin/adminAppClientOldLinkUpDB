

### no foodItem data pushing:

```dart

//## foodgallery Page August29: with android's Mainactivity invocation:
//
//```dart
// package/ external dependency files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/UnPaidDetailsBloc.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
import 'package:foodgallery/src/BLoC/history_bloc.dart';

// BLOC'S IMPORT BEGIN HERE:
// import 'package:foodgallery/src/BLoC/app_bloc.dart';
//import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/BLoC/unPaid_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

// MODEL'S IMPORT BEGINS HERE.
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
// import 'package:foodgallery/src/screens/foodGalleryDrawer/DrawerScreenFoodGallery.dart';
import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails2.dart';
import 'package:wakelock/wakelock.dart';

//import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:foodgallery/src/screens/drawerScreen/DrawerScreenFoodGallery.dart';

// import 'dart:io';

import 'package:foodgallery/src/screens/history/HistoryPage.dart';
//import 'package:foodgallery/src/screens/history/HistoryPage.dart';
import 'package:foodgallery/src/screens/unPaid/UnPaidPage.dart';
import 'package:foodgallery/src/screens/shoppingCart/ShoppingCart.dart';
import 'package:foodgallery/src/screens/unPaid/UnPaidPage.dart';
//import 'package:firebase_auth/firebase_auth.dart';

//import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:system_shortcuts/system_shortcuts.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//import 'package:neumorphic/neumorphic.dart';

//C:/src/flutter/.pub-cache/hosted/pub.dartlang.org/neumorphic-0.3.0/lib/src/components/neu_card.dart
// local packages

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:foodgallery/src/screens/foodItemDetailsPage/foodItemDetails.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// Screen files.
import 'package:foodgallery/src/welcomePage.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';

import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';

class FoodGallery2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

//  final Firestore firestore = Firestore.instance;

  FoodGallery2({Key key, this.child}) : super(key: key);

  _FoodGalleryState createState() => _FoodGalleryState();
}

class _FoodGalleryState extends State<FoodGallery2> {
// static const platform = const MethodChannel('com.example.timePickerTest');

  static const platform = const MethodChannel('com.linkup.foodgallery');

  final GlobalKey<ScaffoldState> _scaffoldKeyFoodGallery =
  new GlobalKey<ScaffoldState>();
//  final GlobalKey<ScaffoldState> scaffoldKeyClientHome = GlobalKey<ScaffoldState>();
  final SnackBar snackBar =
  const SnackBar(content: Text('Menu button pressed'));

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  _FoodGalleryState(/*{firestore} */);

//  final _formKey = GlobalKey();

//  final _formKey = GlobalKey<FormState>();

  String _searchString = '';
  String _currentCategory = "pizza";
  String _firstTimeCategoryString = "";

//  this can be defined in Shopping cart page like old way
  int _totalCount = 0;
  List<SelectedFood> allSelectedFoodGallery = [];
  double totalPriceState = 0;

  Order orderFG = new Order(
    selectedFoodInOrder: [],
    selectedFoodListLength: 0,
    orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
    paymentTypeIndex:
    2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
    orderingCustomer: null,
    totalPrice: 0,
    page: 0,
  );

  String _batteryLevel = 'Unknown battery level.';

  bool blueToothState = false;
  bool wiFiState = false;

  @override
  void initState() {
    print('at initState of foodGallery page');

    localStorageCheck();
//_getBatteryLevel();
    super.initState();
  }

/*
Future<void> _getBatteryLevel() async {
String batteryLevel;
try {
final int result = await platform.invokeMethod('getBatteryLevel');
batteryLevel = 'Battery level at $result % .';
} on PlatformException catch (e) {
batteryLevel = "Failed to get battery level: '${e.message}'.";
}

setState(() {
_batteryLevel = batteryLevel;
});
}

*/

// Future<void> return type .  ??
  Future<void> localStorageCheck() async {
    bool blueTooth = await SystemShortcuts.checkBluetooth; // return true/false
    bool wifi = await SystemShortcuts.checkWifi; // return true/false

    setState(() {
      wiFiState = wifi;
      blueToothState = blueTooth;
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

//  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

//  Future<void> _showMyDialog() async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('want to logout'),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text('This is a demo alert dialog.'),
//                Text('Would you like to approve of this message?'),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('yes won\'t work'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Future<void> logout(BuildContext context2) async {
    print('what i do is : ||Logout||');

//    _scaffoldKey.currentState.showSnackBar(
//    ABOVE ONE ALSO WORKS

//    _showMyDialog();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
//    THIS ALSO WORKS
/*
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => WelcomePage()),
    );
    */

//    return Navigator.push(context,
//
//        MaterialPageRoute(builder: (context)
//        => FoodItemDetails(oneFoodItemData:oneFoodItem))
//    );

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
          return BlocProvider<IdentityBloc>(
              bloc: IdentityBloc(),
//AppBloc(emptyFoodItemWithDocID,loginPageIngredients,fromWhichPage:0),
              child: WelcomePage(fromWhicPage: 'foodGallery2'));
/*
                                  return BlocProvider<FoodGalleryBloc>(
                                      bloc: FoodGalleryBloc(),
                                      child: FoodGallery2()

                                  );
                                  */
        }), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final blocG = BlocProvider.of<FoodGalleryBloc>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Theme(
          data: ThemeData(primaryIconTheme: IconThemeData(

            color: Colors.black,
            // size: 40,

          )), // use this

          child: Scaffold(
            key: _scaffoldKeyFoodGallery,
//          backgroundColor: Colors.purpleAccent,

//      resizeToAvoidBottomPadding: false ,
// appBar: AppBar(title: Text('Food Gallery')),

            appBar: AppBar(
              // backgroundColor: Colors.deepOrange,

              toolbarHeight: 85,
              elevation: 0,
              titleSpacing: 0,
              shadowColor: Colors.white,
              backgroundColor: Color(0xffFFE18E),

              title: Container(
                height: displayHeight(context) / 14,
                width: displayWidth(context) -
                    MediaQuery.of(context).size.width / 3.8,

                color: Color(0xffFFFFFF),
//                              color:Colors.purpleAccent,

//                      color: Color.fromARGB(255, 255,255,255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
// image and string JEDILINE BEGINS HERE.
                    SizedBox(
                      height: kToolbarHeight +
                          6, // 6 for spacing padding at top for .
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /*
                          Container(
                            height: displayHeight(context) / 15,
                            child: Image.asset('assets/logo.png'),
                          ),

                          */

                          Container(
                            height: displayHeight(context) / 15,
                            child: Image.asset('assets/Path2008.png'),

                          ),
                          Container(
                            margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            height: displayHeight(context) / 15,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'restapojut',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff07D607),
                                        fontFamily: 'poppins'),
                                  ),
                                  Text(
                                    'Online Orders',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff07D607)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Color(0xffBCBCBD),
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                        color: Colors.white,
                      ),
                      width: displayWidth(context) / 3.3,
                      height: displayHeight(context) / 27,
                      padding:
                      EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: displayWidth(context) / 34,
                            width: 5,
                            margin:
                            EdgeInsets.only(left: 0, right: 10, bottom: 5),
                            child: Icon(
                              Icons.search,
                              size: displayWidth(context) / 24,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: displayWidth(context) / 4.7,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                setState(() => _searchString = text);
                                print(
                                    "First text field from Condition 04: $text");
                              },
                              onTap: () {
                                print('condition 4');
                                setState(() {
                                  _firstTimeCategoryString = 'PIZZA';
                                });
                              },
                              onEditingComplete: () {
                                print('called onEditing complete');
                                setState(() => _searchString = "");
                              },
                              onSubmitted: (String value) async {
                                await showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Thanks!'),
                                      content: Text('You typed "$value".'),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      child: shoppingCartWidget(
                          context), // CLASS TO WIDGET SINCE I NEED TO INVOKE THE
                    ),
                  ],
                ),
              ),
            ),

            body: SingleChildScrollView(
              child: Container(
//              color:Colors.lightGreenAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[



                      /*
                      Container(
                        width: displayWidth(context) -
                            MediaQuery.of(context).size.width / 3.8,
                        height: displayHeight(context) + kToolbarHeight + 10,
                        child: foodList(_currentCategory, _searchString,
                            context /*allIngredients:_allIngredientState */),
                      ),

                      */




                      Container(
                        height: displayHeight(context) + kToolbarHeight + 10,
                        width: MediaQuery.of(context).size.width / 3.8,
                        color: Color(0xffFFE18E),
                        child: StreamBuilder<List<NewCategoryItem>>(
                            stream: blocG.categoryItemsStream,
                            initialData: blocG.allCategories,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, displayHeight(context) / 2, 0, 0),
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: new CircularProgressIndicator(
                                                    backgroundColor:
                                                    Colors.lightGreenAccent)),
                                          ),
                                          Center(
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: new CircularProgressIndicator(
                                                  backgroundColor: Colors.yellow,
                                                )),
                                          ),
                                          Center(
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: new CircularProgressIndicator(
                                                    backgroundColor:
                                                    Colors.redAccent)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  break;
                                case ConnectionState.active:
                                default:
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: new LinearProgressIndicator());
                                  } else {
                                    final List allCategories = snapshot.data;
//                                  logger.i('allCategories.length:', allCategories.length);

//                                  _allCategoryList.add(All);

//                                  allCategories.add(all);
//                                  logger.i('allCategories.length after :', allCategories.length);

                                    final int categoryCount = allCategories.length;

//                              print('categoryCount in condition 04: ');

//                                logger.i("categoryCount in condition 04: $categoryCount");

                                    return (new ListView.builder(
                                        itemCount: categoryCount,

//    itemBuilder: (BuildContext ctxt, int index) {
                                        itemBuilder: (_, int index) {
//                                            return (Text('ss'));

                                          return _buildCategoryRow(
                                              allCategories[index]
/*categoryItems[index]*/,
                                              index);
                                        }));
                                  }
                              }
                            }),
                      ),
                    ],
                  )),
            ),

            endDrawer: Drawer(
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything
//
// .

              child: Container(
                color: Color(0xffFFE18E),
                child: ListView(
                  padding: EdgeInsets.zero,
                  // padding: EdgeInsets.fromLTRB(0,0,10,0),
                  children: <Widget>[

                    DrawerHeader(
                      //decoration: BoxDecoration(color:Theme.of(context).bottomAppBarColor),

                      decoration: BoxDecoration(
                        color: Color(0xffFFE18E),
                      ),

                      // child: RaisedButton(
                        child: Text(
                          'restapojut'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                /*
                        onPressed: (){
                          // 911_1
                          Navigator.pop(context);
                        },
              */
                     // ),
                    ),
                    ListTile(
                      title: Container(
                          color: Color(0xffFFE18E),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Image.asset(
                                  'assets/unpaid_cash_card/unpaid.png',
//                color: Colors.black,
                                  width: 30,
                                  height: 30,
                                ),
                              ),

                              Container(
//                          width: displayWidth(context)/3.9,
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),

                                child: Text(
                                  'maksamatta'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              )
//                      Text('history'),
                            ],
                          )),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            transitionDuration: Duration(milliseconds: 900),
                            pageBuilder: (_, __, ___) => BlocProvider<UnPaidBloc>(
                              bloc: UnPaidBloc(),
                              child: UnPaidPage(),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ListTile(
                      title: Container(
                          color: Color(0xffFFE18E),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Image.asset(
                                  'assets/history.png',
//                color: Colors.black,
                                  width: 30,
                                  height: 30,
                                ),
                              ),

                              Container(
//                          width: displayWidth(context)/3.9,
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),

                                child: Text(
                                  'history'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'historia',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              )
//                      Text('history'),
                            ],
                          )),
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            transitionDuration: Duration(milliseconds: 900),
                            pageBuilder: (_, __, ___) =>
                                BlocProvider<HistoryBloc>(
                                  bloc: HistoryBloc(),
                                  child: HistoryPage(),
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

/*
  Widget animatedWidgetPressToFinish(){


    return RaisedButton(

        color:Color(0xffFCF5E4),
        highlightColor: Color(0xff525FFF),
        splashColor: Color(0xffB47C00),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        highlightElevation: 12,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(0xff707070),
            style: BorderStyle.solid,
//            width: 1,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),

        child:Container(

          width:displayWidth(context)/4.5,

          height: displayHeight(context)/24,
          padding: EdgeInsets.fromLTRB(0,0,0,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment
                .center,
            children: <
                Widget>[
              //  SizedBox(width: 5,),

              /*
                Container(
                  padding: EdgeInsets.fromLTRB(0,3,0,0),
                  child: Icon(
                    Icons.add,
                    size: 25.0,
//                    color: Color(0xffF50303),
                    color: Colors.black,
                    //        color: Color(0xffFFFFFF),
                  ),
                ),

                */

              Text(
                'press to continue'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight
                      .bold,
//                    color: Color(0xffF50303),
                  color: Colors.black,
                  fontSize: 18, fontFamily: 'Itim-Regular',),
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

          }
          );
        }
    );

  }
  */

  Widget _buildCategoryRow(
      /*DocumentSnapshot document*/
      NewCategoryItem oneCategory,
      int index) {
//    final DocumentSnapshot document = snapshot.data.documents[index];
    final String categoryName = oneCategory.categoryName;
//    final String categoryName = document['name'];

//    final DocumentSnapshot document = snapshot.data.documents[index];
//    final String categoryName = document['name'];

//    logger.i('category Name in _buildCategoryRow: $categoryName');

    if (_currentCategory.toLowerCase() == categoryName.toLowerCase()) {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(30, 6, 5, 26),
//    FittedBox(fit:BoxFit.fitWidth, stringifiedFoodItemIngredients
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                categoryName.toLowerCase().length > 8
                    ? categoryName.toLowerCase().substring(0, 8) + '..'
                    : categoryName.toLowerCase(),
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff000000),
                ),
              ),
              CustomPaint(
                size: Size(0, 19),
                painter: MyPainter(),
              )
            ]),
        onTap: () {
          // Add 9 lines from here...
          print('onTap pressed');
          print('index: $index');
          setState(() {
            _currentCategory = categoryName;
            _firstTimeCategoryString = categoryName;
            _searchString = '';
          });
        }, // ... to here.
      );
    } else {
      return ListTile(
        contentPadding: EdgeInsets.fromLTRB(20, 6, 5, 6),

        title: Text(
          categoryName.toLowerCase(),
//    Text(categoryName.substring(0, 2),
          style: TextStyle(
            fontFamily: 'poppins',

            fontSize: 20,
            fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
            color: Color(0xff000000),
          ),
        ),
        onTap: () {
          // Add 9 lines from here...
          print('onTap pressed');
          print('index: $index');
          setState(() {
            _currentCategory = categoryName;
            _firstTimeCategoryString = categoryName;
            _searchString = '';
          });
        }, // ... to here.
      );
    }
  }

  Widget drawerTest(BuildContext context) {
//    key: _drawerKey;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
// Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
// Update the state of the app.
// ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
// Update the state of the app.
// ...
              },
            ),
          ],
        ),
// Add a ListView to the drawer. This ensures the user can scroll
// through the options in the drawer if there isn't enough vertical
// space to fit everything.

// Populate the Drawer in the next step.
      ),
    );
  }

  Widget shoppingCartWidget(BuildContext context) {
    return Container(
//                                                                        width:60,
      width: displayWidth(context) / 13,
      height: displayHeight(context) / 25,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

      child: OutlineButton(
        onPressed: () async {
          if (_totalCount == 0) {
            return showDialog<void>(
              context: context,
              barrierDismissible: true, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Select some Food, please'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
//                        Text('you haven\'t selected any food yet, please select some food'),
                        Text(
                            'You need to select some food item in order to go to the shopping cart page.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Agree'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            print(
                ' method for old Outline button that deals with navigation to Shopping Cart Page');

// work 01.

//          orderFG

//      final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

//              final locationBloc = BlocProvider.of<>(context);
//                                    foodItemDetailsbloc.incrementThisIngredientItem(unSelectedOneIngredient,index);

            CustomerInformation oneCustomerInfo = new CustomerInformation(
              address: '',
              flatOrHouseNumber: '',
              phoneNumber: '',
              etaTimeInMinutes: -1,
              etaTimeOfDay: new TimeOfDay(hour: 0, minute: 0),

              // etaTimeOfDay: new TimeOfDay(hour:-0,minute:-0),
              // THIS DOESN'T WORK...

//              etaTimeOfDay: new TimeOfDay(),

//        CustomerInformation currentUser = _oneCustomerInfo;

//    currentUser.address = address;
            );

            final blocG = BlocProvider.of<FoodGalleryBloc>(context);
            List<NewCategoryItem> allCategoriesForShoppingCartPage =
                blocG.allCategories;

//            List<NewCategoryItem> allCategoriesForShoppingCartPage = blocG.getAllIngredientsPublicFGB2;

            orderFG.selectedFoodInOrder = allSelectedFoodGallery;

            orderFG.selectedFoodListLength = allSelectedFoodGallery.length;
            orderFG.totalPrice = totalPriceState;
            orderFG.orderingCustomer = oneCustomerInfo;
            print('add_shopping_cart button pressed');

            logger.e(
                'orderFG.selectedFoodInOrder ${orderFG.selectedFoodInOrder}');
            print(
                'allSelectedFoodGallery[0].quantity: ${allSelectedFoodGallery[0].quantity} ');

            final Order orderWithDocumentId = await Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                transitionDuration: Duration(milliseconds: 900),
                pageBuilder: (_, __, ___) => BlocProvider<ShoppingCartBloc>(
                  bloc: ShoppingCartBloc(
                      orderFG, allCategoriesForShoppingCartPage),
                  child: ShoppingCart(),
                ),
// fUTURE USE -- ANIMATION TRANSITION CODE.
              ),
            );

            if (orderWithDocumentId == null) {
              setState(() {
                _totalCount = 0;
                totalPriceState = 0;
                allSelectedFoodGallery = [];
                orderFG = new Order(
                  selectedFoodInOrder: [],
                  selectedFoodListLength: 0,
                  orderTypeIndex: 0,
// phone, takeaway, delivery, dinning.
                  paymentTypeIndex: 2,
//2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                  orderingCustomer: null,
                  totalPrice: 0,
                  page: 0,
                  isCanceled: false,
                  orderdocId: '',
                );
              });
            } else if ((orderWithDocumentId.isCanceled != true) &&
                (orderWithDocumentId.orderdocId == '')) {
              print('//   //    //    // THIS ELSE IS FOR BACK BUTTON =>');
              print(
                  'orderWithDocumentId.selectedFoodInOrder: ${orderWithDocumentId.selectedFoodInOrder}');
              print(
                  'allSelectedFoodGallery: ${orderWithDocumentId.selectedFoodInOrder}');
              print(
                  'allSelectedFoodGallery: ${orderWithDocumentId.selectedFoodInOrder}');

              print('_totalCount: $_totalCount');
              print('totalPriceState: $totalPriceState');

              setState(() {
//                        int _totalCount = 0;
                allSelectedFoodGallery =
                    orderWithDocumentId.selectedFoodInOrder;
              });

              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("THIS ELSE IS FOR BACK BUTTON"),
                    duration: Duration(milliseconds: 8000),
                  ),
                );
//      setState(() => _reloadRequired = true);

            } else if ((orderWithDocumentId.paymentButtonPressed) &&
                (orderWithDocumentId.orderdocId != '')) {
              logger.e("Order received, id: ${orderWithDocumentId.orderdocId}");
              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text(
                        "Order received, id: ${orderWithDocumentId.orderdocId}"),
                    duration: Duration(milliseconds: 8000)));


              setState(
                      () {
                    _totalCount = 0;
                    totalPriceState = 0;
                    allSelectedFoodGallery=[];
                    orderFG = new Order(
                      selectedFoodInOrder: [],
                      selectedFoodListLength:0,
                      orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
                      paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                      orderingCustomer: null,
                      totalPrice: 0,
                      page:0,
                      isCanceled: false,
                      orderdocId:'',
                    );
                  }
              );


            }


            else if (orderWithDocumentId.isCanceled == true) {


//              Order Cancelled by user.
              print("Order Cancelled by user,");
              print(
                  "orderWithDocumentId.paymentButtonPressed: ${orderWithDocumentId.paymentButtonPressed}");
              print(
                  "orderWithDocumentId.orderdocId == '': ${orderWithDocumentId.orderdocId}");

              Scaffold.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text("Order Cancelled by user: ")));

/*
            Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text("Order Cancelled by user.")));
            */
//      setState(() => _reloadRequired = true);

              setState(() {
//                        int _totalCount = 0;
//                        List<SelectedFood> allSelectedFoodGallery = [];
//                        double totalPriceState = 0;
                _totalCount = 0;
                totalPriceState = 0;
                allSelectedFoodGallery = [];

                orderFG = new Order(
                  selectedFoodInOrder: [],
                  selectedFoodListLength: 0,
                  orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
                  paymentTypeIndex:
                  2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                  orderingCustomer: null,
                  totalPrice: 0,
                  page: 0,
                  isCanceled: false,
                  orderdocId: '',
                );
              });
            } else {
              print('why this condition executed.');
              logger.e('why this condition executed.');
            }

//          setState(
//                  ()
//              {
//                _totalCount = 0;
//                totalPriceState = 0;
//
//              }
//          );

          }
        },
//                        color: Color(0xffFEE295),
        clipBehavior: Clip.hardEdge,
        splashColor: Color(0xffFEE295),
//          splashColor: Color(0xff739DFA),
        highlightElevation: 12,
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
//          disabledBorderColor: false,
        borderSide: BorderSide(
          color: Color(0xffFEE295),
          style: BorderStyle.solid,
          width: 3.6,
        ),

        child:

        ///SSWW

        Center(
          child: Stack(children: <Widget>[
            Center(
              child: Icon(
                Icons.add_shopping_cart,
                size: displayWidth(context) / 19,
                color: Color(0xff707070),
              ),
            ),
            Container(
//                                              color:Colors.red,
              width: displayWidth(context) / 25,

              decoration: new BoxDecoration(
                color: Colors.redAccent,
                border: new Border.all(
                    color: Colors.green, width: 1.0, style: BorderStyle.solid),
                shape: BoxShape.circle,
              ),

              alignment: Alignment.center,
              child: Text(
                _totalCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

// ALL FOODLIST CLASS RELATED FUNCTIONS ARE BLOW UNTIL CLASS STARTS THAT WE CAN PUT IN ANOTHER FILE.
// IF WE WANT, START'S HERE:

  String titleCase(var text) {
// print("text: $text");
    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');
    }
  }

  String listTitleCase(List<dynamic> dlist) {
//    print ('text at listTitleCase:  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE: $text');
//    print('dlist ---------------------------------------------> $dlist');

    List<String> stringList = List<String>.from(dlist);
    if (stringList.length == 0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }

//    var strings = text.OfType<String>().ToList();

//    var strings = dlist.map((item) => item.price).toList();

//    print ('stringList --> : $stringList');

// print("text: $text");
    if (stringList.length == 0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    }
//    else if (text.length <= 1) {
//      return text.toUpperCase();
//    }

//    else {
//      return stringList
//          .map((word) => word.toString().split(' ')
//          .map((word2) => word2[0].toUpperCase() + word2.substring(1)).join(' '))
//          .join(', ');
//
//    }

    else {
      return stringList
          .map((word) => word
          .toString()
          .split(' ')
          .map((word2) => titleCase(word2))
          .join(' '))
          .join(', ');
    }
//    word2[0].toUpperCase() + word2.substring(1)

//    return "bash";
  }

//  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;

  Widget foodList(
      String categoryString, String searchString2, BuildContext context) {
//    print('_allIngredientState: in FoodLIst: $allIngredients');
//    final bloc = LocationQueryBloc();

//    final blocZZ = FoodItemsQueryBloc();

//    final foodGalleryBloc = BlocProvider2.of(context).getFoodGalleryBlockObject;
    final foodGalleryBloc = BlocProvider.of<FoodGalleryBloc>(context);

    return Container(
      child: StreamBuilder<List<FoodItemWithDocID>>(
        stream: foodGalleryBloc.foodItemsStream,
        initialData: foodGalleryBloc.allFoodItems,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                margin:
                EdgeInsets.fromLTRB(0, displayHeight(context) / 2, 0, 0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.lightGreenAccent)),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                              backgroundColor: Colors.yellow,
                            )),
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: new CircularProgressIndicator(
                                backgroundColor: Colors.redAccent)),
                      ),
                    ],
                  ),
                ),
              );
              break;
            case ConnectionState.active:
//          print('snapshot.hasData FG2 : ${snapshot.hasData}');

            default:
              if (!snapshot.hasData) {
                return Container(
                  margin:
                  EdgeInsets.fromLTRB(0, displayHeight(context) / 2, 0, 0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                              alignment: Alignment.center, child: Text('....')),
                        ),
//                    Center(
//                      child: Container(
//                          alignment: Alignment.center,
//                          child: new CircularProgressIndicator(
//                            backgroundColor: Colors.yellow,)
//                      ),
//                    ),
                        Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: new CircularProgressIndicator(
                                  backgroundColor: Colors.redAccent)),
                        ),
                      ],
                    ),
                  ),
                );
              }
//          return Center(child:
//          Text('${messageCount.toString()}')
//          );
              else {
                print(
                    'searchString  ##################################: $searchString2');
                print(
                    'categoryString  ##################################: $categoryString');
// ..p

//          int messageCount = filteredItems.length;

//..p
                final List<FoodItemWithDocID> allFoods = snapshot.data;

//          logger.i('categoryString.toLowerCase().trim(): ',categoryString.toLowerCase().trim());

                if (searchString2 == '') {
//               filteredItemsByCategory;
                  List<FoodItemWithDocID> filteredItemsByCategory = allFoods
                      .where((oneItem) =>
                  oneItem.categoryName.toLowerCase() ==
                      categoryString.toLowerCase())
                      .toList();

// to do test.
// if(searchString2!=null)

/*
              final List filteredItems = filteredItemsByCategory.where((
                  oneItem) =>
                  oneItem.itemName.toLowerCase().
                  contains(
                      searchString2.toLowerCase())).toList();

              */

                  final int categoryItemsCount = filteredItemsByCategory.length;
                  print('categoryItemsCount: $categoryItemsCount');
                  return Column(
                    children: <Widget>[
                      Container(
                        height: displayHeight(context) / 20,
                        color: Color(0xffffffff),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              CustomPaint(
                                size: Size(0, 19),
                                painter: LongHeaderPainterBefore(context),
                              ),
                              Text(
                                '$_currentCategory'.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                                  color: Color(0xff000000),
                                ),
                              ),
                              CustomPaint(
                                size: Size(0, 19),
                                painter: LongHeaderPainterAfter(context),
                              ),
                              Spacer(),
                            ]),
                      ),
                      Container(
                        child: foodListByCategoryandNoSearch(
                            filteredItemsByCategory, context),
                      ),
                    ],
                  );
                } else {
//searchString2 != ''
//              filteredItemsByCategory = allFoods.where((oneItem) =>
//              oneItem.categoryName.
//              toLowerCase() ==
//                  categoryString.toLowerCase()).toList();

// to do test.
// if(searchString2!=null)

                  final List<FoodItemWithDocID> filteredItems = allFoods
                      .where((oneItem) => oneItem.itemName
                      .toLowerCase()
                      .contains(searchString2.toLowerCase()))
                      .toList();

//              final int ItemsCount = filteredItems.length;
//              print('categoryItemsCount: $categoryItemsCount');
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: displayHeight(context) / 20,
                          color: Color(0xffffffff),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Spacer(),
                                CustomPaint(
                                  size: Size(0, 19),
                                  painter: LongHeaderPainterBefore(context),
                                ),
                                Text(
                                  '$searchString2'.toLowerCase(),
                                  style: TextStyle(
                                    fontFamily: 'Itim-Regular',
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                CustomPaint(
                                  size: Size(0, 19),
                                  painter: LongHeaderPainterAfter(context),
                                ),
                                Spacer(),
                              ]),
/*
                              child:Text('$_currentCategory'.toLowerCase(),
                                style: GoogleFonts.itim(
                                  textStyle: Theme.of(context).textTheme.display1,
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
                                  color: Color(0xff000000),
                                ),

                              ),
                              */
                        ),
                        Container(
//                        height:displayHeight(context) -
//                            MediaQuery
//                                .of(context)
//                                .padding
//                                .top - (displayHeight(context) / 14) -
//                            (displayHeight(context) / 10), /* displayHeight(context) / 20 is the header of category of search*/

                          child: foodListBySearchString(filteredItems, context),
                        ),
                      ],
                    ),
                  );
                }
              }
          }

//          else {
//            return Center(child:
//            Text('No Data')
//            );
//          }
        },
      ),
    );
  }

  Widget foodListBySearchString(
      List<FoodItemWithDocID> filteredItemsBySearchString,
      BuildContext context) {
    return Container(
      height: displayHeight(context) -
          MediaQuery.of(context).padding.top -
          (displayHeight(context) / 14) -
          (displayHeight(context) / 20),
      /* displayHeight(context) / 20 is the header of category of search*/
      child: GridView.builder(
        itemCount: filteredItemsBySearchString.length,
        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
//Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 0, // H  direction
//          crossAxisSpacing: 5,
          childAspectRatio: 140 / 180,
        ),
        shrinkWrap: false,
        itemBuilder: (_, int index) {
          final String foodItemName =
              filteredItemsBySearchString[index].itemName;
          final String foodImageURL =
              filteredItemsBySearchString[index].imageURL;

          final Map<String, dynamic> foodSizePrice =
              filteredItemsBySearchString[index].sizedFoodPrices;

          final List<dynamic> foodItemIngredientsList =
              filteredItemsBySearchString[index].ingredients;

          final bool foodIsAvailable =
              filteredItemsBySearchString[index].isAvailable;
          final String foodCategoryName =
              filteredItemsBySearchString[index].categoryName;
          final String foodCategoryNameShort =
              filteredItemsBySearchString[index].shorCategoryName;

          final dynamic euroPrice = foodSizePrice['normal'];

          double euroPrice2 = tryCast<double>(euroPrice, fallback: 0.0);

          String euroPrice3 = euroPrice2.toStringAsFixed(2);

          String documentID = filteredItemsBySearchString[index].documentId;

          List<String> juustoORCheeses =
              filteredItemsBySearchString[index].defaultJuusto;
          List<String> kastikeORSauces =
              filteredItemsBySearchString[index].defaultKastike;
          int sequenceNo = filteredItemsBySearchString[index].sequenceNo;

          FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(
            itemName: foodItemName,
            categoryName: foodCategoryName,
            shorCategoryName: foodCategoryNameShort,
            sizedFoodPrices: foodSizePrice,
            imageURL: foodImageURL,
            ingredients: foodItemIngredientsList,
            isAvailable: foodIsAvailable,
            documentId: documentID,
            defaultJuusto: juustoORCheeses,
            defaultKastike: kastikeORSauces,
            sequenceNo: sequenceNo,
          );

          String stringifiedFoodItemIngredients =
          listTitleCase(foodItemIngredientsList);

          return Container(
// `opacity` is alpha channel of this color as a double, with 0.0 being
//  ///   transparent and 1.0 being fully opaque.
              color: Color(0xffFFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
              child: InkWell(
                child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      child: new Container(
                        width: displayWidth(context) / 7,
                        height: displayWidth(context) / 7,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff707070),
                                blurRadius: 25.0,
                                spreadRadius: 0.10,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Hero(
                          tag: foodItemName,
                          child: ClipOval(
                            child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                              imageUrl: foodImageURL,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                            ),
                          ),
                          placeholderBuilder: (context, heroSize, child) {
                            return Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: displayWidth(context) / 7,
                                height: displayWidth(context) / 7,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                        color: Color(0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                        blurRadius: 25.0,
                                        spreadRadius: 0.10,
                                        offset: Offset(0, 10))
                                  ],
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                    imageUrl: foodImageURL,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            );
                          },
//                                  placeholderBuilder: (context,
//                                      Size.fromWidth(displayWidth(context) / 7),
//                          Image.network(foodImageURL)
//
//                                );
//Placeholder Image.network(foodImageURL),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                    ),
//                              SizedBox(height: 10),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                            euroPrice3 + '\u20AC',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
//                                          color: Colors.blue,
                                color: Color.fromRGBO(112, 112, 112, 1),
                                fontSize: 15),
                          ),
//                                    SizedBox(width: 10),
                          SizedBox(width: displayWidth(context) / 100),

                          Icon(
                            Icons.whatshot,
                            size: 24,
                            color: Colors.red,
                          ),
                        ]),

                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
//                '${dummy.counter}',
                        foodItemName,

                        style: TextStyle(
                          color: Color(0xff707070),
//                                color:Color.fromRGBO(112,112,112,1),

                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
//                                        height: displayHeight(context) / 61,

                        child: Text(
//                                'stringifiedFoodItemIngredients',

                          stringifiedFoodItemIngredients.length == 0
                              ? 'EMPTY'
                              : stringifiedFoodItemIngredients.length > 12
                              ? stringifiedFoodItemIngredients.substring(
                              0, 12) +
                              '...'
                              : stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5,
                            fontSize: 12,
                          ),
                        )),
//
//
                  ],
                ),
                onTap: () {
                  _navigateAndDisplaySelection(context, oneFoodItem);
                },
              ));
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
        },
      ),
    );
  }

  Widget foodListByCategoryandNoSearch(
      List<FoodItemWithDocID> filteredItemsByCategory, BuildContext context) {
    return Container(
      height: displayHeight(context) -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom,
/* displayHeight(context) / 20 is the header of category of search || like pizza and /14 is the
      * container holding the logo*/
      child: GridView.builder(
        itemCount: filteredItemsByCategory.length,
        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
//Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 0, // H  direction
//          crossAxisSpacing: 5, // horizontal padding error check image snpashot for details in august 10.
          childAspectRatio: 140 / 180,
        ),
        shrinkWrap: false,
        itemBuilder: (_, int index) {
          final String foodItemName = filteredItemsByCategory[index].itemName;
          final String foodImageURL = filteredItemsByCategory[index].imageURL;

          final Map<String, dynamic> foodSizePrice =
              filteredItemsByCategory[index].sizedFoodPrices;

          final List<dynamic> foodItemIngredientsList =
              filteredItemsByCategory[index].ingredients;

          final bool foodIsAvailable =
              filteredItemsByCategory[index].isAvailable;
          final String foodCategoryName =
              filteredItemsByCategory[index].categoryName;

          final String foodCategoryNameShort =
              filteredItemsByCategory[index].shorCategoryName;

          final dynamic euroPrice = foodSizePrice['normal'];

          double euroPrice2 = tryCast<double>(euroPrice, fallback: 0.0);

          String euroPrice3 = euroPrice2.toStringAsFixed(2);

          String documentID = filteredItemsByCategory[index].documentId;

          List<String> juustoORCheeses =
              filteredItemsByCategory[index].defaultJuusto;
          List<String> kastikeORSauces =
              filteredItemsByCategory[index].defaultKastike;
          int sequenceNo = filteredItemsByCategory[index].sequenceNo;

          FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(
            itemName: foodItemName,
            categoryName: foodCategoryName,
            shorCategoryName: foodCategoryNameShort,
            sizedFoodPrices: foodSizePrice,
            imageURL: foodImageURL,
            ingredients: foodItemIngredientsList,
            isAvailable: foodIsAvailable,
            documentId: documentID,
            defaultJuusto: juustoORCheeses,
            defaultKastike: kastikeORSauces,
            sequenceNo: sequenceNo,
          );

          String stringifiedFoodItemIngredients =
          listTitleCase(foodItemIngredientsList);

          return Container(
              color: Color(0xffFFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    new Container(
                      child: new Container(
                        width: displayWidth(context) / 6,
                        height: displayWidth(context) / 6,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff707070),
                                blurRadius: 25.0,
                                spreadRadius: 0.10,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Hero(
                          tag: foodItemName,
                          child: ClipOval(
                            child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                              imageUrl: foodImageURL,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                            ),
                          ),
                          placeholderBuilder: (context, heroSize, child) {
                            return Opacity(
                              opacity: 0.5,
                              child: Container(
                                width: displayWidth(context) / 7,
                                height: displayWidth(context) / 7,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        blurRadius: 25.0,
                                        spreadRadius: 0.10,
                                        offset: Offset(0, 20))
                                  ],
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: foodImageURL,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                    ),
                    SizedBox(height: 10),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            euroPrice3 + '\u20AC',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontSize: 16),
                          ),
                          SizedBox(width: displayWidth(context) / 100),
                        ]),

                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        foodItemName.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),

                    Container(
//                                        height: displayHeight(context) / 61,

                        child: Text(
//                                'stringifiedFoodItemIngredients',

                          stringifiedFoodItemIngredients.length == 0
                              ? 'EMPTY'
                              : stringifiedFoodItemIngredients.length > 12
                              ? stringifiedFoodItemIngredients.substring(
                              0, 12) +
                              '...'
                              : stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0.5,
                            fontSize: 12,
                          ),
                        )),
//
//
                  ],
                ),
                onTap: () {
                  _navigateAndDisplaySelection(context, oneFoodItem);
                },
              ));
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
        },
      ),
    );
  }

  _navigateAndDisplaySelection(
      BuildContext context, FoodItemWithDocID oneFoodItem) async {
//    var logger = Logger(
//      printer: PrettyPrinter(),
//    );

// Navigator.push returns a Future that completes after calling
// Navigator.pop on the Selection Screen.

//BELOW 2 LINES ARE FOR TEST FOR POPPING THE KEYBAORD FROM PAGE REDIRECTION
// FROM FOODDETAILS PAGE TO HERE.
// FOCUS WITH
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    final blocG = BlocProvider.of<FoodGalleryBloc>(context);


    List<CheeseItem> tempCheeseItems = blocG.getAllCheeseItemsFoodGallery;
    List<SauceItem> tempSauceItems = blocG.getAllSauceItemsFoodGallery;
    List<NewIngredient> allExtraIngredients = blocG.getAllExtraIngredients;


    final SelectedFood receivedSelectedFood = await
    Navigator.of(context).push(


      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(
            milliseconds: 900),
        pageBuilder: (_, __, ___) =>


            BlocProvider<FoodItemDetailsBloc>(
              bloc: FoodItemDetailsBloc(
                  oneFoodItem,
                  tempCheeseItems,
                  tempSauceItems,
                  allExtraIngredients

              ),


              child: FoodItemDetails2(),),

      ),
    );



// After the Selection Screen returns a result, hide any previous snackbars
// and show the new result.

    if ((receivedSelectedFood != null) &&
        (receivedSelectedFood.foodItemName != null)) {
//      print('| | | | | | | |   receivedSelectedFood.quantity: ${receivedSelectedFood.quantity}');

      print(
          '| | | | | | | |   receivedSelectedFood.selectedSauceItems: ${receivedSelectedFood.selectedSauceItems}');
      print(
          '| | | | | | | |   receivedSelectedFood.selectedCheeseItems: ${receivedSelectedFood.selectedCheeseItems}');

// List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;
//       int totalCount = tempSelectedFoodInOrder.fold(0, (t, e) => t + e.quantity);
//      int totalCount = tempSelectedFoodInOrder.reduce((a,element) => a.quantity +test1(element));

      int currentFoodItemQuantity = receivedSelectedFood.quantity;
      double unitPricecurrentFood = receivedSelectedFood.unitPrice;

//    Order tempOrder = orderFG;

//    tempOrder.selectedFoodInOrder.add(receivedSelectedFood);

// List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;
//       int totalCount = tempSelectedFoodInOrder.fold(0, (t, e) => t + e.quantity);

      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("selected ${receivedSelectedFood.quantity} items")));
//      setState(() => _reloadRequired = true);

      setState(() {
        _totalCount = _totalCount + receivedSelectedFood.quantity;
        allSelectedFoodGallery.add(receivedSelectedFood);
        totalPriceState =
            totalPriceState + currentFoodItemQuantity * unitPricecurrentFood;
      });

// bloc 1.

    } else {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("selected 0 items")));
    }
  }

// HELPER METHOD tryCast Number (1)
  int test1(SelectedFood x) {
    return x.quantity;
  }
// ALL FOODLIST CLASS RELATED FUNCTIONS ARE BLOW UNTIL CLASS STARTS THAT WE CAN PUT IN ANOTHER FILE.
// IF WE WANT, END'S HERE:

}

//
//class FoodList extends StatelessWidget {
//  FoodList({this.firestore});

//Widget FoodList extends StatelessWidget {
//
//
//final String categoryString;
//final String searchString2;
////  final List<NewIngredient> allIngredients;
//
//FoodList({this.categoryString, this.searchString2 /*,this.allIngredients */
//});
//
//final logger = Logger(
//  printer: PrettyPrinter(),
//);
//
//}

/*}*/
//}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
//    canvas.drawLine(...);
    final p1 = Offset(50, 20);
    final p2 = Offset(5, 20);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

//    canvas.drawRect();
//    canvas.drawCircle();
//    canvas.drawArc();
//    canvas.drawPath();
//
//    canvas.draImage();
//    canvas.drawRect();
//    canvas.drawImageNine();
//    canvas.drawParagraph();
//...
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class LongHeaderPainterAfter extends CustomPainter {
  final BuildContext context;
  LongHeaderPainterAfter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context) / 4, 15); //(X,Y) TO (X,Y)
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
  void paint(Canvas canvas, Size size) {
//    canvas.drawLine(...);
    final p1 = Offset(-displayWidth(context) / 4, 15); //(X,Y) TO (X,Y)
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

```