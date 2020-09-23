

//### EXTERNAL PACKAGES
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'; // to be removed later.
import 'package:flutter/material.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/NewCategoryItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OneInputCustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/Restaurant.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';


import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';


// this pkg i am using for searching device's only and for testing now on august 29....
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as primaryBlueToothPrinter;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:logger/logger.dart';
//import 'package:wifi/wifi.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';



//printing blue tooth or wifi in same local area network.

//import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';


//### LOCAL DATA RELATED RESOURCES
import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';




//MODELS


class ShoppingCartBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();



//  PRINTING RELATED objects put here Beginning {.


  final FirebaseAuth _auth = FirebaseAuth.instance; // TO BE REMOVE LATER.

//  PRINTING RELATED objects put here } ends .
//  List<Order> _curretnOrder = [];

  Order _curretnOrder ;
  List<OrderTypeSingleSelect>   _orderType;
  List<PaymentTypeSingleSelect> _paymentType;
  List<SelectedFood> _expandedSelectedFood =[];

//  List<SelectedFood> _savedSelectedFood    =[];







//  CustomerInformation _oneCustomerInfo;


//  List<Order> get getCurrentOrder => _curretnOrder;
  Order get getCurrentOrder => _curretnOrder;
  List<OrderTypeSingleSelect> get getCurrentOrderType => _orderType;
  List<PaymentTypeSingleSelect> get getCurrentPaymentType => _paymentType;
  List<SelectedFood> get getExpandedSelectedFood => _expandedSelectedFood;

//  List<SelectedFood> get getSavedSelectedFood => _savedSelectedFood;

//  CustomerInformation get getCurrentCustomerInfo => _oneCustomerInfo;



  final _orderController = StreamController <Order>();

  final _expandedSelectedFoodController =  StreamController<List<SelectedFood>>/*.broadcast*/();

//  final _savedSelectedFoodController =  StreamController<List<SelectedFood>>();

  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
  final _paymentTypeController = StreamController <List<PaymentTypeSingleSelect>>.broadcast();

//  final _orderTypeController = StreamController <List<OrderTypeSingleSelect>>.broadcast();
//  final _customerInformationController = StreamController <CustomerInformation>();
//  final _customerInformationController = StreamController <CustomerInformation>.broadcast();


  Stream<Order> get getCurrentOrderStream => _orderController.stream;

  Stream  <List<SelectedFood>> get getExpandedFoodsStream => _expandedSelectedFoodController.stream;

  Stream  <List<OrderTypeSingleSelect>> get getCurrentOrderTypeSingleSelectStream =>
      _orderTypeController.stream;

  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream =>
      _paymentTypeController.stream;

//  Stream  <List<SelectedFood>> get getSavedFoodsStream => _savedSelectedFoodController.stream;


  PrinterBluetoothManager printerManager = PrinterBluetoothManager();


  List<NewCategoryItem> _allCategories =[];
  List<NewCategoryItem> get getAllCategories => _allCategories;
  final _categoriesController = StreamController<List<NewCategoryItem>>();
  Stream <List<NewCategoryItem>> get getCategoryItemsStream => _categoriesController.stream;



  /*
  Stream<CustomerInformation> get getCurrentCustomerInformationStream =>
      _customerInformationController.stream;
  */


  List<OneInputCustomerInformation> _allCustomerInput=[];
  List<OneInputCustomerInformation> get getAllUserInputs => _allCustomerInput;
  final _customerInputController = StreamController<List<OneInputCustomerInformation>>.broadcast();
  Stream <List<OneInputCustomerInformation>> get getCustomerInputsStream => _customerInputController.stream;



  Restaurant _thisRestaurant ;
  Restaurant get getCurrentRestaurant => _thisRestaurant;
  final _restaurantController = StreamController <Restaurant>();
  Stream<Restaurant> get getCurrentRestaurantsStream => _restaurantController.stream;

// BLUETOOTH PRINTER DEVICES..

  List<PrinterBluetooth> _devicesBlueTooth = [];
  //  List<String> _devices =[];
  List<PrinterBluetooth> get getDevices => _devicesBlueTooth;
  final _devicesController = StreamController<List<PrinterBluetooth>>();
  Stream <List<PrinterBluetooth>> get getDevicesStream => _devicesController.stream;




/*
  List<BluetoothDevice> _devicesBlueTooth = [];
  //  List<String> _devices =[];
  List<BluetoothDevice> get getDevices => _devicesBlueTooth;
  final _devicesController = StreamController<List<BluetoothDevice>>();
  Stream <List<BluetoothDevice>> get getDevicesStream => _devicesController.stream;

*/

  //  List<PrinterBluetooth> blueToothDevicesState = [];


  List<String> dynamicListFilteredToStringList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);

    logger.i('stringList.length: ${stringList.length}');


    return stringList;


  }

  Future<void> getRestaurantInformationConstructor() async{
    print('..........getRestaurantInformationConstructor()');
    var snapshot = await _client.fetchRestaurantDataClient();




    Map getDocs = snapshot.data();

    Map     <String,dynamic> restaurantAddress = getDocs['address'];
    Map     <String,dynamic> restaurantAttribute = getDocs['attribute'];
    List    <dynamic> restaurantCousine = getDocs['cousine'];
    bool    restaurantKidFriendly =  getDocs['kid_friendly'];
    bool    restaurantReservation = getDocs['reservation'];
    bool    restaurantRomantic  = getDocs['romantic'];
    List    <dynamic> restaurantOffday2 = getDocs['offday'];

    List<String> restaurantOffday = dynamicListFilteredToStringList(restaurantOffday2);



    String  restaurantOpen = getDocs['open'];



    String  restaurantAvatar =getDocs['avatar']==''?
    'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        :''
        + storageBucketURLPredicate +
        Uri.encodeComponent(getDocs['avatar'])
        +'?alt=media';
    // 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/'

    print('restaurantAvatar: $restaurantAvatar');


    String  restaurantContact= getDocs['contact'];

    int  restaurantDeliveryCharge1 = getDocs['deliveryCharge'];

    double restaurantDeliveryCharge = restaurantDeliveryCharge1.toDouble();
    int restaurantDiscount0 =getDocs['discount'];// from string;// need to convert string to double.
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is num);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is int);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is double);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is String);

    final double restaurantDiscount = restaurantDiscount0.toDouble();
