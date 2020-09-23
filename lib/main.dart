import 'package:flutter/material.dart';

import 'package:linkupadminolddb/src/BLoC/identity_bloc.dart';

import 'package:linkupadminolddb/src/welcomePage.dart';

import 'package:firebase_core/firebase_core.dart';


import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return
      BlocProvider<IdentityBloc>(
        bloc: IdentityBloc(),

          child: MaterialApp(

            title: 'Flutter Demo',
            // commented for Tablet testing on april 25.
            theme: ThemeData(

              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme:AppBarTheme(

                color:Colors.white,

                elevation:0,

              )

            ),
            debugShowCheckedModeBanner: false,
            home:WelcomePage(),

          ),

      );
  }
}
