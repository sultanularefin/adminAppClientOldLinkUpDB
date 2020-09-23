//import 'package:cloud_firestore/cloud_firestore.dart';
//

import 'FoodItemWithDocID.dart';

class FoodItemWithDocIDViewModel {

  String itemName;
  String categoryName;
  String shorCategoryName;

  Map<String,dynamic> sizedFoodPrices;
  List<dynamic> ingredients;
//  String priceinEuro;

//  Timestamp uploadDate;
  DateTime uploadDate;
  String imageURL;

  String content;
  String itemId;
  double indicatorValue;
  bool isAvailable;
  bool isHot;
  String uploadedBy;
  String documentId;
  String itemSize;        // initially Normal;
  double itemPriceBasedOnSize;       // double price of Normal initially.
//  double discount;
  double priceBasedOnCheeseSauceIngredientsSize;

  FoodItemWithDocIDViewModel(
      {
        this.itemName,
        this.categoryName,
        this.shorCategoryName,
        this.sizedFoodPrices,
        this.uploadDate,
        this.imageURL,
        this.content,
        this.ingredients,
        this.itemId,
        this.indicatorValue,
        this.isAvailable,
        this.isHot,
        this.uploadedBy,
        this.documentId,
//        this.discount,
        this.itemSize,
        this.itemPriceBasedOnSize,
        this.priceBasedOnCheeseSauceIngredientsSize,
      }
      );


  FoodItemWithDocIDViewModel.customCastFrom(FoodItemWithDocID data,String size, double price)
      : itemName = data.itemName,
        categoryName = data.categoryName,
        shorCategoryName= data.shorCategoryName,
        sizedFoodPrices = data.sizedFoodPrices,
        uploadDate = data.uploadDate,
        imageURL = data.imageURL,
        content = data.content,
        ingredients = data.ingredients,
        itemId = data.itemId,
        indicatorValue = data.indicatorValue,
        isAvailable = data.isAvailable,
        isHot = data.isHot,
        uploadedBy = data.uploadedBy,
        documentId = data.documentId,
//        discount = data.discount,
        itemSize = size,
        itemPriceBasedOnSize = price,
        priceBasedOnCheeseSauceIngredientsSize = price;








//  NewIngredient.fromMap(Map<String, dynamic> data,String docID)
//      :imageURL= data['image'],
//        ingredientName= data['name'],
//        price = data['price'].toDouble(),
//        documentId = docID,
//        ingredientAmountByUser = 1;

}




//class Dummy {
//  int id;
//  String title;
//  int price;
//  int counter;
//  String url;
//  String amountPerUnit;
//  String content;
//  String level;
//  double indicatorValue;
//
//  Dummy(
//      {this.id, this.title, this.price, this.counter, this.url, this.content, this.amountPerUnit, this.level, this.indicatorValue, });
//}