//    final double foodItemDiscount = doc['discount'];
    String  restaurantName = getDocs['name'];

    print('restaurantName: $restaurantName');

    print('restaurantKidFriendly : $restaurantKidFriendly');


    double  restaurantRating = getDocs['rating'];
    double  restaurantTotalRating = getDocs['totalRating'];


    Restaurant onlyRestaurant = new Restaurant(
      address:restaurantAddress,
      attribute: restaurantAttribute,
      cousine: restaurantCousine,
      kidFriendly:restaurantKidFriendly, // kid_friendly
      reservation:restaurantReservation,
      romantic:restaurantRomantic,
      offday:restaurantOffday,
      open: restaurantOpen,
      avatar: restaurantAvatar,
      contact: restaurantContact,
      deliveryCharge: restaurantDeliveryCharge,
      discount: restaurantDiscount,// from string;// need to convert string to double.
      name: restaurantName,
      rating: restaurantRating,
      totalRating :restaurantTotalRating,
    );

    _thisRestaurant= onlyRestaurant;
    _restaurantController.sink.add(_thisRestaurant);

//    _foodItemController.sink.add(_allFoodsList);

  }

  // CONSTRUCTOR BEGINS HERE.


  ShoppingCartBloc(
      /*FoodItemWithDocID oneFoodItem, List<NewIngredient> allIngsScoped */
      Order x,List<NewCategoryItem> allCategories
      ) {
//    discoverDevicesConstructor();
    discoverDevicesConstructorNewPKG();


    print("at the begin of Constructor [ShoppingCartBloc]");

//    print('food Item name in Shopping Cart BlocK ${x.foodItemName}');

    print('x.paymentTypeIndex: ${x.paymentTypeIndex}');
    int paymentTypeIndex = x.paymentTypeIndex;

    initiateOrderTypeSingleSelectOptions();

    //initiate scanner.
    // printerManager.startScan(Duration(seconds: 4));
//    printerManager.startScan(Duration(seconds: 4));

    getRestaurantInformationConstructor();

    initiatePaymentTypeSingleSelectOptions(paymentTypeIndex);


    List<SelectedFood> allOrderedFoods = x.selectedFoodInOrder;


//    _savedSelectedFood = allOrderedFoods;
//    _savedSelectedFoodController.sink.add(_savedSelectedFood);


    List<SelectedFood> selectedFoodforDisplay = new List<SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


    allOrderedFoods.forEach((oneFood) {
      print('oneFood details: ===> ===> ');
      print('oneFood: ${oneFood.foodItemName}');
      logger.e('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
      List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

      print('MOMENT OF TRUTH: ');
      print(':::: ::: :: $test');
      selectedFoodforDisplay.addAll(test);
    });


//      selectedFoodforDisplay.addAll(test);

//      logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
    print('item count : ${selectedFoodforDisplay.length}');

    print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');

    _expandedSelectedFood = selectedFoodforDisplay;
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);



    //    initiateCustomerInformation();

    _curretnOrder = x;
    _orderController.sink.add(x);
//    }


    // put categoryitems here..

    _allCategories=allCategories;
    _categoriesController.sink.add(_allCategories);

  }
// CONSTRUCTOR ENDS HERE.



  List<SelectedFood> makeMoreFoodByQuantity(SelectedFood X){

    int fillingLength = X.quantity;
    print('X X is $X');
    print('X.quantity is: ${X.quantity}');

    SelectedFood oneSelectedFood = X;
    oneSelectedFood.quantity = 1;
    print('oneSelectedFood.quantity is: ${oneSelectedFood.quantity}');
    print('oneSelectedFood.foodItemName is: ${oneSelectedFood.foodItemName}');
    logger.i('oneSelectedFood.unitPrice is: ${oneSelectedFood.unitPrice}');
    logger.i('oneSelectedFood.subTotalPrice is:${oneSelectedFood.subTotalPrice}');

    List<SelectedFood> multiplied = List.filled(fillingLength, oneSelectedFood);

    print('\n \n AFTER ... FILLING');
    print('X.quantity is: $fillingLength');
    print('oneSelectedFood.quantity is: ${oneSelectedFood.quantity}');

    print('multiplied: $multiplied');

//    List<SelectedFood> multiplied2 = new List<SelectedFood>(X.quantity);
//    List.filled(int length, E fill, {bool growable = false});

    return multiplied;
  }


  void initiatePaymentTypeSingleSelectOptions(int selectedPayment){
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );

    PaymentTypeSingleSelect Cash = new PaymentTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 1,
      isSelected: false,
      paymentTypeName: 'Cash',
      iconDataString: 'FontAwesomeIcons.twitter',

      paymentIconName: 'Cash',
    );


//     0xffFEE295 false
    PaymentTypeSingleSelect Card = new PaymentTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      paymentTypeName: 'Card',
      iconDataString: 'FontAwesomeIcons.home',

      paymentIconName: 'Card',
    );

    List <PaymentTypeSingleSelect> paymentTypeSingleSelectArray = new List<PaymentTypeSingleSelect>();


    paymentTypeSingleSelectArray.addAll([Later, Cash, Card  ]);

    paymentTypeSingleSelectArray[selectedPayment].isSelected =true;

    _paymentType = paymentTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _paymentTypeController.sink.add(_paymentType);
  }

  void setPaymentTypeSingleSelectOptionForOrder(PaymentTypeSingleSelect x, int newPaymentIndex,int oldPaymentIndex){

    print('new Payment Index is $newPaymentIndex');
    print('old Payment Index is $oldPaymentIndex');


    List <PaymentTypeSingleSelect> singleSelectArray = _paymentType;

    singleSelectArray[oldPaymentIndex].isSelected =
    !singleSelectArray[oldPaymentIndex].isSelected;


    singleSelectArray [newPaymentIndex].isSelected =
    !singleSelectArray[newPaymentIndex].isSelected;

    Order currentOrderTemp = _curretnOrder;

    currentOrderTemp.paymentTypeIndex = newPaymentIndex;


    _paymentType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _curretnOrder = currentOrderTemp;

    _paymentTypeController.sink.add(_paymentType);
    _orderController.sink.add(_curretnOrder);
  }


  //PAYMENT FIRESTORE =>



