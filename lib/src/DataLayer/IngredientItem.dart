//import 'package:cloud_firestore/cloud_firestore.dart';
//

//IngredientItem.dart


class IngredientItem {

  String ingredientName;

  DateTime uploadDate;
  String imageURL;

  String ingredientId;
  bool isAvailable;
  double indicatorValue; // image loading || asset loading indicator value.
  String uploadedBy;
  String documentId;
  int ingredientAmountByUser;

  IngredientItem(
      {
        this.ingredientName,
        this.uploadDate,
        this.imageURL,

        this.ingredientId,
        this.indicatorValue,
        this.isAvailable,
        this.uploadedBy,
        this.documentId,
        this.ingredientAmountByUser,
      }
      );
// FROM MAP NOT NECESSSARY. AS OF 30TH APRIL 2020.
  // necessary new thinking, no model class and view class same [amount is for view defaults to 1].

  IngredientItem.fromMap(Map<dynamic, dynamic> data)
      : ingredientName = data['ingredientName'],
        uploadDate = data['uploadDate'].toDate(),
        uploadedBy = data['uploadedBy'],
        ingredientId = data['ingredientId'],
        isAvailable = data['isAvailable'],
        documentId = data['documentId'],
        imageURL= data['imageURL'],
        ingredientAmountByUser = 1;
}

