//import 'package:cloud_firestore/cloud_firestore.dart';
//
class OldCategoryItem {

  String categoryName;
  int sequenceNo;
  String imageURL;
  String documentID;
  String fireStoreFieldName;
  bool isSelected; // for AdminIngredientUpload to firestore only....
  String displayNameinApp;
  String itemId;
  int index;

  OldCategoryItem(
      {
        this.categoryName, // this.displayNameinApp,
        this.sequenceNo,
        this.imageURL,
        this.documentID,
        this.fireStoreFieldName, // short category name.
        this.isSelected:false, // for AdminIngredientUpload to firestore only....
        // this.displayNameinApp,
        this.itemId,
        this.index,
      }
      );



//
  OldCategoryItem.fromMap(Map<String, dynamic> data,String docID)
      :imageURL= data['image'],
//       :imageURL= storageBucketURLPredicate + Uri.encodeComponent(data['image']),

//      :imageURL= storageBucketURLPredicate +  Uri.decodeComponent(data['image']),
        categoryName= data['name'],
        sequenceNo = data['sequenceNo'],
        documentID = docID,
        fireStoreFieldName = data['fireStoreFieldName'],
        // displayNameinApp = data['displayNameinApp'],
        itemId=data['itemId'];


        // cheeseItemAmountByUser = 0,
        //
        // isDeleted=false,
        // isSelected =false;



}
