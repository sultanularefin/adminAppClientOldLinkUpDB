//FoodPropertyMultiSelect.dart
//import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
import 'package:flutter/material.dart';

class CustomerInformation {
  String address;
  String flatOrHouseNumber;
  String phoneNumber;
  int etaTimeInMinutes;
  TimeOfDay etaTimeOfDay;

  CustomerInformation({
    this.address,
    this.flatOrHouseNumber,
    this.phoneNumber,
    this.etaTimeInMinutes,
    this.etaTimeOfDay,
  });
}