//  Future<OneOrderFirebase> fetchOrderDataFromFirebase(String orderDocumentId) async {
  Future<String> recitePrinted(String orderDocumentID,String status) async{

    String documentID = orderDocumentID;


    var updateResult =
    await _client.updateOrderCollectionDocumentWithRecitePrintedInformation(documentID,status);
    Map getDocs = updateResult.data();

//    sss

    print('updateResult is:: :: $updateResult');



    String                    recitePrintedString = getDocs['recitePrinted'];

    print('recitePrintedString: $recitePrintedString');

    return recitePrintedString;

  }


  int checkRating(String oneCategoryString, String secondCategoryString, List<NewCategoryItem> allCats){

    NewCategoryItem firstCategory = allCats.where((element) => element.categoryName == oneCategoryString).first;
    NewCategoryItem secondCategory = allCats.where((element) => element.categoryName == secondCategoryString).first;

//    numbers.sort((a, b) => a.length.compareTo(b.length));
    return firstCategory.sequenceNo.compareTo(secondCategory.sequenceNo);

//    return firstCategory.rating > secondCategory.rating;

  }


  Future<Order> paymentButtonPressed(Order payMentProcessing) async{

    String orderBy =    _orderType[payMentProcessing.orderTypeIndex].orderType;


    String paidType0 =  _paymentType[payMentProcessing.paymentTypeIndex].paymentTypeName;

    // where should i put cancelButtonPressed();
//
    // payMentProcessing
    Order tempOrder= payMentProcessing;

    tempOrder.paymentButtonPressed=true;


    // loader/ spinner loads from this 2 lines not tested yet.... july 25 2020.


    _curretnOrder=tempOrder;
    _orderController.sink.add(_curretnOrder);

    // loader/ spinner loads from this 2 lines not tested yet.... july 25 2020. ends here.


//    _curretnOrder= tempOrder;

//    List<SelectedFood> selectedFoodCheckForList = tempOrder.selectedFoodInOrder;

    List<SelectedFood> selectedFoodCheckForList = _expandedSelectedFood;
    int length =tempOrder.selectedFoodListLength;


//    logger.e('tempOrder.selectedFoodListLength ${tempOrder.selectedFoodListLength}');
//
//    logger.e('selectedFoodCheckForList: $selectedFoodCheckForList');

//    print('selectedFoodCheckForList[3].quantity => ${selectedFoodCheckForList[3].quantity}');

    Set<SelectedFood> selectedFoodCheckForListToSet= selectedFoodCheckForList.toSet();

    int lengthOfNotDuplicateFoods= selectedFoodCheckForListToSet.length;

//    unDuplicatedSelectedFoods
//

    selectedFoodCheckForListToSet.forEach((oneFood) {


      for(int i=0;i<selectedFoodCheckForList.length;i++){
        if(oneFood==selectedFoodCheckForList[i]){
          oneFood.quantity= oneFood.quantity +1;
        }
      }

//      print('oneFood details: ===> ===> ');
//      print('oneFood: ${oneFood.foodItemName}');
//      logger.i('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');



    });

    selectedFoodCheckForListToSet.forEach((oneFood) {

      oneFood.quantity= oneFood.quantity-1; //initially 1 that was incremented in the previous forEach loop.
      print('oneFood.quantity SS: ${oneFood.quantity}');

    });



//    print('${selectedFoodCheckForListToSet.}')


    tempOrder.selectedFoodInOrder = selectedFoodCheckForListToSet.toList();


    List<SelectedFood> tempForCategorising=  tempOrder.selectedFoodInOrder;

    // todo sorting by categories ....

    // group by category will be done here...

//    List<NewCategoryItem> tempCategoryForCategorisingOrderedFoods = _allCategories;

    tempForCategorising.sort((a,b)=>checkRating(a.categoryName,b.categoryName,
        _allCategories));

    List<SelectedFood> tempForCategorising2 =  new List.from(tempForCategorising.reversed);
    /* List<String> numbers2 */





//    categoryName
//    _allCategories


    tempOrder.selectedFoodInOrder = tempForCategorising2;


    String restaurantName = _thisRestaurant.name;


    String documentID = await _client.insertOrder(tempOrder,orderBy,paidType0,restaurantName);


    print('documentID: $documentID');

    if(documentID!=null){
      tempOrder.orderdocId= documentID;

      _curretnOrder=null;
      _expandedSelectedFood =[];
      _orderType =[];
      _paymentType =[];


      // required to properly show data in the receipt thus don't clear _currentOrder object.
      _curretnOrder=tempOrder;
      _orderController.sink.add(_curretnOrder);


      return tempOrder;

    }
    else{
      return tempOrder;
    }



  }


  Future<Order> paymentButtonPressedLater() async{

    Order payMentProcessing=_curretnOrder;

    String orderBy =    _orderType[payMentProcessing.orderTypeIndex].orderType;
//    logger.i('payment Button Pressed is payMentProcessing.orderTypeIndex ${payMentProcessing.orderTypeIndex} ::'
//        ' orderBy: $orderBy    ${_curretnOrder.paymentTypeIndex}');




    String paidType0 =  _paymentType[payMentProcessing.paymentTypeIndex].paymentTypeName;

    // where should i put cancelButtonPressed();
//
    // payMentProcessing
    Order tempOrder= payMentProcessing;

    tempOrder.paymentButtonPressed=true;


    // loader/ spinner loads from this 2 lines not tested yet.... july 25 2020.


    _curretnOrder=tempOrder;
    _orderController.sink.add(_curretnOrder);

    // loader/ spinner loads from this 2 lines not tested yet.... july 25 2020. ends here.


//    _curretnOrder= tempOrder;

//    List<SelectedFood> selectedFoodCheckForList = tempOrder.selectedFoodInOrder;

    List<SelectedFood> selectedFoodCheckForList = _expandedSelectedFood;
    int length =tempOrder.selectedFoodListLength;


//    logger.e('tempOrder.selectedFoodListLength ${tempOrder.selectedFoodListLength}');
//
//    logger.e('selectedFoodCheckForList: $selectedFoodCheckForList');

//    print('selectedFoodCheckForList[3].quantity => ${selectedFoodCheckForList[3].quantity}');

    Set<SelectedFood> selectedFoodCheckForListToSet= selectedFoodCheckForList.toSet();

    int lengthOfNotDuplicateFoods= selectedFoodCheckForListToSet.length;

//    unDuplicatedSelectedFoods
//

    selectedFoodCheckForListToSet.forEach((oneFood) {


      for(int i=0;i<selectedFoodCheckForList.length;i++){
        if(oneFood==selectedFoodCheckForList[i]){
          oneFood.quantity= oneFood.quantity +1;
        }
      }

//      print('oneFood details: ===> ===> ');
//      print('oneFood: ${oneFood.foodItemName}');
//      logger.i('oneFood.quantity: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');



    });

    selectedFoodCheckForListToSet.forEach((oneFood) {

      oneFood.quantity= oneFood.quantity-1; //initially 1 that was incremented in the previous forEach loop.
      print('oneFood.quantity SS: ${oneFood.quantity}');

    });



//    print('${selectedFoodCheckForListToSet.}')


    tempOrder.selectedFoodInOrder = selectedFoodCheckForListToSet.toList();


    List<SelectedFood> tempForCategorising=  tempOrder.selectedFoodInOrder;

    // todo sorting by categories ....

    // group by category will be done here...

//    List<NewCategoryItem> tempCategoryForCategorisingOrderedFoods = _allCategories;

    tempForCategorising.sort((a,b)=>checkRating(a.categoryName,b.categoryName,
        _allCategories));

    List<SelectedFood> tempForCategorising2 =  new List.from(tempForCategorising.reversed);
    /* List<String> numbers2 */





//    categoryName
//    _allCategories


    tempOrder.selectedFoodInOrder = tempForCategorising2;






    String restaurantName = _thisRestaurant.name;


    String documentID = await _client.insertOrder(tempOrder,orderBy,paidType0,restaurantName);

    // String documentID = await _client.insertOrder(tempOrder,orderBy,paidType0);


    print('documentID: $documentID');

    if(documentID!=null){
      tempOrder.orderdocId= documentID;

      _curretnOrder=null;
      _expandedSelectedFood =[];
      _orderType =[];
      _paymentType =[];


      // required to properly show data in the receipt thus don't clear _currentOrder object.
      _curretnOrder=tempOrder;
      _orderController.sink.add(_curretnOrder);


      return tempOrder;

    }
    else{
      return tempOrder;
    }
  }


  List<NewIngredient> convertFireStoreIngredientItemsToLocalNewIngredientItemsList(List<dynamic>
  fireStoreNewIngredients){

    print('at convertFireStoreIngredientItemsToLocalNewIngredientItemsList');

    // List<Map<String, dynamic>>

//    print('--   ::      :: at here: convertFireStoreSauceItemsToLocalSauceItemsList -------- : : ');

    List<NewIngredient> allIngredientItems = new List<NewIngredient>();

    int ingredientCount =0;
    fireStoreNewIngredients.forEach((oneFireStoreSauce) {

      var oneNewIngredient = oneFireStoreSauce;


      NewIngredient oneTempNewIngredient = new NewIngredient(
        ingredientName: oneFireStoreSauce['name'] ,
        imageURL: oneFireStoreSauce['image'] ,
        ingredientAmountByUser: oneFireStoreSauce['ingredientAmountByUser'] ,
        isDefault:oneFireStoreSauce['isDefault'],
        price:oneFireStoreSauce['ingredientPrice'],
        isDeleted:  oneFireStoreSauce['isDeleted'],
//          isDefault: oneFireStoreSauce['isDefault'],

      );

      print('--   ::      :: at here: convertFireStoreIngredientItemsToLocalNewIngredientItemsList -------- : :'
          ' for ingredient: ${oneTempNewIngredient.ingredientName} ');

      print('name: ${oneTempNewIngredient.ingredientName} '
          'imageURL: ${oneTempNewIngredient.imageURL} price: ${oneTempNewIngredient.price},'
          ' ingredientAmountByUser: ${oneTempNewIngredient.ingredientAmountByUser}... isDefault: ${oneTempNewIngredient.isDefault}');


      allIngredientItems.add(oneTempNewIngredient);

      ingredientCount = ingredientCount +1;

    });

    logger.i('total Ingredient count: $ingredientCount');

    return allIngredientItems;
//    return sf.length
  }

