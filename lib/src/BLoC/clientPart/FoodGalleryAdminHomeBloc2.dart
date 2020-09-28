
// BLOC
//    import 'package:linkupadminolddb/src/Bloc/
//import 'dart:html';

import 'package:linkupadminolddb/src/BLoC/bloc.dart';

import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';

import 'package:firebase_storage/firebase_storage.dart';
//MODELS
//import 'package:linkupadminolddb/src/DataLayer/itemData.dart';
//    import 'package:linkupadminolddb/src/DataLayer/FoodItem.dart';
import 'package:linkupadminolddb/src/DataLayer/models/FoodItemWithDocID.dart';

//import 'package:linkupadminolddb/src/DataLayer/CategoryItemsLIst.dart';

//import 'package:zomatoblock/DataLayer/location.dart';

import 'package:logger/logger.dart';




import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class FoodGalleryAdminHomeBloc2 implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final FirebaseStorage storage =
  FirebaseStorage(storageBucket: 'gs://kebabbank-37224.appspot.com');

  bool  _isDisposedIngredients = false;


  // CONSTRUCTOR BIGINS HERE..
  FoodGalleryAdminHomeBloc2() {

    print('at FoodGalleryAdminHomeBloc2()');



  }

  // CONSTRUCTOR ENDS HERE..




  // 4
  @override
  void dispose() {


//    _isDisposed = true;

//    _allIngredientListController.close();
  }
}