
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';

class OneOrderFirebase {

  CustomerInformation       oneCustomer;
  List<OrderedItem>         orderedItems;
  String                    orderBy;
  String                    paidStatus;
  String                    paidType;
//  int                       paidIndex;
  double                    totalPrice;
  String                    contact;
  String                    driverName;
  DateTime                  endDate;
  DateTime                  startDate;
  String                    formattedOrderPlacementDate;
  String                    formattedOrderPlacementDatesTimeOnly;
  String                    orderStatus;
  String                    tableNo;
  String                    orderType;
  String                    documentId;
  double                    deliveryCost;
  double                    tax; // 14% upon total Cost.
  double                    priceWithDelivery;
  int                       orderProductionTimeFromNow;
  // String                    orderProductionTimeOfDay;
  String                    timeOfDay;
  int                       tempPaymentIndex; // for unpaid Order....
  bool                      updateSuccess;
  // bool                      tempPayButtonPressed;
  String                    tempPaidType;
  String                    restaurantName;

  OneOrderFirebase(
      {
        this.oneCustomer,
        this.orderedItems,
        this.orderBy,
        this.paidStatus,
        this.paidType,
//        this.paidIndex,
        this.totalPrice,
        this.contact,
        this.driverName,
        this.endDate,
        this.startDate,
        this.formattedOrderPlacementDate,
        this.formattedOrderPlacementDatesTimeOnly,
        this.orderStatus,
        this.tableNo,
        this.orderType,
        this.documentId,
        this.deliveryCost,
        this.tax, // 14% upon total Cost.
        this.priceWithDelivery,
        this.orderProductionTimeFromNow, //  int minutes3 =minutes2.ceil(); // no need to have double
        this.timeOfDay,
        this.tempPaymentIndex,
        this.updateSuccess:false,
        // this.tempPayButtonPressed:false,
        this.restaurantName,
      }
      );



}
