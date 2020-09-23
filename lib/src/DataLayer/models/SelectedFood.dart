
import 'dart:math';

import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


class SelectedFood {

  final String  foodItemName;      // one of foodItems> collection.
  final String  foodItemImageURL;
  double  unitPrice;
  double  unitPriceWithoutCheeseIngredientSauces;
  final String  foodDocumentId;
  int           quantity;
  final String  foodItemSize;
  final String  categoryName;
  final double     discount;
  // final String foodItemOrderID;     // random might not be needed.
  List<NewIngredient> selectedIngredients;
  List<CheeseItem>  selectedCheeseItems;
  List<SauceItem>   selectedSauceItems;
  double subTotalPrice;
  List<FoodPropertyMultiSelect> multiSelct = new List<FoodPropertyMultiSelect>(4);

//  String ingredients;
//  itemId = await generateItemId(6);

  SelectedFood(
      {
        this.foodItemName,
        this.foodItemImageURL,
        this.unitPrice,
        this.unitPriceWithoutCheeseIngredientSauces,
        this.foodDocumentId,
        this.quantity,
        this.foodItemSize,
        this.selectedIngredients,
        this.categoryName,
        this.discount,
        this.selectedCheeseItems,
        this.selectedSauceItems,
        this.subTotalPrice,
        this.multiSelct,

        // this.foodItemOrderID,
      }
      );

  Future<String> generateItemId(int length)  async {
    String _result = "";
    int i = 0;
    String _allowedChars ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);

      _result += _allowedChars[randomInt];

      i++;
    }

    return _result;
  }

}