//  convertFireStoreCheeseItemsToLocalCheeseItemsList(oneFoodItem['selectedCheeses']),

  List<CheeseItem> convertFireStoreCheeseItemsToLocalCheeseItemsList(List<dynamic> fireStoreCheeseItems){


    // List<Map<String, dynamic>>

    print('--   ::      :: at here: convertFireStoreCheeseItemsToLocalCheeseItemsList -------- : : ');

    List<CheeseItem> allCheeseItems = new List<CheeseItem>();

    int cheeseItemCount= 0;
    fireStoreCheeseItems.forEach((oneFireStoreCheese) {

      var oneCheeseItem = oneFireStoreCheese;


      CheeseItem oneTempCheeseItem = new CheeseItem(
        cheeseItemName: oneCheeseItem['name'] ,
        imageURL: oneCheeseItem['image'] ,
        cheeseItemAmountByUser: oneCheeseItem['cheeseItemAmountByUser'] ,
        price: oneCheeseItem['cheeseItemPrice'] ,
        isDefaultSelected:  oneCheeseItem['isDefaultSelected'],
        isDeleted: oneCheeseItem['isDeleted'],

      );

      print('--   ::      :: at here: convertFireStoreCheeseItemsToLocalCheeseItemsList -------- : :'
          ' for cheeseItem: ${oneTempCheeseItem.cheeseItemName} ');

      print('CheeseItem_name: ${oneTempCheeseItem.cheeseItemName} '
          'imageURL: ${oneTempCheeseItem.imageURL} price: ${oneTempCheeseItem.price},'
          ' cheeseItemAmountByUser: ${oneTempCheeseItem.cheeseItemAmountByUser} isDefaultSelected: '
          '${oneTempCheeseItem.isDefaultSelected}');


      allCheeseItems.add(oneTempCheeseItem);

      cheeseItemCount = cheeseItemCount +1;

    });

    logger.i('cheeseItemCount: $cheeseItemCount');
    return allCheeseItems;
//    return sf.length
  }

  List<SauceItem> convertFireStoreSauceItemsToLocalSauceItemsList(List<dynamic> fireStoreSauces){
    // List<Map<String, dynamic>>

    print('at convertFireStoreSauceItemsToLocalSauceItemsList');

    List<SauceItem> allSauceItems = new List<SauceItem>();

    int sauceCount= 0;
    fireStoreSauces.forEach((oneFireStoreSauce) {

      var oneSauceItem = oneFireStoreSauce;


      SauceItem oneTempSauceItem = new SauceItem(
        sauceItemName: oneSauceItem['name'] ,
        imageURL: oneSauceItem['image'] ,
        sauceItemAmountByUser: oneSauceItem['sauceItemAmountByUser'] ,
        price: oneSauceItem['sauceItemPrice'],
        isDefaultSelected: oneSauceItem['isDefaultSelected'],
        isDeleted: oneSauceItem['isDeleted'],

      );

      print('--   ::      :: at here: convertFireStoreSauceItemsToLocalSauceItemsList -------- : : for sauce: ${oneSauceItem['name']} ');

      print('sauceItemName: ${oneTempSauceItem.sauceItemName} '
          'imageURL: ${oneTempSauceItem.imageURL} price: ${oneTempSauceItem.price},'
          ' sauceItemAmountByUser: ${oneTempSauceItem.sauceItemAmountByUser} VV isDefaultSelected: '
          '${oneTempSauceItem.isDefaultSelected}');


      allSauceItems.add(oneTempSauceItem);

      sauceCount= sauceCount+ 1;
    });

    logger.i('sauceCount: $sauceCount');

    return allSauceItems;
//    return sf.length

  }

  CustomerInformation localCustomerInformationObject(Map<String,dynamic> customerAddress){
// List<Map<String, dynamic>>

    CustomerInformation oneCustomer = new CustomerInformation(
      address: customerAddress['state'],
      flatOrHouseNumber: customerAddress['apartNo'],
      phoneNumber:customerAddress['phone'],
//      etaTimeInMinutes: , ETA IS orderProductionTime
    );



    return oneCustomer;

  }

  String sanitizeTimeOfDay(String nameInput) {
    // String nameInput2 = nameInput.replaceAll(new RegExp(r'e'), 'é');

    String nameInput2 = nameInput.replaceAll(new RegExp(r'TimeOfDay'), '');

    String nameInput3 = nameInput2.replaceAll(new RegExp(r'\)'), '');

    String nameInput4 = nameInput3.replaceAll(new RegExp(r'\('), '');

    return nameInput4;
  }


  Future<OneOrderFirebase> fetchOrderDataFromFirebase(String orderDocumentId) async {

    var snapshot = await _client.invokeClientForOneOrder(orderDocumentId);

    Map getDocs = snapshot.data();

//    List <Map<String, dynamic>>
    Map<String,dynamic>       customerAddress = getDocs['address'];
//    List <Map<dynamic, dynamic>> orderedItems = snapshot['items'];
    List<dynamic> orderedItems = getDocs['items'];
//    List<Map<String, dynamic>>
    String                    orderBy =     getDocs['orderby'];
    String                    paidStatus =  getDocs['paidStatus'];
    String                    paidType =    getDocs['paidType'];
    double                    totalPrice =  getDocs['price'];

    String                    contact =    getDocs['contact'];
    String                    driverName = getDocs['driver'];
    DateTime                  endDate =    getDocs['end'].toDate();
    DateTime                  startDate =  getDocs['start'].toDate();

    String                    orderStatus = getDocs['status'];
    String                    tableNo =     getDocs['tableNo'];
    String                    orderType =   getDocs['orderType'];
    String                    documentId = orderDocumentId;
    int                    orderProductionTimeFromNow = getDocs['orderProductionTimeFromNow'];
    String                timeOfDay3 = getDocs['orderProductionTimeOfDay'];
    String                timeOfDay2 = sanitizeTimeOfDay(timeOfDay3);





    double                 deliveryCost2 = getDocs['deliveryCost?'];
    double                 tax = getDocs['tax'];
    double                 priceWithDelivery2 = getDocs['priceWithDelivery?'];


    CustomerInformation currentCustomerFromFireStore = localCustomerInformationObject(customerAddress);
//    new CustomerInformation
    print('currentCustomerFromFireStore.address:____ __ || || || ||  ${currentCustomerFromFireStore.address}');
    print('currentCustomerFromFireStore.flatOrHouseNumber: ${currentCustomerFromFireStore.flatOrHouseNumber}');
    print('currentCustomerFromFireStore.phoneNumber: ${currentCustomerFromFireStore.phoneNumber}');
//    print('currentCustomerFromFireStore.etaTimeInMinutes: ${currentCustomerFromFireStore.etaTimeInMinutes}');




    print('orderedItems: $orderedItems');
    print('orderBy: $orderBy');
    print('paidStatus: $paidStatus');
    print('paidType: $paidType');
    print('totalPrice: $totalPrice');
    print('contact: $contact');
    print('driverName: $driverName');

    print('snapshot[\'end\'].toDate().toString(): ${getDocs['end'].toDate().toString()}');

//    DateTime d = t.toDate();
//    print(d.toString()); //2019-12-28 18:48:48.364
    print('snapshot[\'start\'].toDate().toString()${getDocs['start'].toDate().toString()}');


    print('snapshot[\'end\']: ${getDocs['end'].toDate()}');

    print('snapshot[\'start\']${getDocs['start'].toDate()}');


    print('endDate: $endDate');
    print('startDate: $startDate');

    final formatter1 = /*DateFormat('MM/dd/yyyy H:m'); */ DateFormat.yMd();

    final String timestamp = formatter1.format(startDate);

    final formatter2 = /*DateFormat('MM/dd/yyyy H:m'); */ DateFormat.yMMMMd('en_US').add_Hm();
    final String timestamp2 = formatter1.format(startDate);

    print('timestamp >>>: $timestamp');
    print('timestamp2 >>> <<<: $timestamp2');

    final formatter3 =  DateFormat.jm();
    final formatter4 =  DateFormat.Hm();

    final String formattedOrderPlacementDatesTimeOnly = formatter2.format(startDate);

    final String formattedOrderPlacementDatesTimeOnly2 = formatter4.format(startDate);

    print('formattedOrderPlacementDatesTimeOnly2: $formattedOrderPlacementDatesTimeOnly2');
    print('formattedOrderPlacementDatesTimeOnly < < > >: $formattedOrderPlacementDatesTimeOnly');

    print('orderProductionTimeFromNow: $orderProductionTimeFromNow');

    print('timeOfDay2............... ** ** ** $timeOfDay2');

    //    ticket.text(timestamp,
    //        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    //    new DateFormat.yMMMMd('en_US')
    //    new DateFormat.jm()
    //    new DateFormat.yMd().add_jm()

    //    -> July 10, 1996
    //    -> 5:08 PM
    //    -> 7/10/1996 5:08 PM



    print('orderStatus: $orderStatus'); // "ready"
    print('tableNo: $tableNo');
    print('orderType: $orderType');
    print('documentId: $documentId');

    List<OrderedItem> allOrderedItems= new List<OrderedItem>();
    orderedItems.forEach((oneFood) {

      var oneFoodItem = oneFood;
      print('oneFoodItem[\'quantity\'] ${oneFoodItem['quantity']}!');
      print('oneFoodItem[\'name\'] ${oneFoodItem['name']}!');
      print('oneFoodItem[\'oneFoodTypeTotalPrice\'] ${oneFoodItem['oneFoodTypeTotalPrice']}!');
//      print('oneFoodItem.category: ${oneFoodItem.category}');
      print('oneFoodItem[\'category\']: ${oneFoodItem['category']}');



      print('unitPrice: ${oneFoodItem['unitPrice']}');
      print('unitPrice: ${oneFoodItem['foodImage']}');
      print('unitPrice: ${oneFoodItem['discount']}');
      print('unitPriceWithoutCheeseIngredientSauces: ${oneFoodItem['unitPriceWithoutCheeseIngredientSauces']}');
//      print('unitPrice');
      print('foodItemSize: ${oneFoodItem['foodItemSize']}');

      List<SauceItem>     defaultSauces = convertFireStoreSauceItemsToLocalSauceItemsList(oneFoodItem['selectedSauces']);
      List<NewIngredient> selectedIngredients = convertFireStoreIngredientItemsToLocalNewIngredientItemsList(oneFoodItem['ingredients']);
      List<CheeseItem>    selectedCheeses = convertFireStoreCheeseItemsToLocalCheeseItemsList(oneFoodItem['selectedCheeses']);


      print('defaultSauces : $defaultSauces ');
      print('selectedIngredients : $selectedIngredients ');
      print('selectedCheeses : $selectedCheeses ');

      List<dynamic>          multiSelect =    oneFoodItem['multiSelect'];

      print('multiSelect:_____________________ _____  $multiSelect');
      List<String> multiSelectStringList= new List<String>();
      if(multiSelect!=null){
        multiSelectStringList = List<String>.from(multiSelect);
      }
      print('multiSelectStringList: $multiSelectStringList');

      print('multiSelectStringList.length: ${multiSelectStringList.length}');




      OrderedItem oneTempOrderedItem= new OrderedItem(
        category:  oneFoodItem['category'],

        selectedSauces:  defaultSauces,
        selectedIngredients: selectedIngredients,
        selectedCheeses: selectedCheeses,
        multiSelectString: multiSelectStringList,
//        final List<dynamic> foodItemIngredientsList =  doc['ingredients'];,

        discount:  oneFoodItem['discount'],
        foodItemImage:  oneFoodItem['foodImage'],

        quantity:  oneFoodItem['quantity'],
        name:oneFoodItem['name'],
        oneFoodTypeTotalPrice:oneFoodItem['oneFoodTypeTotalPrice'],
        unitPrice:oneFoodItem['unitPrice'],
        unitPriceWithoutCheeseIngredientSauces: oneFoodItem['unitPriceWithoutCheeseIngredientSauces'],
        foodItemSize: oneFoodItem['foodItemSize'],
      );

      allOrderedItems.add(oneTempOrderedItem);


    });



    /*
    orderedItems55.forEach((oneFood) {
      /* Map<String, dynamic> */ var userX2 = oneFood;

      print('oneFood[\'category\'] ${oneFood['category']}!!');
    });
    */




    OneOrderFirebase oneOrderForReceiptProduction = new OneOrderFirebase(
      oneCustomer:currentCustomerFromFireStore,
//      orderedItems:[],
      orderedItems:allOrderedItems,
      orderBy:orderBy,
      paidStatus:paidStatus,
      paidType:paidType,
      totalPrice:totalPrice,
      contact:contact,
      driverName:driverName,
      endDate:endDate,
      startDate:startDate,
      formattedOrderPlacementDate:timestamp,
      formattedOrderPlacementDatesTimeOnly:formattedOrderPlacementDatesTimeOnly2,
      orderStatus:orderStatus,
      tableNo:tableNo,
      orderType:orderType,
      orderProductionTimeFromNow:orderProductionTimeFromNow,
      timeOfDay: timeOfDay2,
      deliveryCost: deliveryCost2,
      tax:          tax,
      priceWithDelivery: priceWithDelivery2,
      documentId:documentId,
    );





    // print('result:  IIIII   >>>>>  $result'  );


    /*
    if ((oneOrderForReceiptProduction.type != null) &&((oneOrderForReceiptProduction.totalPrice !=null))) {




      return oneOrderForReceiptProduction;
    }
    else {
      */
    return oneOrderForReceiptProduction;
  }

