


// EXTERNAL PKGS BELOW.
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
// EXTERNAL PKGS ABOVE.

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';



//import 'package:foodgallery/src
// above are local files i.e. pages .
import 'package:foodgallery/src/identity/loginPage.dart';
//import 'package:foodgallery/src/identity/signup.dart';
//import 'package:foodgallery/src/screens/drawerScreen/DrawerScreenFoodGallery.dart';
//import 'package:foodgallery/src/screens/homeScreen/food_gallery.dart';
// above are local file.


// 3rd party packages:

//import 'package:google_fonts/google_fonts.dart';

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

//TODO STATE ful widget not required
//class MyApp extends StatelessWidget {

/*  Block related Files BELOW */

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/identity_bloc.dart';
import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';

//import 'package:foodgallery/src/BLoC/app_bloc.dart';
//import 'package:foodgallery/src/BLoC/bloc_provider2.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
//import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';
//import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:permission_handler/permission_handler.dart';



/*  Block related Files ABOVE */


class WelcomePage extends StatefulWidget {

  final String fromWhicPage;
  final String title;
  WelcomePage({Key key, this.title,this.fromWhicPage}) : super(key: key);



//  (fromWhicPage:'foodGallery2')

  @override
  _WelcomePageState createState() => _WelcomePageState(fromWhicPage);
}

class _WelcomePageState extends State<WelcomePage> {


  // Login Button.
  String fromWhicPage2='';
  _WelcomePageState(this.fromWhicPage2);


  @override
  void initState(){

    // possible scenarios:


    // 1. no local storage, (app deleted and reinstalled || or first time user ) go to Login page.
    // MORE AT HERE : localStorageCheck();

    // 2. if the email found in loCAL STORAGE, LOCAL STORAGE ARE CREATED ONLY WHEN SUCCESSFUL LOGIN WERE MADE WITH
    // CERTAIN EMAIL AND PASSWORD.
    // THUS THERE COULD BE 2 SCENARIOS{
    /*
     1. CHECK WITH THIS CREDENTIALS WITH FIRE BASE AUTH IF SUCCESS GO TO FIREBASE PAGE.
     2. ADMIN CAN DELETE THE USER FROM FIREBASE AUTH LIST THEN USER CAN'T LOGIN AND HE NEEDS TO LOGIN AGAIN WITH THE
     ADMIN RPOVIDE USER NAME AND PASSWROD.

     3. I THINK I IMPLEMENTED ALL BUT SOME NETWORKING RELATED CODE LIKE connectionState etc needs to be checked again.
     in the future (might not need now.).

     */

    localStorageCheck(fromWhicPage2);

    //  this requred since stream can only handle one kind of variale. In this page FirebaseUser.

    //  // check paper why we need it.
    // check the data Type at here.
    /*
    stream: identityBloc.getCurrentFirebaseUserStream,
            initialData: identityBloc.getCurrentFirebaseUser,
    */

    super.initState();

  }


  // Future<void> return type .  ??
  Future<void> localStorageCheck (String fromWhichPageString) async{

    // 3 scenarios.

//    logger.e('at localStorageCheck of welcome page\'s init state :  ');

    // print('< >   <   >   <    >  :: // ::  // at here: localStorageCheck');

    /*
    final identityBlocInvokerAppBlockWelcomPageInitState
    = BlocProvider2.of(context).getIdentityBlocsObject;
    */
    final identityBlockinInitState = BlocProvider.of<IdentityBloc>(context);

    bool x= await identityBlockinInitState.checkUserinLocalStorage();

    if ((x==false) && (fromWhichPageString=='foodGallery2')){

//      logger.e('going to welcome page\'s init state : fromWhichPageString==\'foodGallery2\'  ');

      return Navigator.push(

          context, MaterialPageRoute(builder: (context) => LoginPage(showSnackbar0:true))

      );
    }
    else if (x==false){

//      logger.e('going to welcome page\'s init state :  ');

      return Navigator.push(

          context, MaterialPageRoute(builder: (context) => LoginPage())

      );
    }

    else{
      // await setAllIngredients();
      /* ${test.length}*/

//      logger.e('at return of welcome page\'s init state :  ');
      return;
    }

  }






  /*
  @override
  void didChangeDependencies() {

    localStorageCheck();
    super.didChangeDependencies();
//    final foo = Foo.of(context);
//    if (this.foo != foo) {
//      this.foo = foo;
//      foo.doSomething();
//    }
  }

  */



