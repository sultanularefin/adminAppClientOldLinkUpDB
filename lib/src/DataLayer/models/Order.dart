//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


//import 'package:flutter/material.dart';

//import 'dart:core';
import 'dart:math';

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import 'packages:foodgallery/src/DataLayer/models/NewIngredient.dart';
//final String storageBucketURLPredicate_Same =
//    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';

class Order {



//  final String foodItemName;      // one of foodItems> collection.
//  final String foodItemImageURL;
//  final double unitPrice;
//  final String foodDocumentId;
//  final int    quantity;
//  final String foodItemSize;
//  // final String foodItemOrderID;     // random might not be needed.
//  List<NewIngredient> ingredients;

  List<SelectedFood> selectedFoodInOrder;
  int selectedFoodListLength;

  int orderTypeIndex;
  int paymentTypeIndex;
  CustomerInformation orderingCustomer;
  double totalPrice;
  bool    paymentButtonPressed;
  bool    recitePrinted;
  String  orderdocId;
  bool    isCanceled;
  int page; // page =(0,1) = (0: from FoodGallery Page, 1: from Shopping Cart Page);



  // SINCE WE DON'T NEED TO
  // CALCULATE THIS PRICE IN SHOPPING CART PAGE BUT DO IT IN FOOD GALLERY PAGE,
  //  AND PASS LATER PAGES.

//  String ingredients;
//  itemId = await generateItemId(6);

  Order(
      {
//        this.foodItemName,
//        this.foodItemImageURL,
//        this.unitPrice,
//        this.foodDocumentId,
//        this.quantity,
//        this.foodItemSize,
        this.selectedFoodInOrder,
        this.selectedFoodListLength,
        this.orderTypeIndex,
        this.paymentTypeIndex,
        this.orderingCustomer,
        this.totalPrice,
        this.paymentButtonPressed:false,
        this.recitePrinted:false,
        this.orderdocId:'',
        this.isCanceled:false,
        this.page,



        // this.foodItemOrderID,
      }
  );

//  WHAT ABOUT:

//  NewIngredient.fromMap(Map<String, dynamic> data)
//  NewIngredient.fromMap(Map<dynamic, dynamic> data)

//  OrderList.fromMap(Map<String, dynamic> data,String docID)
//      :imageURL= data['image'],
//        ingredientName= data['name'],
//        price = data['price'].toDouble(),
//        documentId = docID,
//        ingredientAmountByUser = 1;



  Future<String> generateItemId(int length)  async {
    String _result = "";
    int i = 0;
    String _allowedChars ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      //      print('randomInt: $randomInt');
      //Get random char and append it to the password

      //      print('_allowedChars[randomInt]: ${_allowedChars[randomInt]}');


      _result += _allowedChars[randomInt];

      //      print('_result: $_result');

      i++;
    }

    return _result;
  }

}