//    AssertionError(result.user.email);
//    print('result: ' + result.user.email);



  void clearSubscription(){


    _curretnOrder = null;
    _expandedSelectedFood = [];
    _orderType = [];
    _paymentType = [];

    _devicesBlueTooth = [];

    _thisRestaurant = null;
    _allCategories = [];
    _allCustomerInput = [];



    _orderController.sink.add(_curretnOrder);
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);
    _orderTypeController.sink.add(_orderType);
    _paymentTypeController.sink.add(_paymentType);

    _devicesController.sink.add(_devicesBlueTooth);

    _restaurantController.sink.add(_thisRestaurant);
    _categoriesController.sink.add(_allCategories);

    _customerInputController.sink.add(_allCustomerInput);


  }

  /*
  void clearSubscriptionPayment(){


    _curretnOrder=null;
    _expandedSelectedFood =[];
    _orderType =[];
    _paymentType =[];

    _devicesBlueTooth = [];

    _thisRestaurant= null;



    _orderController.sink.add(_curretnOrder);
    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);

    _orderTypeController.sink.add(_orderType);
    _paymentTypeController.sink.add(_paymentType);

    _devicesController.sink.add(_devicesBlueTooth);

    _restaurantController.sink.add(_thisRestaurant);


  }


  */



  void initiateCustomerInputFieldSingleSelectOptions()
  {

    OneInputCustomerInformation _address = new OneInputCustomerInformation(


      index:0,
      returnValue:'String',
      complete:false,
      inputName:'address',
      inputOf: ['delivery'],

      //      orderIconName: 'flight_takeoff',
    );

    OneInputCustomerInformation _flat = new OneInputCustomerInformation(
      index:1,
      returnValue:'String',
      complete:false,
      inputName:'flat',
      inputOf: ['delivery'],
    );


//     0xffFEE295 false
    OneInputCustomerInformation _phone = new OneInputCustomerInformation(
      index:2,
      returnValue:'String',
      complete:false,
      inputName:'phone',
      inputOf: ['delivery','phone'],

//      orderIconName: 'phone_in_talk',
    );


    OneInputCustomerInformation _timeOfDay = new OneInputCustomerInformation(
      index:3,
      returnValue:'DateTime',
      complete:false,
      inputName:'timeOfDay',
      inputOf: ['takeAway','delivery','phone','Dinning'],

//      orderIconName: 'phone_in_talk',
    );

    OneInputCustomerInformation _eta = new OneInputCustomerInformation(
      index:4,
      returnValue:'int',
      complete:false,
      inputName:'ETA',
      inputOf: ['takeAway','delivery','_phone','Dinning'],

//      orderIconName: 'phone_in_talk',
    );



    List <OneInputCustomerInformation> customerFieldsInputArray = new List<OneInputCustomerInformation>();


    customerFieldsInputArray.addAll([_address,_flat,_phone, _timeOfDay, _eta]);

    _allCustomerInput = customerFieldsInputArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.
//    initiateAllMultiSelectOptions();
    _customerInputController.sink.add(_allCustomerInput);

  }



  void initiateOrderTypeSingleSelectOptions()
  {

    OrderTypeSingleSelect _takeAway = new OrderTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: true,
      orderType: 'TakeAway',
      iconDataString: 'FontAwesomeIcons.facebook',
      orderTyepImage:'assets/orderBYicons/takeaway.png',

//      orderIconName: 'flight_takeoff',
    );

    OrderTypeSingleSelect _delivery = new OrderTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 1,
      isSelected: false,
      orderType: 'Delivery',
      iconDataString: 'FontAwesomeIcons.twitter',
