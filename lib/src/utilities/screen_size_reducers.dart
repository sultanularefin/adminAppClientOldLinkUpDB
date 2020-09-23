

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//import 'package:google_sign_in/google_sign_in.dart';



//final GoogleSignIn _googleSignIn = GoogleSignIn();
//final FirebaseAuth _auth = FirebaseAuth.instance;


Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
double allscreenHeight(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).height - reducedBy) / dividedBy;
}
double screenWidth(BuildContext context,
    {double dividedBy = 1, double reducedBy = 0.0}) {
  return (screenSize(context).width - reducedBy) / dividedBy;
}
double screenHeightExcludingToolbar(BuildContext context,
    {double dividedBy = 1}) {
  return allscreenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
}


// from another medium resource.
// https://medium.com/tagmalogic/widgets-sizes-relative-to-screen-size-in-flutter-using-mediaquery-3f283afc64d6



Size displaySize(BuildContext context) {
//  debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
//  debugPrint('Height = ' + displaySize(context).height.toString());
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
//  debugPrint('Width = ' + displaySize(context).width.toString());
  return displaySize(context).width;

//  I/flutter ( 5454): Width = 800.0
//  I/flutter ( 5454): Height = 1232.0
}

//final String storageBucketURLPredicate =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';


String storageBucketURLPredicate =
    'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/';



//SharedPreferences prefs = await SharedPreferences.getInstance();
//
//final resultString = prefs.getString("userInfo");
//
//if (resultString == null){
//
//return false;
//}
//else{
//Map<String, dynamic> user = jsonDecode(
//resultString
//);



//Auth.getIdTokenResult()


/*


//Future<FirebaseUser> getUserInfo() async {
Future<String> getUserInfo2() async {
//    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: googleAuth.accessToken,
//      idToken: googleAuth.idToken,
//    );






 final String who_am_i = await _auth.currentUser().then((onValue)=>

       onValue.uid

  );

 print('who Am I: $who_am_i');

//  print('result: '  + result);

//  print('result: ${me.then((onValue)=>
//      {
//        onValue.uid
//      }
//  )}');

//  FirebaseUser user = result.user;







  return who_am_i;

  //    print("signed in " + user.displayName);

}

*/