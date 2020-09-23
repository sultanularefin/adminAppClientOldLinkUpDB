//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


//import 'package:flutter/material.dart';

import 'dart:core';

//final String storageBucketURLPredicate_Same =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';


import 'package:foodgallery/src/utilities/screen_size_reducers.dart';

//import 'package:firebase_auth/firebase_auth.dart';

//final FirebaseAuth _auth;

//final FirebaseAuth _auth = FirebaseAuth.instance;
class NewIngredient {

  String ingredientName;
  String imageURL;
  double price;
  String documentId;
  int    ingredientAmountByUser;
  bool isDefault;
  List<dynamic> extraIngredientOf;
  int sequenceNo;
  String subgroup;
  int tempIndex; // for incrementing and decrementing view data field only
  bool isDeleted;
  String itemId;

//  String ingredients;

  NewIngredient(
      {
        this.ingredientName,
        this.imageURL,
        this.price,
        this.documentId,
        this.ingredientAmountByUser,
        this.isDefault:false,
        this.extraIngredientOf,
        this.sequenceNo,
        this.subgroup:'',
        this.tempIndex:0,
        this.isDeleted:false,
        this.itemId,
      }
      );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)

  /*
  // INVOCATION CODE FOODDETAILBLOC LINE # 324.
  ingItems = snapshot.documents.map((documentSnapshot) =>
  NewIngredient.fromMap
  */

  NewIngredient.ingredientConvert(Map<String, dynamic> data,String docID)
      // :imageURL= storageBucketURLPredicate + Uri.encodeComponent(data['image']),

      :imageURL=  data['image'],
  //     :imageURL=  storageBucketURLPredicate + Uri.encodeComponent(data['image'])
  // +'?alt=media',
//  &token='+
//      _auth.currentUser.getIdToken()
//      User fireBaseUserRemote = result.user;,
//      :imageURL= storageBucketURLPredicate +  Uri.decodeComponent(data['image']),
        ingredientName= data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        isDefault= false,
        isDeleted =false,
        tempIndex=0,
        ingredientAmountByUser = 1;

//        extraIngredientOf= data['extraIngredientOf'],
//        sequenceNo = data['sequenceNo'] ,
//        subgroup= data['subgroup'];


  NewIngredient.ingredientConvertExtra(Map<String, dynamic> data,String docID)
     :imageURL= data['image'],
//       :imageURL= storageBucketURLPredicate + Uri.encodeComponent(data['image']),
//        storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
//            +'?alt=media';
        ingredientName= data['name'],
        price = data['price'].toDouble(),
        documentId = docID,
        isDefault= false,
        isDeleted =false,
        ingredientAmountByUser = 1,
        extraIngredientOf= data['extraIngredientOf'],
        sequenceNo = data['sequenceNo'] ,
        subgroup= data['subGroup'];


  NewIngredient.updateUnselectedIngredient(NewIngredient oneIngredient)
       :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        extraIngredientOf= oneIngredient.extraIngredientOf,
        sequenceNo = oneIngredient.sequenceNo,
        subgroup= oneIngredient.subgroup,
        isDeleted = false,
        isDefault = false;

  // PURPOSE SETTING ISDEFAULT TRUE INORDER TO CALCULATE PRICE UPON NEW INGREDIENT ADD
  /*
  NewIngredient.updateSelectedIngredient(NewIngredient oneIngredient)
      :imageURL= oneIngredient.imageURL,
        ingredientName= oneIngredient.ingredientName,
        price = oneIngredient.price,
        documentId = oneIngredient.documentId,
        ingredientAmountByUser = 0,
        isDefault= true;

  */


//        ingredientAmountByUser = 1;

//  final DocumentSnapshot document = snapshot.data.documents[index];
//
//  document.documentID
}