//      orderIconName: 'local_shipping',
      orderTyepImage:'assets/orderBYicons/delivery.png',
    );


//     0xffFEE295 false
    OrderTypeSingleSelect _phone = new OrderTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 2,
      isSelected: false,
      orderType: 'Phone',
      iconDataString: 'FontAwesomeIcons.home',
      orderTyepImage:'assets/phone.png',

//      orderIconName: 'phone_in_talk',
    );


    OrderTypeSingleSelect _dinningRoom = new OrderTypeSingleSelect(
      borderColor: '0xffB47C00',
      index: 3,
      isSelected: false,
      orderType: 'DinningRoom',
      iconDataString: 'Icons.audiotrack',
//      orderIconName: 'fastfood',
      orderTyepImage:'assets/orderBYicons/diningroom.png',
    );



    List <OrderTypeSingleSelect> orderTypeSingleSelectArray = new List<OrderTypeSingleSelect>();


    orderTypeSingleSelectArray.addAll([_takeAway,_delivery, _phone, _dinningRoom]);

    _orderType = orderTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _orderTypeController.sink.add(_orderType);

  }

  void setOrderTypeSingleSelectOptionForOrder(OrderTypeSingleSelect x, int newIndex,int oldIndex){

    print('newIndex is $newIndex');
    print('oldIndex is $oldIndex');


    List <OrderTypeSingleSelect> singleSelectArray = _orderType;
//    _currentOrderTypeIndex


    singleSelectArray[oldIndex].isSelected =
    !singleSelectArray[oldIndex].isSelected;

    singleSelectArray[newIndex].isSelected =
    !singleSelectArray[newIndex].isSelected;

//    singleSelectArray[index].isSelected = true;

//    x.isSelected= !x.isSelected;


    Order currentOrderTemp = _curretnOrder;

    currentOrderTemp.orderTypeIndex=newIndex;


    _orderType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _curretnOrder = currentOrderTemp;

//    initiateAllMultiSelectOptions();

    _orderTypeController.sink.add(_orderType);
    _orderController.sink.add(_curretnOrder);
  }

  setAddressForOrder(String address){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.address= address;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);

  }

  setHouseorFlatNumberForOrder(String houseOrFlatNumber){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.flatOrHouseNumber= houseOrFlatNumber;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);



