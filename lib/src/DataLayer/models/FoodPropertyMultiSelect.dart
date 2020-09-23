//FoodPropertyMultiSelect.dart
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
class FoodPropertyMultiSelect {

  String  itemName;
//  Color   itemTextColor;
  String     itemTextColor;
  int     index;
  String  borderColor;
  bool    isSelected;
  String  itemImage;
  String  itemFullName;


  FoodPropertyMultiSelect(
      {

        this.itemName,
        this.itemTextColor,
        this.index,
        this.borderColor,
        this.isSelected:false,
        this.itemImage,
        this.itemFullName,

      }
      );
}

// M 0xffB47C00 1 0xffB47C00 false
// VSM 0xffFEE295 2 0xffFEE295 false
// VS 0xffFEE295 3 0xffFEE295 false
// ORG 0xff739DFA 4 0xff739DFA false