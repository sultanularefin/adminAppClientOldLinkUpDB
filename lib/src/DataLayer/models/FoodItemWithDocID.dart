//import 'package:cloud_firestore/cloud_firestore.dart';
//

import './FoodItemWithDocIDViewModel.dart';


class FoodItemWithDocID {

  String itemName;
  String categoryName;
  String shorCategoryName;
  int categoryIndex;// requred for dropdownlist select...

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
//  double discount;
  List<String> defaultJuusto;
  List<String> defaultKastike;
  int sequenceNo;
  String urlAndTokenForStorageImage;

  FoodItemWithDocID(
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
        this.isAvailable:true,
        this.isHot:true,
        this.uploadedBy,
        this.documentId,
//        this.discount,
        this.defaultJuusto,
        this.defaultKastike,
        this.sequenceNo,
        this.urlAndTokenForStorageImage:'',
        this.categoryIndex,

      }
      );


  FoodItemWithDocID.reverseCustomCast(FoodItemWithDocIDViewModel data /*,String size, double price*/)
      : itemName = data.itemName,
        categoryName = data.categoryName,
        shorCategoryName = data.shorCategoryName,
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
        documentId = data.documentId;
//        discount = data.discount;
//        itemSize = size,
//        itemPrice = price;
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