//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.flatOrHouseNumber = houseOrFlatNumber;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);

  }

  setPhoneNumberForOrder(String phoneNumber){

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.phoneNumber = phoneNumber;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);
//
//    CustomerInformation currentUser = _oneCustomerInfo;
//
//    currentUser.phoneNumber=phoneNumber;
//
//    _oneCustomerInfo = currentUser;
//    _customerInformationController.sink.add(_oneCustomerInfo);
  }

  // ETA = estimated time of arrival.
  setETAForOrder(String minutes){



    double minutes2 = double.parse(minutes);
    int minutes3 =minutes2.ceil(); // no need to have double

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.etaTimeInMinutes = minutes3;

    tempOrderModifyCustomerInfo.orderingCustomer.etaTimeOfDay= TimeOfDay(hour: 0,minute: 0);

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);



  }

  setETATimeOFDayForOrder(TimeOfDay test){


    print('test: $test');
    print('${test.hour}');
    print('${test.minute}');

    if(test==null){
      TimeOfDay tempTimeOfDay = new TimeOfDay(hour: 0, minute: 0);
      Order tempOrderModifyCustomerInfo = _curretnOrder;

      tempOrderModifyCustomerInfo.orderingCustomer.etaTimeOfDay = test;

      tempOrderModifyCustomerInfo.orderingCustomer.etaTimeInMinutes =-1;

      _curretnOrder = tempOrderModifyCustomerInfo;

      _orderController.sink.add(_curretnOrder);
    }

    Order tempOrderModifyCustomerInfo = _curretnOrder;

    tempOrderModifyCustomerInfo.orderingCustomer.etaTimeOfDay = test;

    tempOrderModifyCustomerInfo.orderingCustomer.etaTimeInMinutes =-1;

    _curretnOrder = tempOrderModifyCustomerInfo;

    _orderController.sink.add(_curretnOrder);


  }


  /*
  Future<List<String>> discoverDevices2(String portNumber) async {
//    AuthResult result = await _auth.signInWithEmailAndPassword(email:
//    email, password: password);

    // print('result:  IIIII   >>>>>  $result'  );
    List<String> devices = [];

//    if (result.user.email != null) {
//      FirebaseUser fireBaseUserRemote = result.user;




    String ip;
    try {
      ip = await Wifi.ip;
      print('local ip:\t$ip');
    } catch (e) {

      print('ip error, please check internet');
      return devices;
    }

    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = 9100;
    try {
      port = int.parse(portNumber);
    } catch (e) {
      print('port.toString()  please check $e');
    }
    print('subnet:\t$subnet, port:\t$port');


    final stream = NetworkAnalyzer.discover2(subnet, port);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');

        devices.add(addr.ip);


      }
    });

    _devices=devices;
    _devicesController.sink.add(_devices);

    return devices;

  }

  */
  /*

//  Future <bool> checkUserinLocalStorage() async {
  void discoverDevicesConstructor(/*String portNumber*/) async {


    // THIS THINGS WORKED SOME MONTH AGO...
    printerManager.scanResults.listen((devices) async {
      print('UI: Devices found ${devices.length}');

      _devicesBlueTooth = devices;
      _devicesController.sink.add(_devicesBlueTooth);

    });






  }

  */

  void discoverDevicesConstructorNewPKG(/*String portNumber*/) async {

    BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
    /*
    // THIS THINGS WORKED SOME MONTH AGO...
    printerManager.scanResults.listen((devices) async {
      print('UI: Devices found ${devices.length}');

      _devicesBlueTooth = devices;
      _devicesController.sink.add(_devicesBlueTooth);

    });

    */

    bool isConnected=await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
//    } on PlatformException {
//      // TODO - Error
//    }
    } on PlatformException {
      // import service for this...
      logger.i('some exception please check');
      // TODO - Error
    }

