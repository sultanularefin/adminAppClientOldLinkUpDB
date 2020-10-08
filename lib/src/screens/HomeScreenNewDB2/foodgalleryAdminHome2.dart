//## foodgallery Page August29: with android's Mainactivity invocation:
//
//```dart
// package/ external dependency files
import 'package:linkupadminolddb/src/BLoC/clientPart/identity_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseOLDCategoryBloc.dart';
import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseFoodBloc.dart';
import 'package:linkupadminolddb/src/BLoC/admin/AdminFirebaseIngredientBloc.dart';

// BLOC'S IMPORT BEGIN HERE:
// import 'package:linkupadminolddb/src/BLoC/app_bloc.dart';
//import 'package:linkupadminolddb/src/BLoC/bloc_provider2.dart';




// MODEL'S IMPORT BEGINS HERE.

import 'package:linkupadminolddb/src/screens/adminFirebase/admin_firebase_OldCategory.dart';
import 'package:linkupadminolddb/src/screens/adminFirebase/admin_firebase_food.dart';
import 'package:linkupadminolddb/src/screens/adminFirebase/admin_firebase_ingredient.dart';


import 'package:permission_handler/permission_handler.dart';


//import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:linkupadminolddb/src/screens/drawerScreen/DrawerScreenFoodGallery.dart';

// import 'dart:io';



import 'package:logger/logger.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:system_shortcuts/system_shortcuts.dart';

import 'package:linkupadminolddb/src/utilities/screen_size_reducers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:linkupadminolddb/src/welcomePage.dart';

import 'package:linkupadminolddb/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:linkupadminolddb/src/DataLayer/models/OldCategoryItem.dart';

// Blocks

import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';



class FoodGalleryAdminHome2 extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;

//  final Firestore firestore = Firestore.instance;

  FoodGalleryAdminHome2({Key key, this.child}) : super(key: key);

  _FoodGalleryState createState() => _FoodGalleryState();
}

class _FoodGalleryState extends State<FoodGalleryAdminHome2> {
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



//  this can be defined in Shopping cart page like old way
  int _totalCount = 0;


  String _batteryLevel = 'Unknown battery level.';

  bool blueToothState = false;
  bool wiFiState = false;

