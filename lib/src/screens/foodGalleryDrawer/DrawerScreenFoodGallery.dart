
// dependency files
import 'package:flutter/material.dart';
//import 'package:foodgallery/src/screens/adminFirebase/adminIngredientsForFood.dart';
//import 'package:foodgallery/src/screens/adminFirebase/admin_firebase_ingredient.dart';
//import 'package:foodgallery/src/screens/animatedSample/AnimatedListSample.dart';
//import 'package:foodgallery/src/screens/homeScreen/food_gallery.dart';
//import 'package:foodgallery/src/screens/productScan/product_scan_checkBox.dart';
//import 'package:foodgallery/src/screens/storageTest.dart';
//import 'package:foodgallery/src/screens/testPages/customClipper_test.dart';
//import 'package:foodgallery/src/screens/wastedDetails/wasted_details.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


// Screen files.
import 'package:foodgallery/src/welcomePage.dart';
//import 'package:foodgallery/src/screens/adminFirebase/admin_firebase_food.dart';
//import 'package:foodgallery/src/screens/profileScreen/profileScreen.dart';
//import 'package:foodgallery/src/welcomePage.dart';
//import 'package:foodgallery/src/screens/productScan/product_scan_radio.dart';
//import 'package:foodgallery/src/screens/spinkit_test.dart';
//import 'package:foodgallery/src/screens/testPages/multipleSliver.dart';
//import 'package:foodgallery/src/screens/row_column_test.dart';


class DrawerScreenFoodGallery extends StatelessWidget {


  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  // This widget is the root of your application.


  /*

  Future<void> _handlePressForProfile(String task,BuildContext context2) async {

    print('what i do is : ' + task);




    return Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => ProfileScreen()),
    );
  }


//  Future<FirebaseUser> _handleSignIn() async {
    Future<void> _handlePressForAddNewFood(String task,BuildContext context2) async {
    print('what i do is : ' + 'add new food');

    return Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => AdminFirebaseFood()),
    );
  }

  //  Future<FirebaseUser> _handleSignIn() async {
  Future<void> _handlePressForAddNewIngredients(String task,BuildContext context2) async {
    print('what i do is : ' + 'add new ingredients');

    return Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => AdminFirebaseIngredients()),
    );
  }

  */



  Future<void> Logout(BuildContext context2) async {
   // print('what i do is : ||Logout||');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => WelcomePage()),
    );


  }
    /*

  Future<void> wastedDetailsPageTest(BuildContext context2) async {
    print('what i do is : ||wastedDetailsPageTest || invoker');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => WastedDetails()),
    );


  }


  Future<void> goToProductScanScreenRadio(BuildContext context2) async {
    print('what i do is : ||Product Scan Screen Radio||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => ProductScannerRadio()),
    );


  }

  Future<void> goToProductScanScreenCheckBox(BuildContext context2) async {
    print('what i do is : ||Product Scanner CheckBox||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => ProductScannerCheckBox()),
    );


  }

  Future<void> goToPAddIngredient_forFood(BuildContext context2) async {
    print('what i do is : ||Add Ingredient for Food||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => AdminIngredientsForFood()),
    );


  }

  Future<void> goToMultipleSlivers(BuildContext context2) async {
    print('what i do is : ||MultipleSlivers Test||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => MultipleSlivers()),
    );


  }


  Future<void> goToRowColumnTest(BuildContext context2) async {
    print('what i do is : ||RowColumnTest Test||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => RowColumnTest()),
    );


  }



//  


  Future<void>flutterStorageTestScreen(BuildContext context2) async {
    print('what i do is : ||Firebase Storage Testing.||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => StorageTest()),
    );


  }

  Future<void>spinKitTest(BuildContext context2) async {
    print('what i do is : ||Firebase Storage Testing.||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => SpinkitTest()),
    );


  }


  Future<void>goToAnimatedListSample(BuildContext context2) async {
    print('what i do is : ||go To Animated List Sample.||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => AnimatedListSample()),
    );


  }



  Future<void>goToCustomClipperTest(BuildContext context2) async {
    print('what i do is : ||go To Custom Clipper Example.||');

//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear();
    Navigator.push(
      context2,
      MaterialPageRoute(builder: (context2) => CustomClipperTest()),
    );


  }
  */













  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Side Menu Burger Icon'),
        backgroundColor: Colors.deepOrange,
      ),
      key: _drawerKey, // assign key to Scaffold
