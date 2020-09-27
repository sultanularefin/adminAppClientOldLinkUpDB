import 'package:flutter/material.dart';

import 'package:linkupadminolddb/src/BLoC/clientPart/identity_bloc.dart';

import 'package:linkupadminolddb/src/welcomePage.dart';

import 'package:firebase_core/firebase_core.dart';


import 'package:linkupadminolddb/src/BLoC/bloc_provider.dart';


// ic launcher image created from this link, copied from pixaby:

// Image by <a href="https://pixabay.com/users/Einladung_zum_Essen-3625323/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=1804457">Bernadette Wurzinger</a> from <a href="https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=1804457">Pixabay</a>

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