  @override
  void initState() {
    print('at initState of foodGallery page');

    // localStorageCheck();
//_getBatteryLevel();
    super.initState();
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



  Future<void> logout(BuildContext context2) async {
    print('what i do is : ||Logout||');


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



    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 900),
        pageBuilder: (_, __, ___) =>
            BlocProvider<IdentityBloc>(
              bloc: IdentityBloc(),
              child: WelcomePage(),
            ),
      ),
    );


    /*
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

    */
  }



  Widget about(BuildContext context){

    return SingleChildScrollView(
      child:Container(


        height: displayHeight(context)/5,
        padding: EdgeInsets.fromLTRB(8,8,8,4),

        decoration: BoxDecoration(
          // color: Color(0xffFFE18E),
          color:Colors.blueGrey,

          border: Border.all(
            color: Colors.blueGrey,
            style: BorderStyle.solid,
            width: 0.2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        child: titleWidget(),
      ),

    );



  }


  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Theme(
          data: ThemeData(
              primaryIconTheme: IconThemeData(
                color: Colors.black,
                // size: 40,
              )), // use this

          child: Scaffold(
            key: _scaffoldKeyFoodGallery,
            appBar: AppBar(

              automaticallyImplyLeading:false,
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
                            margin: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            height: displayHeight(context) / 10,   // for smaller device from /15 to /10 ....
                            // height: displayHeight(context) / 15,
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
                                        fontSize: 26,
                                        color: Color(0xff07D607),
                                        fontFamily: 'poppins'),
                                  ),
                                  Text(
                                    'Online Orders',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0xff07D607)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                        height: kToolbarHeight +
                            6, // 6 for spacing padding at top for .
                        width: displayWidth(context)
                            -200
                            -MediaQuery.of(context).size.width / 3.8,
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

                        padding:
                        EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                        child:
                        Container(
                          alignment: Alignment.center,
                          width: displayWidth(context) / 4.7,
                          child:Container(),

                        )

                    ),



                  ],
                ),
              ),
            ),

            body:  SingleChildScrollView(
//              color:Colors.lightGreenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // color: Colors.white,

                    width: displayWidth(context) -
                        MediaQuery.of(context).size.width / 3.8,
                    height: displayHeight(context) + kToolbarHeight + 10 ,
                    child: Column(
                      children: [

                        Container(child:displayHeight(context)>800?about(context):
                        Container(


                          child: Text('the app was designed for 10-inch tablet (e.g. Samsung Galaxy '
                              'Tab S6 or emulators where screen size is 10-inch ) , or check the '
                              'login page for details.'),
                        )
                        ),
                        navigationButtonsAndDescription(context),
                      ],
                    ),
                  ),
                  Container(
                    height: displayHeight(context) + kToolbarHeight + 10,
                    width: MediaQuery.of(context).size.width / 3.8,
                    color: Color(0xffFFE18E),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("2020",
                          // .toUpperCase(),

                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 30,
                          ),
                        ),

                        Text(
                          '\u00a9',

                          // .toUpperCase(),

                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                          ),
                        ),

                        // SizedBox(height: 100),

                        Text(
                          'Arefin',
                          // .toUpperCase(),

                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),



                  ),
                ],
              ),
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
                        'order Application'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 40,
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

                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      title: Container(
                          color: Color(0xffFFE18E),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child:
                                Icon(
                                  Icons.portrait,
                                  size: displayWidth(context) / 19,
                                  color: Color(0xff707070),
                                ),







                              ),

                              Container(
//                          width: displayWidth(context)/3.9,
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                                child: Text(
//                                  'maksamatta'.toUpperCase(),
                                  'log out'.toUpperCase(),
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

                        return logout(context);

                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),



                    ListTile(
                      title: Container(
                          color: Color(0xffFFE18E),
                          child: Row(
                            children: [


                              Container(
//                          width: displayWidth(context)/3.9,
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                                child: Text(
//                                  'maksamatta'.toUpperCase(),
                                  'EMPTY EMPTY'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.normal,
                                    color: Colors.lightBlueAccent,
                                    // color: Colors.black,

                                  ),
                                ),
                              )
//                      Text('history'),
                            ],
                          )),
                      onTap: () {
                        print('nothing will happen');
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
              },
            ),
          ],
        ),

      ),
    );
  }


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

    if (stringList.length == 0) {
      return " ";
    } else if (stringList == null) {
      return ' ';
    } else {
      return stringList
          .map((word) => word
          .toString()
          .split(' ')
          .map((word2) => titleCase(word2))
          .join(' '))
          .join(', ');
    }
  }


  Widget titleWidget() {
    return
      RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
            text: 'the app was designed for 10-inch tablet (e.g. Samsung Galaxy '
                'Tab S6 or emulators where screen size is 10-inch ) ',
            style:
            TextStyle( //Theme.of(context).textTheme.display1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color:
              //Color(0xffe46b10),
              Colors.lightGreenAccent,
//            Colors.deepOrange,
            ),
            children: [
              TextSpan(
                text: '  use \'adb push\' to push images then '
                    '',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'upload to firestore one at a time.',
                style: TextStyle(
                    color:
                    //Color(0xffe46b10),
//                  Colors.pinkAccent,
                    Colors.deepOrange,

                    fontSize: 30),
              ),
            ]),
      )
    ;
  }


  Widget navigationButtonsAndDescription(BuildContext context) {
    // final foodGalleryBloc = BlocProvider.of<FoodGalleryBloc>(context);

    return Container(
      // color: Colors.purpleAccent,
      height: displayHeight(context) + kToolbarHeight + 10 -400 ,

      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [



          Container(

            height: displayHeight(context) + kToolbarHeight + 10-400 ,
            // height: (displayHeight (context))-
            //     (kToolbarHeight +
            //         6 + displayHeight(context)/6),
            // 6 for spacing padding at top for .
            width: displayWidth(context)
                -(200
                    -(MediaQuery.of(context).size.width / 3.8)
                ),

            child: navigationButtonsWidget(),



          ),
        ],
      ),



    );

  }

  Widget navigationButtonsWidget(){

    return Container(
      // color: Color(0xffFFE18E),
      alignment: Alignment.center,
      child: ListView(

        padding: EdgeInsets.zero,
        // padding: EdgeInsets.fromLTRB(0,0,10,0),
        children: <Widget>[

          SizedBox(
            height: 50,
          ),

          ListTile(
            title: Container(
                color: Color(0xffFFE18E), height: 90,
                // color: Color(0xffFFE18E),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child:Row(
                        children: [
                          Icon(
                            Icons.food_bank,
                            size: displayWidth(context) / 19,
                            color: Color(0xff707070),
                          ),
                          Icon(
                            Icons.food_bank,
                            size: displayWidth(context) / 19,
                            color: Color(0xff707070),
                          ),

                        ],
                      ),
                    ),

                    Container(
//                          width: displayWidth(context)/3.9,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                      child: Text(
                        'add new food'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'historia',
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
//                      Text('history'),
                  ],
                )),
            onTap: () async {



//          final Permission permission= Permission.contacts;
              final Permission permission= Permission.camera;
              print('at Future<void> requestPermission $permission');

              final status = await permission.request();

              print('status: $status');

              switch (status) {
                case PermissionStatus.granted:
                  print('PermissionStatus.granted');
                  // do something
                  break;
                case PermissionStatus.denied:
                  print('PermissionStatus.denied');
                  // do something
                  break;
                case PermissionStatus.restricted:
                  print('PermissionStatus.restricted');
                  // do something
                  break;
                case PermissionStatus.permanentlyDenied:
                  print('PermissionStatus.permanentlyDenied');
                  // do something
                  break;
                case PermissionStatus.undetermined:
                  print('PermissionStatus.undetermined');
                  // do something
                  break;
                default:
              }

              /// Android: Nothing
              /// iOS: Photos
              // static const photos = Permission._(9);


              // final Permission permission2= Permission.photos;
              // print('at Future<void> requestPermission $permission2');
              //
              // final status2 = await permission2.request();
              //
              // print('status: $status');
              //
              // switch (status) {
              //   case PermissionStatus.granted:
              //     print('PermissionStatus.granted');
              //     // do something
              //     break;
              //   case PermissionStatus.denied:
              //     print('PermissionStatus.denied');
              //     // do something
              //     break;
              //   case PermissionStatus.restricted:
              //     print('PermissionStatus.restricted');
              //     // do something
              //     break;
              //   case PermissionStatus.permanentlyDenied:
              //     print('PermissionStatus.permanentlyDenied');
              //     // do something
              //     break;
              //   case PermissionStatus.undetermined:
              //     print('PermissionStatus.undetermined');
              //     // do something
              //     break;
              //   default:
              // }






              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: Duration(milliseconds: 900),
                  pageBuilder: (_, __, ___) =>
                      BlocProvider<AdminFirebaseFoodBloc>(
                        bloc: AdminFirebaseFoodBloc(),
                        child: AdminFirebaseFood(),
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
              // color: Color(0xffFFE18E),
                color: Color(0xffFFE18E), height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child:Row(
                        children: [
                          Icon(
                            Icons.fire_extinguisher_rounded,
                            size: displayWidth(context) / 19,
                            color: Color(0xff707070),
                          ),
                          Icon(
                            Icons.fire_extinguisher_rounded,
                            size: displayWidth(context) / 19,
                            color: Color(0xff707070),
                          ),
                        ],
                      ),
//                                child:....... 911_1_ work_1
                      /*Image.asset(
                                  'assets/history.png',
//                color: Colors.black,
                                  width: 30,
                                  height: 30,
                                ),

                                */
                    ),

                    Container(
//                          width: displayWidth(context)/3.9,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                      child: Text(
                        'add new ingredient ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'historia',
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey
                        ),
                      ),
                    )
//                      Text('history'),
                  ],
                )),
            onTap: () async {




//          final Permission permission= Permission.contacts;
              final Permission permission= Permission.camera;
              print('at Future<void> requestPermission $permission');

              final status = await permission.request();

              print('status: $status');

              switch (status) {
                case PermissionStatus.granted:
                  print('PermissionStatus.granted');
                  // do something
                  break;
                case PermissionStatus.denied:
                  print('PermissionStatus.denied');
                  // do something
                  break;
                case PermissionStatus.restricted:
                  print('PermissionStatus.restricted');
                  // do something
                  break;
                case PermissionStatus.permanentlyDenied:
                  print('PermissionStatus.permanentlyDenied');
                  // do something
                  break;
                case PermissionStatus.undetermined:
                  print('PermissionStatus.undetermined');
                  // do something
                  break;
                default:
              }


              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: Duration(milliseconds: 900),
                  pageBuilder: (_, __, ___) =>
                      BlocProvider<AdminFirebaseIngredientBloc>(
                        bloc: AdminFirebaseIngredientBloc(),
                        child: AdminFirebaseIngredient(),
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
              // color: Color(0xffFFE18E),
                color: Color(0xffFFE18E), height: 90,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child:Row(
                        children: [
                          Icon(
                            Icons.fire_extinguisher_rounded,
                            size: displayWidth(context) / 19,
                            color: Color(0xff707070),
                          ),
                          Icon(
                            Icons.fire_extinguisher_rounded,
                            size: displayWidth(context) / 19,
                            color: Color(0xff707070),
                          ),
                        ],
                      ),

                    ),

                    Container(
//                          width: displayWidth(context)/3.9,
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                      child: Text(
                        'add new Category'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'historia',
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey
                        ),
                      ),
                    )
//                      Text('history'),
                  ],
                )),
            onTap: () async {




//          final Permission permission= Permission.contacts;
              final Permission permission= Permission.camera;
              print('at Future<void> requestPermission $permission');

              final status = await permission.request();

              print('status: $status');

              switch (status) {
                case PermissionStatus.granted:
                  print('PermissionStatus.granted');
                  // do something
                  break;
                case PermissionStatus.denied:
                  print('PermissionStatus.denied');
                  // do something
                  break;
                case PermissionStatus.restricted:
                  print('PermissionStatus.restricted');
                  // do something
                  break;
                case PermissionStatus.permanentlyDenied:
                  print('PermissionStatus.permanentlyDenied');
                  // do something
                  break;
                case PermissionStatus.undetermined:
                  print('PermissionStatus.undetermined');
                  // do something
                  break;
                default:
              }


              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: Duration(milliseconds: 900),
                  pageBuilder: (_, __, ___) =>
                      BlocProvider<AdminFirebaseOLDCategoryBloc>(
                        bloc: AdminFirebaseOLDCategoryBloc(),
                        child: AdminFirebaseCheese(),
                      ),
                ),
              );
            },
          ),




          SizedBox(
            height: 50,
          ),



        ],
      ),
    );
  }

}



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