  @override
  Widget build(BuildContext context) {
//    logger.e('at build of welcome page');

    FoodItemWithDocID emptyFoodItemWithDocID = new FoodItemWithDocID();


    final identityBloc = BlocProvider.of<IdentityBloc>(context);



    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: StreamBuilder<User>(

            stream: identityBloc.
            getCurrentFirebaseUserStream,
            initialData: identityBloc.
            getCurrentFirebaseUser,
            builder: (context, snapshot) {
//              switch (snapshot.connectionState){
//                case ConnectionState.waiting:
//                case ConnectionState.none:
//                return Center(
//                  child: Column(
//                    children: <Widget>[
//
//                      Center(
//                        child: Container(
//                            alignment: Alignment.center,
//                            child: new CircularProgressIndicator(
//                                backgroundColor: Colors.lightGreenAccent)
//                        ),
//                      ),
//                      Center(
//                        child: Container(
//                            alignment: Alignment.center,
//                            child: new CircularProgressIndicator(
//                              backgroundColor: Colors.yellow,)
//                        ),
//                      ),
//                      Center(
//                        child: Container(
//                            alignment: Alignment.center,
//                            child: new CircularProgressIndicator(
//                                backgroundColor: Colors.redAccent)
//                        ),
//                      ),
//                    ],
//                  ),
//                );
//                case ConnectionState.active:
//                case ConnectionState.done:
//              }
//              if(snapshot.error){
//                return  Center(
//                  child: Container(
//                    alignment: Alignment.center,
//                    child: Text('something went wrong'),
//                  ),
//                );
//              }

           //   print('snapshot.hasData: ${snapshot.hasData}');


              if (snapshot.hasError) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('something went wrong'),
                  ),
                );
              }


              /*
              if (snapshot.hasData) {
                print('snapshot.hasData is ${snapshot
                    .hasData} in Welcome page ');

                if (snapshot.data is FirebaseUser) {
                  /*
                return
                  BlocProvider<FoodGalleryBloc>(
                    bloc: FoodGalleryBloc(),
                    child: FoodGallery2(),
                  );
                */

                  print('  :: ::  snapshot.data is FirebaseUser');

                  FoodItemWithDocID emptyFoodItemWithDocID = new FoodItemWithDocID();


//                  List<NewIngredient> _allIngredientState = [];
//                  List<NewIngredient> emptyIngs = [];


//                  final bloc = BlocProvider2.of(context).getFoodGalleryBlockObject;


//                  FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped, {int fromWelComePage=0
                  return (

                      BlocProvider<FoodGalleryBloc>(
                          bloc: FoodGalleryBloc(),
                          child: FoodGallery2()

                      )
                  /*
                      BlocProvider2(/*thisAllIngredients2:welcomPageIngredients, */
                          bloc2: AppBloc(
                              emptyFoodItemWithDocID, []),
                          /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                          child: FoodGallery2()
                      )

                      */

                  );
                }
                else {
                  return LoginPage();
                }
              }
              */
              else {
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
                                      backgroundColor: Colors.lightGreenAccent)
                              ),
                            ),
                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: new CircularProgressIndicator(
                                    backgroundColor: Colors.yellow,)
                              ),
                            ),
                            Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: new CircularProgressIndicator(
                                      backgroundColor: Colors.redAccent)
                              ),
                            ),
                          ],
                        ),
                      ),

                    );
                    break;
                  case ConnectionState.active:
                    /*
                    return (snapshot.data is FirebaseUser) ?

                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    )

                    /*
                    BlocProvider2(/*thisAllIngredients2:welcomPageIngredients, */
                        bloc2: AppBloc(
                            emptyFoodItemWithDocID, []),
                        /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                        child: FoodGallery2()
                    )
              */
                    /*
                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    )*/ : LoginPage();
//                  print('at ConnectionState.active of switch');
                    break;


                  case ConnectionState.done:
//                  print('at ConnectionState.done of switch');
//                break;


                    return (snapshot.data is FirebaseUser) ?

                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    )
                    /*
                    BlocProvider2(/*thisAllIngredients2:welcomPageIngredients, */
                        bloc2: AppBloc(
                            emptyFoodItemWithDocID, []),
                        /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                        child: FoodGallery2()
                    )
                    */
                    /*
                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    )*/ : LoginPage();

                    break;
                    */
                  default:
                    return (snapshot.data is User) ?

                    /*
                    BlocProvider2(/*thisAllIngredients2:welcomPageIngredients, */
                        bloc2: AppBloc(
                            emptyFoodItemWithDocID, [] /*,*/
                            /* fromWhichPage: 0 */),
                        /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                        child: FoodGallery2()
                    )
                    */


                    BlocProvider<FoodGalleryBloc>(
                        bloc: FoodGalleryBloc(),
                        child: FoodGallery2()

                    ) : LoginPage();
                }
              }
            }
        ),

      ),

    );
  }
}
