//import 'package:cloud_firestore/cloud_firestore.dart';
//

//import 'package:foodgallery/src/models/IngredientItem.dart';

//CODE FORMAT ANDROID STUDIO CTRL +
//ALT + I
//IN WINDOWS


//import 'package:flutter/material.dart';

//import 'dart:core';
import 'dart:math';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';

class OrderedItem {
  String              name;
  String              category;
  List<SauceItem>     selectedSauces;
  double                 discount;
  String              foodItemImage;
  List<NewIngredient> selectedIngredients;
  int                 quantity;
  List<CheeseItem>    selectedCheeses;
  List<String> multiSelectString;

  double              oneFoodTypeTotalPrice;
  double              unitPrice;
  double              unitPriceWithoutCheeseIngredientSauces;
  String              foodItemSize;

  /*
  int selectedFoodListLength;

  int orderTypeIndex;
  int paymentTypeIndex;
  CustomerInformation ordersCustomer;
  double totalPrice;
  bool    paymentButtonPressed;
  String  orderdocId;
  bool    isCanceled;
  int page; // page =(0,1) = (0: from FoodGallery Page, 1: from Shopping Cart Page);

*/
  // SINCE WE DON'T NEED TO
  // CALCULATE THIS PRICE IN SHOPPING CART PAGE BUT DO IT IN FOOD GALLERY PAGE,
  //  AND PASS LATER PAGES.

//  String ingredients;
//  itemId = await generateItemId(6);

  OrderedItem(
      {
        this.category,
        this.selectedSauces,
        this.discount,
        this.foodItemImage,
        this.selectedIngredients,
        this.quantity,
        this.selectedCheeses,
        this.name,
        this.oneFoodTypeTotalPrice,
        this.unitPrice,
        this.unitPriceWithoutCheeseIngredientSauces,
        this.foodItemSize,
        this.multiSelectString,


        // this.foodItemOrderID,
      }
      );

//  'name':sf[counter].foodItemName,
//  'oneFoodTypeTotalPrice': sf[counter].quantity * sf[counter].unitPrice,
//  'unitPrice':sf[counter].unitPrice,


/*
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
*/
}
