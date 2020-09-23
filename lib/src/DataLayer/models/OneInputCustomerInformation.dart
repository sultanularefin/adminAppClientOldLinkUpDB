
import 'dart:math';

import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


class OneInputCustomerInformation{

//  borderColor: '0xff739DFA',
//  index: 0,
//  isSelected: true,
//  orderType: 'TakeAway',
//  iconDataString: 'FontAwesomeIcons.facebook',
//  orderTyepImage:'assets/orderBYicons/takeaway.png'
//  returnValue:



  int     index;
  String  returnValue;
  bool    complete;
  String  inputName;
  List<String> inputOf;




  OneInputCustomerInformation(
      {

        this.index,
        this.returnValue,
        this.complete,
        this.inputName,
        this.inputOf,

        // this.foodItemOrderID,
      }
      );


}