//        endDrawer: Drawer(
      drawer: Drawer(
          child:ListView(
            children: <Widget>[
              DrawerHeader(decoration: BoxDecoration(
                  gradient: LinearGradient
                    (colors: <Color>[
                    Colors.deepOrange,
                    Colors.deepOrange,
                  ])
              ),
                  child:Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            elevation: 10,
                            child:Padding(padding: EdgeInsets.all(8.0),
                              child:Image.asset('assets/images/as.png',

                                width: 80,
                                height:80,
                              ),)
//                          child:
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.01),
                            child:Text('Flutter',
                                style: TextStyle(color: Colors.white,
                                    fontSize: 16.0)))
                      ],

                    ),
                  )
              ),
              SizedBox(height: 16.0),
              /*
              CustomListTile(
                  iconData: Icons.person,
                  text: 'Profile',
                  onPressed: () =>

                      _handlePressForProfile('profile',context)
              ),
              CustomListTile(iconData:
              Icons.notifications,
                  text:'Add New Food Item',
                  onPressed:()=>_handlePressForAddNewFood('Add New Food Item',context)
              ),

              CustomListTile(iconData:
              Icons.notifications,
                  text:'Add New Ingredients Item',
                  onPressed:()=>_handlePressForAddNewIngredients('Add New Ingredient Item',context)
              ),
//
              CustomListTile(iconData:
              Icons.settings,
                  text:'Food Gallery',

                  onPressed:()=>

//                      Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => FoodGallery()),
//                  )


                  // this removes the back handler icon as this is the 1st index screen.
                  Navigator.of(context).
                  pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      FoodGallery()), (Route<dynamic> route) => false),




              ),
              CustomListTile(
                  iconData:Icons.satellite,
                  text:'Product Scan Radio',
                  onPressed :()=>goToProductScanScreenRadio(context)



              ),

              CustomListTile(
                  iconData:Icons.check_box,
                  text:'Product Scan CheckBox',
                  onPressed :()=>goToProductScanScreenCheckBox(context)



              ),

              CustomListTile(
                  iconData:Icons.check_box,
                  text:'add Ingredient for Food',
                  onPressed :()=>goToPAddIngredient_forFood(context)



              ),

              CustomListTile(
                  iconData:Icons.business_center,
                  text:'Storage Test',
                  onPressed :()=>flutterStorageTestScreen(context)



              ),

              CustomListTile(
                  iconData:Icons.business_center,
                  text:'SpinKit Test',
                  onPressed :()=>spinKitTest(context)



              ),

              CustomListTile(
                  iconData:Icons.business_center,
                  text:'Wasted Details Page',
                  onPressed :()=>wastedDetailsPageTest(context)



              ),
              CustomListTile(
                  iconData:Icons.lock,
                  text:'go To MultipleSlivers',
                  onPressed :()=>goToMultipleSlivers(context)



              ),

//
//

              CustomListTile(
                  iconData:Icons.lock,
                  text:' Row Column Test',
                  onPressed :()=> goToRowColumnTest(context)



              ),



              CustomListTile(
                  iconData:Icons.lock,
                  text:'Animated List Sample',
                  onPressed :()=>goToAnimatedListSample(context)

              ),

              CustomListTile(
                  iconData:Icons.airline_seat_recline_normal,
                  text:'Custom Clipper test page.',
                  onPressed :()=>goToCustomClipperTest(context)

              ),


*/


              CustomListTile(
                  iconData:Icons.lock,
                  text:'Log Out',
                  onPressed :()=>Logout(context)



              ),


            ],
          )
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu),
        backgroundColor: Colors.green,
        onPressed: () => _drawerKey.currentState.openDrawer(), // open drawer
      ),


    );
  }
}


class CustomListTile extends StatelessWidget{

  final IconData iconData;
//  IconData icon;
  final String text;
  final GestureTapCallback onPressed;
//  Function onTap;

  CustomListTile({this.iconData,
    this.text, this.onPressed});



//  Function onPressed;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      // When the child is tapped, show a snackbar.
        onTap: onPressed,
        // The custom button
        child: Container(
            padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
            child:Container(
                decoration:BoxDecoration(
                  border: Border(
                      bottom:BorderSide(color:Colors.red)

                  ),),
                child:InkWell(
                    splashColor: Colors.deepOrangeAccent,
//                    onTap: ()=>onTap,
                    child:Container(
                        height: 55,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(children: <Widget>[
                              Icon(iconData),
                              Padding(padding:const EdgeInsets.all(8.0),
                                child:Text(text,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )

                            ],
                            ),

                            Icon(Icons.arrow_right),

                          ],
                        )
                    )
                )

            )
        )
    );

  }
}

