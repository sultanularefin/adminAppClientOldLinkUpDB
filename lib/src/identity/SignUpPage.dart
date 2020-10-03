import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';
import 'package:linkupadminolddb/src/identity/Widget/bezierContainer.dart';
import 'package:linkupadminolddb/src/identity/loginPage.dart';
import 'package:linkupadminolddb/src/BLoC/clientPart/identity_bloc.dart';
import 'package:linkupadminolddb/src/screens/HomeScreenNewDB2/foodgalleryAdminHome2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
//import 'package:google_fonts/google_fonts.dart';



class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController =  new TextEditingController();




  // AuthService authService = new AuthService();
  // DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;


  // AuthService authService = new AuthService();


  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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


  _saveUser(String uid, User x, String loggerEmail,
      String loggerPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    ??=
//    Assign the value only if the variable is null

    Map<String, dynamic> toJson() =>
        {
          'email': loggerEmail,
          'password': loggerPassword,
//      'uid': uid,
        };


    //  print('setString method going to be called where key is userInfo');
    prefs.setString('userInfo', jsonEncode({
      'email': loggerEmail,
      'password': loggerPassword,
      'uid': uid,
    })).then((onValue) =>
    {
      //  print('at then of prefs.setString(userInfo.....')
    });


    // print('user set in mobile storage');


    final resultString = prefs.getString("userInfo");

    Map<String, dynamic> user = jsonDecode(
        resultString
    );


  }

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });
      final FirebaseAuth _auth = FirebaseAuth.instance;


      final identityBlocLoginPage =
      BlocProvider.of<IdentityBloc>(context);

      await identityBlocLoginPage.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
        if(result != null){

          User _currentFBUser;
          User fireBaseUserRemote = result.user;

          _currentFBUser = fireBaseUserRemote;

          _saveUser(fireBaseUserRemote.uid,fireBaseUserRemote,
              emailEditingController.text.trim(), passwordEditingController.text.trim());


          Navigator.of(context).pushAndRemoveUntil(

              MaterialPageRoute(builder: (BuildContext context) {

                return BlocProvider<IdentityBloc>(
                    bloc: IdentityBloc(),
                    child: FoodGalleryAdminHome2(),

                    // child: FoodGalleryAdminHome2()
                );

              }),(Route<dynamic> route) => false);

        }
      });
    }
  }


  Widget _submitButton() {
    return GestureDetector(

      onTap: (){
        singUp();
      },






      child: Container(
        width: MediaQuery.of(context).size.width,
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
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'old admin ',
//          style: TextStyle(fontStyle: FontStyle.italic),
          style: //GoogleFonts.portLligatSans(
          TextStyle( //Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'page',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' restaurant app',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }



  InputDecoration textFieldInputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: /*Colors.white54*/Colors.blueGrey),
        // Colors.blueGrey
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: /*Colors.white*/Colors.blueGrey)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(
            color: /*Colors.white*/ Colors.blueGrey)));
  }



  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: /*Colors.white*/ Colors.blueGrey, fontSize: 16),
                controller: usernameEditingController,
                validator: (val){
                  return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                },
                decoration: textFieldInputDecoration("username"),
              ),
              TextFormField(
                controller: emailEditingController,
                style: TextStyle(color: /*Colors.white*/ Colors.blueGrey, fontSize: 16),
                validator: (val){
                  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                  null : "Enter correct email";
                },
                decoration: textFieldInputDecoration("email"),
              ),
              TextFormField(
                obscureText: true,
                style: TextStyle(color: /*Colors.white*/ Colors.blueGrey, fontSize: 16),
                decoration: textFieldInputDecoration("password"),
                controller: passwordEditingController,
                validator:  (val){
                  return val.length < 6 ? "Enter Password 6+ characters" : null;
                },

              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:Container(
              height: MediaQuery.of(context).size.height,
              child:Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: SizedBox(),
                        ),
                        _title(),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _loginAccountLabel(),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )
        )
    );
  }
}
