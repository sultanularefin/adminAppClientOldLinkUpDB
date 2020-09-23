//FoodPropertyMultiSelect.dart
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
class PaymentTypeSingleSelect {

  String  paymentTypeName;
//  Color   itemTextColor;
  String  paymentIconName;
  int     index;
  String  borderColor;
  String  iconColor;
  bool    isSelected;
  String iconDataString;


  PaymentTypeSingleSelect(
      {

        this.paymentTypeName,
        this.paymentIconName,
        this.index,
        this.borderColor,
        this.isSelected,
        this.iconColor,
        this.iconDataString,

      }
      );
}

// M 0xffB47C00 1 0xffB47C00 false
// VSM 0xffFEE295 2 0xffFEE295 false
// VS 0xffFEE295 3 0xffFEE295 false
// ORG 0xff739DFA 4 0xff739DFA false