//import 'package:cloud_firestore/cloud_firestore.dart';
//
class NewCategoryItem {

  String categoryName;
  int sequenceNo;
  String documentID;
  String fireStoreFieldName;
  bool isSelected; // for AdminIngredientUpload to firestore only....


  NewCategoryItem(
      {

        this.categoryName,
        this.sequenceNo,
        this.documentID,
        this.fireStoreFieldName,
        this.isSelected:false, // for AdminIngredientUpload to firestore only....

      }
      );
}
