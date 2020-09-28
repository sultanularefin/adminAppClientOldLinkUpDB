import 'package:linkupadminolddb/src/utilities/screen_size_reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkupadminolddb/src/welcomePage.dart';

import './Widget/bezierContainer.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';

import 'package:linkupadminolddb/src/BLoC/clientPart/identity_bloc.dart';
import 'package:url_launcher/url_launcher.dart';



class LoginPage extends StatefulWidget {
  final bool showSnackbar0;
  LoginPage({Key key, this.title,this.showSnackbar0}) : super(key: key);

  final String title;


  @override
  _LoginPageState createState() => _LoginPageState(showSnackbar0);


}


class _LoginPageState extends State<LoginPage> {


  bool fromWhicPage1;
  _LoginPageState(this.fromWhicPage1);


  String emailState ='';
  String passwordState = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    if(fromWhicPage1==true){

      print(': : : : : fromWhicPage1: $fromWhicPage1 condition check in login page : : : : ');
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("You have been logged out")));
    }
    return new Scaffold(
        key: _scaffoldKey,
//    return Scaffold(
        body: SingleChildScrollView(
          child:Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[


                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),

                      Container(
                        height: displayHeight(context)/7,
                        padding: EdgeInsets.fromLTRB(8,8,8,4),

                        decoration: BoxDecoration(
                          // color: Color(0xffFFE18E),
                          color:Colors.blueGrey,

                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),


                        child: SingleChildScrollView(
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: 'this app was designed for 10-inch tablet (e.g. Samsung Galaxy '
                                  'Tab S6 or emulators where screen size is 10-inch ) ',
                              style:
                              TextStyle( //Theme.of(context).textTheme.display1,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color:
                                //Color(0xffe46b10),
                                Colors.yellowAccent,
//            Colors.deepOrange,
                              ),
                            ),
                          ),
                        ),
                      ),


                      Container(
                          child: titleWidget()
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _emailPasswordWidget(),

                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){
                          print("login button pressed");
//                            showDialog(
//                                context: context,
//                                builder: (BuildContext context) {
//                                  return Center(child: CircularProgressIndicator(),);
//                                });

                          _scaffoldKey.currentState.showSnackBar(
                              new SnackBar(duration: new Duration(seconds: 30), content:
                              new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("  Signing-In...",style:TextStyle(
                                    color: Colors.white38,
                                  ))
                                ],
                              ),
                              )
                          );
                          final identityBlocLoginPage =
                          BlocProvider.of<IdentityBloc>(context);
                          Future<UserCredential> userCheck=
                          identityBlocLoginPage.handleSignInFromLoginPage(emailState.trim(),passwordState.trim());

//                            _handleSignIn();

                          userCheck.whenComplete(() {

                            print("called when future completes");

                          }
                          ).then((onValue){

//                              FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
//                              List<NewIngredient> emptyIngs = [];

//                              Navigator.of(context).pop();


//                              pushNamedAndRemoveUntil
                            Navigator.of(context).pushAndRemoveUntil(
                              //        MaterialPageRoute(builder: (context) => HomeScreen())
                              //
                              //        MaterialPageRoute(builder: (context) => MyHomePage())
                                MaterialPageRoute(builder: (BuildContext context) {

                                  return BlocProvider<IdentityBloc>(
                                      bloc: IdentityBloc(),
                                      //AppBloc(emptyFoodItemWithDocID,loginPageIngredients,fromWhichPage:0),
                                      child: WelcomePage()
                                  );
                                  /*
                                  return BlocProvider<FoodGalleryBloc>(
                                      bloc: FoodGalleryBloc(),
                                      child: FoodGallery2()

                                  );

                                  */



//                                      drawerScreen()





                                }),(Route<dynamic> route) => false);









//                            _handleSignIn();
                          }).catchError((onError){
//                              logger.e('at onError');
                            _scaffoldKey.currentState.showSnackBar(
                              new SnackBar(duration: new Duration(seconds: 6), content:Container(
                                child:
                                new Row(
                                  children: <Widget>[
                                    new CircularProgressIndicator(),
                                    new Text("Error: ${onError.message.substring(0,40)}",style:
                                    TextStyle( /*fontSize: 10,*/ fontWeight: FontWeight.w500,
                                        color:Colors.white)),
                                  ],
                                ),
                              )),);

                          });
                        },

                        child:  _submitButton(),
                      ),

                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      /* */
                    ],
                  ),
                ),
                /*
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccountLabel(),
                  ),
                  */
                Positioned(top: 40, left: 0, child: _backButton()),
                Positioned(
                    top: -MediaQuery.of(context).size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer())
              ],
            ),
          ),

        )
    );
  }
  void setEmailState( text) {
    print(text);
    setState(() {
      emailState = text;
    });
  }

  void setPasswordState( text){
    print(text);
    setState(() {
      passwordState = text;
    });
  }





//  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;






  //functions marked 'async' must have a return type assignable to 'future'
  Future<bool> loadUser(/*String uid*/) async {

    print('at loadUser of Welcome Page');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //    ??=
    //    Assign the value only if the variable is null



    final resultString =   prefs.getString("userInfo");

    print('resultString in login Page $resultString');


    if(resultString == null) {

      return true;
    }
    print("found"); // thus nothing to return.
    return false;

    //1 means SharedPreference not empty.

  }





  Widget _backButton() {
    return InkWell(
      onTap: () {
        SystemNavigator.pop();
//        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  // email and password input.

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,

              textInputAction: !isPassword? TextInputAction.next :TextInputAction.done,
//              textInputAction: TextInputAction.next,
              onSubmitted:(_) => !isPassword?  FocusScope.of(context).nextFocus():
              FocusScope.of(context).unfocus(),

//              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              onChanged: (text) {
                !isPassword?
                setEmailState(text):setPasswordState(text);
//                print("First text field: $text");
              },

              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xffFFFA5F),
                  filled: true)
          )
        ],
      ),
    );
  }
//  _handleSignIn
  Widget _submitButton() {

    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [

                Colors.lightGreenAccent,
                Colors.lightBlueAccent,

//                  Color(0xfffbb448),
//                  Color(0xfff7892b)

              ]

          )

      ),

      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),


    );
  }


  // or login with facebook.












  Widget titleWidget1() {
    return RichText(
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
      ),
    );
  }


  Widget titleWidget() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'admin app',
          style:
          TextStyle( //Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color:
            //Color(0xffe46b10),
            Colors.pinkAccent,
//            Colors.deepOrange,
          ),
          children: [
            TextSpan(
              text: ' new ',
              style: TextStyle(color: Colors.indigoAccent, fontSize: 30),
            ),
            TextSpan(
              text: 'database',
              style: TextStyle(
                  color:
                  //Color(0xffe46b10),
//                  Colors.pinkAccent,
                  Colors.deepOrange,

                  fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }





}
