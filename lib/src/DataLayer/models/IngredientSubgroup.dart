

//import 'package:cloud_firestore/cloud_firestore.dart';
//
class IngredientSubgroup {

  String ingredientSubgroupName;
  bool isSelected; // for AdminIngredientUpload to firestore only....


  IngredientSubgroup(
      {

        this.ingredientSubgroupName,
        this.isSelected:false, // for AdminIngredientUpload to firestore only....

      }
      );
}