//    bluetooth.onStateChanged().listen((state) {
//      switch (state) {
//        case BlueThermalPrinter.CONNECTED:
//          setState(() {
//            _connected = true;
//          });
//          break;
//        case BlueThermalPrinter.DISCONNECTED:
//          setState(() {
//            _connected = false;
//          });
//          break;
//        default:
//          print(state);
//          break;
//      }
//    });

//    if (!mounted) return;
//    setState(() {
//      _devices = devices;
//    });

//    if(isConnected) {
//      setState(() {
//        _connected=true;
//      });
//    }

    /*
    NewIngredient.ingredientConvert(Map<String, dynamic> data,String docID)
        :imageURL= data['image'],
    ingredientName= data['name'],
    price = data['price'].toDouble(),
    documentId = docID,
    isDefault= false,
    tempIndex=0,
    ingredientAmountByUser = 1;

    */

    List<PrinterBluetooth> tempPrinterBluetooth = new List<PrinterBluetooth>() ;
    devices.forEach((element) {


      primaryBlueToothPrinter.BluetoothDevice _y = new primaryBlueToothPrinter.BluetoothDevice();

      print('element.name:  ..... ***       ***      @@@    @@@ ${element.name}');


      _y.name = element.name;
      _y.address =  element.address;
      //'98:52:3D:BB:18:26';
      _y.type = element.type;
      //3;

      _y.connected = element.connected;

      //null;

      PrinterBluetooth y = new PrinterBluetooth(_y);

      tempPrinterBluetooth.add(y);

    });
//    BluetoothDevice


    _devicesBlueTooth = tempPrinterBluetooth;
    _devicesController.sink.add(_devicesBlueTooth);

  }



  //  Future <bool> checkUserinLocalStorage() async {
  Future<List<PrinterBluetooth>> discoverDevicesInitState() async {

    printerManager.startScan(Duration(seconds: 4));
    printerManager.scanResults.listen((scannedDevices) {
//      setState(() {
//        _devices=scannedDevices;
//      });
      _devicesBlueTooth = scannedDevices;

      logger.w('scannedDevices: $scannedDevices');
      _devicesController.sink.add(_devicesBlueTooth);
      return _devicesBlueTooth;


//    bluetoo
    }, onDone: () {
      print("Task Done: zzzzz zzzzzz zzzzzzz  zzzzzzzzz zzzzzzz zzzzzzz");
//      _devicesBlueTooth = scannedDevices;

    }, onError: (error, StackTrace stackTrace) {
      print("Some Error: $stackTrace");
    },cancelOnError: false);

    return _devicesBlueTooth;




  }






  @override
  void dispose() {
    _orderController.close();
    _expandedSelectedFoodController.close();
//    _savedSelectedFoodController.close();
    _orderTypeController.close();
    _paymentTypeController.close();
    _devicesController.close();
    _restaurantController.close();
    _categoriesController.close();
    _customerInputController.close();
//    _customerInformationController.close();
//    _multiSelectForFoodController.close();

  }
}