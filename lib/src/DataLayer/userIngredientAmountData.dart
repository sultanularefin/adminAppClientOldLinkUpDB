//import 'package:cloud_firestore/cloud_firestore.dart';
//

//IngredientItem.dart


class UserIngredientAmountData {

  String ingredientName;

  DateTime uploadDate;
  String imageURL;

  String ingredientId;
  bool isAvailable;
  double indicatorValue; // image loading || asset loading indicator value.
  String uploadedBy;
  String documentId;
  String amount;

  UserIngredientAmountData(
      {
        this.ingredientName,
        this.uploadDate,
        this.imageURL,

        this.ingredientId,
        this.indicatorValue,
        this.isAvailable,
        this.uploadedBy,
        this.documentId,
        this.amount,
      }
      );

// FROM MAP NOT NECESSSARY. AS OF 30TH APRIL 2020.


  UserIngredientAmountData.fromMap(Map<dynamic, dynamic> data)
      : ingredientName = data['ingredientName'],
        uploadDate = data['uploadDate'].toDate(),
        uploadedBy = data['uploadedBy'],
        ingredientId = data['ingredientId'],
        isAvailable = data['isAvailable'],
        documentId = data['documentId'],
        imageURL= data['imageURL'];
}

