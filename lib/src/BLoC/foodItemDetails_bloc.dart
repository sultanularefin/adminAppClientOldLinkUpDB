
//import 'package:flutter/material.dart';
//import 'package:zomatoblock/BLoC/bloc_provider.dart';
//import 'package:zomatoblock/BLoC/location_bloc.dart';
//import 'package:zomatoblock/BLoC/location_query_bloc.dart';
//
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/generated/i18n.dart';
import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
//import 'package:foodgallery/src/BLoC/identity_bloc.dart';
//import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
//import 'package:foodgallery/src/DataLayer/models/Order.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
import 'package:logger/logger.dart';

//MODELS
//import 'package:foodgallery/src/DataLayer/itemData.dart';
//    import 'package:foodgallery/src/DataLayer/FoodItem.dart';

import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:foodgallery/src/DataLayer/CategoryItemsLIst.dart';
//import 'package:foodgallery/src/DataLayer/NewCategoryItem.dart';
//import 'package:zomatoblock/DataLayer/location.dart';
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';

import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';

//import 'package:flutter/material.dart';
import 'dart:async';


/*
#### keep track of their favorite restaurants
and show those in a separate list
*/

/*
```json
Favoriting Restaurants
So far, the BLoC pattern has been used to manage user input, but it can be used
 for so much more. Let’s say the user want to keep track of their favorite restaurants
and show those in a separate list. That too can be solved with the BLoC pattern.
```
*/


//Map<String, int> mapOneSize = new Map();

class FoodItemDetailsBloc /*with ChangeNotifier */ implements Bloc  {



  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


//  final Sink<int> _external;
//
//  Bloc(this._external);


  // can also use var _oneFoodItem = new FoodItemWithDocID() ;
//  FoodItemWithDocID _oneFoodItem = new FoodItemWithDocID() ;
  FoodItemWithDocIDViewModel _thisFoodItem ;

  FoodItemWithDocIDViewModel get currentFoodItem => _thisFoodItem;



  List<NewIngredient> _allIngItemsDetailsBlock =[];


  List<NewIngredient> _defaultIngItems = [];
  List<NewIngredient> _unSelectedIngItems = [];
  List<FoodPropertyMultiSelect> _multiSelectForFood =[];
//  Order _currentSelectedFoodDetails ;
  SelectedFood _currentSelectedFoodDetails;




//  List <NewIngredient> ingItems = new List<NewIngredient>();



  // FOR location_bloc => final _locationController = StreamController<Location>();
  // [NORMAL STREAM, BELOW IS THE BROADCAST STREAM].

  // FOR location_bloc => Stream<Location> get locationStream => _locationController.stream;

  // getter that get's the stream with _locationController.stream;
  //  Stream<Location> get locationStream => _locationController.stream;

  // declartion and access.


  //  How it know's from the Restaurant array that this are favorite;

  // 1

  SelectedFood get getCurrentSelectedFoodDetails => _currentSelectedFoodDetails;
  List<NewIngredient> get allIngredients => _allIngItemsDetailsBlock;

  List<NewIngredient> get getDefaultIngredients => _defaultIngItems;
  List<NewIngredient> get unSelectedIngredients => _unSelectedIngItems;


  List<FoodPropertyMultiSelect> get getMultiSelectForFood => _multiSelectForFood;





  final _selectedFoodControllerFoodDetails = StreamController <SelectedFood>.broadcast();
  final _controller = StreamController <FoodItemWithDocIDViewModel>();

  // final _itemSizeController = StreamController<Map<String, double>>(); // currentlyNotUsing.

  final _allIngredientListController =  StreamController <List<NewIngredient>>();
//  final _allIngredientListController = StreamController <List<NewIngredient>>();


  final _unSelectedIngredientListController   =  StreamController <List<NewIngredient>>.broadcast();
  final _defaultIngredientListController      =  StreamController <List<NewIngredient>>.broadcast();

  final _multiSelectForFoodController      =  StreamController <List<FoodPropertyMultiSelect>>.broadcast();


//  final _foodItemController = StreamController <List<FoodItemWithDocID>>();

  // INVOKER -> stream: bloc.favoritesStream,

  Stream<SelectedFood> get getCurrentSelectedFoodStream => _selectedFoodControllerFoodDetails.stream;
  Stream<FoodItemWithDocIDViewModel> get currentFoodItemsStream => _controller.stream;
  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;

  Stream<List<NewIngredient>> get getUnSelectedIngredientItemsStream => _unSelectedIngredientListController.stream;
  Stream<List<NewIngredient>> get getDefaultIngredientItemsStream => _defaultIngredientListController.stream;

  Stream<List<FoodPropertyMultiSelect>> get getMultiSelectStream => _multiSelectForFoodController.stream;



  // cheese items
  List<CheeseItem> _allCheeseItemsDBlocDefaultInculdedDeletedIncluded =[];
  List<CheeseItem> get getAllCheeseItems => _allCheeseItemsDBlocDefaultInculdedDeletedIncluded;
  final _cheeseItemsController      =  StreamController <List<CheeseItem>>.broadcast();
  Stream<List<CheeseItem>> get getCheeseItemsStream => _cheeseItemsController.stream;

  // sauce items
  List<SauceItem> _allSauceItemsDBloc = [];
  List<SauceItem> get getAllSauceItems => _allSauceItemsDBloc;
  final _sauceItemsController      =  StreamController <List<SauceItem>>.broadcast();
  Stream<List<SauceItem>> get getSauceItemsStream => _sauceItemsController.stream;


  // selected Cheese Items


  List<CheeseItem> _allSelectedDeletedCheeseItems =[];
  List<CheeseItem> get getAllSelectedCheeseItems => _allSelectedDeletedCheeseItems;
  final _selectedCheeseListController      =  StreamController <List<CheeseItem>>.broadcast();
  Stream<List<CheeseItem>> get getSelectedCheeseItemsStream => _selectedCheeseListController.stream;




  // selected Sauce Items


  List<SauceItem> _allSelectedDeletedSauceItems =[];
  List<SauceItem> get getAllSelectedSauceItems => _allSelectedDeletedSauceItems;
  final _selectedSauceListController      =  StreamController <List<SauceItem>>.broadcast();
  Stream<List<SauceItem>> get getSelectedSauceItemsStream => _selectedSauceListController.stream;




  List<String> _allSubgroups =[];
  List<String> get getAllSubGroups => _allSubgroups;
  final _categoryWiseSubGroupsController      =  StreamController <List<String>>.broadcast();
  Stream <List<String>> get getCategoryWiseSubgroupsStream => _categoryWiseSubGroupsController.stream;




  // Stream<Map<String,double>> get CurrentItemSizePlusPrice => _itemSizeController.stream; // currentlyNotUsing.


  /*
  void toggleRestaurant(Restaurant restaurant) {
    if (_restaurants.contains(restaurant)) {
      _restaurants.remove(restaurant);
    } else {
      _restaurants.add(restaurant);
    }

    _controller.sink.add(_restaurants);
  }

  */




/*

  void getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.ingredientConvert
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

//    print('Ingredient documents are: $documents');


    _allIngItemsDetailsBlock = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;

  }

  */



  void setallIngredients(List<NewIngredient> allIngredients){

    // print('setallIngredients : ___ ___ ___   $allIngredients');

    _allIngItemsDetailsBlock = allIngredients;
    _allIngredientListController.sink.add(_allIngItemsDetailsBlock);

//    List <FoodPropertyMultiSelect> multiSelectArray = _multiSelectForFood;


  }


  int checkIsDefaultSauce(SauceItem oneItem, SauceItem secondItem ){



    print('oneItemisDefaultSelectedSauce:    ${oneItem.isDefaultSelected}');

    print('secondItemisDefaultSelectedSauce: ${secondItem.isDefaultSelected}');

    print('========================done ==============================');

    int x = oneItem.isDefaultSelected     == true ? 1 : 0;
    int y = secondItem.isDefaultSelected  == true ? 1 : 0 ;



    /*


    if ((oneItem.isDefaultSelected == true ) && (secondItem.isDefaultSelected!=true))
      return 3;


    else return 0;

    */
    print('x.compareTo(y): ${x.compareTo(y)}');

    return x.compareTo(y);



  }


  int checkIsDefault(CheeseItem oneItem, CheeseItem secondItem ){



    print('oneItemisDefaultSelected:    ${oneItem.isDefaultSelected}');

    print('secondItemisDefaultSelected: ${secondItem.isDefaultSelected}');

    print('========================done ==============================');


    int x = oneItem.isDefaultSelected     == true ? 1 : 0;
    int y = secondItem.isDefaultSelected  == true ? 1 : 0 ;




    /*
    if ((oneItem.isDefaultSelected == true ) && (secondItem.isDefaultSelected!=true))
      return 1;

//    else if ((oneItem.isDefaultSelected == false ) && (secondItem.isDefaultSelected ==true))
//      return -1;

  else return -1;

  */

    print('x.compareTo(y): ${x.compareTo(y)}');
    return x.compareTo(y);


  }


  void initiateSauces(List<SauceItem> sauceItems0, List<String>defaultSaucesString) async {

    print('sauceItems0.length: ${sauceItems0.length}');

//    print('defaultSauces: $defaultSaucesString length: ${defaultSaucesString.length}');




    sauceItems0.map((oneSauce) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneSauce.isDefaultSelected = false
    )).toList();

    sauceItems0.map((oneSauce) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneSauce.isSelected = false
    )).toList();

    List <SauceItem> sauceItems = sauceItems0;


    if(defaultSaucesString!=null) {
      print('??? ??? ??? ???  defaultSaucesString.length ==0 : ${defaultSaucesString.length == 0}');
      List<
          SauceItem> allSauceItemsDefaultIncluded = filterSelectedKastikesSauces(
          sauceItems,
          defaultSaucesString);


      logger.w('allSauceItemsDefaultIncluded.length: ${allSauceItemsDefaultIncluded.length}');

      print('allSauceItemsDefaultIncluded.length: ${allSauceItemsDefaultIncluded.length}');

      allSauceItemsDefaultIncluded.sort((a, b) => a.compareTo(b));

//      allSauceItemsDefaultIncluded.sort((a,b)=> (a.isDefaultSelected == b.isDefaultSelected) ? 0 :
//      (a.isDefaultSelected == false)? -1 : 1);


//      allSauceItemsDefaultIncluded.sort((a,b)=> a.sauceItemName.length.compareTo(b.sauceItemName.length));




//      tempForCategorising.sort((a,b)=>checkRating(a.categoryName,b.categoryName, _allCategories));


      allSauceItemsDefaultIncluded.forEach((oneSauceItem) {

        if(oneSauceItem.isDefaultSelected){
          oneSauceItem.isSelected=true;
          oneSauceItem.isDefaultSelected=true;

          print('oneSauceItem.sauceItemName: ${oneSauceItem.sauceItemName} and '
              ''
              'condition oneSauceItem.isDefaultSelected is ${oneSauceItem.isDefaultSelected}');


        }
      });

      _allSauceItemsDBloc = allSauceItemsDefaultIncluded;
      _sauceItemsController.sink.add(_allSauceItemsDBloc);


      _allSelectedDeletedSauceItems = sauceItems.where((element) => element.isSelected==true).toList();

      print('VVV   VVV   VVV   VVV _allSelectedSauceItems.length: ${_allSelectedDeletedSauceItems.length}');
      _selectedSauceListController.sink.add(_allSelectedDeletedSauceItems);


    }

    else{

      print('???? ????      ???? ????   defaultSaucesString.length == 0: ${defaultSaucesString.length == 0}');


      _allSauceItemsDBloc = sauceItems;
      _sauceItemsController.sink.add(_allSauceItemsDBloc);


      _allSelectedDeletedSauceItems = sauceItems.where((element) => element.isSelected==true).toList();
      print('VVV   VVV   VVV  VVV    _allSelectedSauceItems.length: ${_allSelectedDeletedSauceItems.length}');
      _selectedSauceListController.sink.add(_allSelectedDeletedSauceItems);


    }

//GGGGGG









//    return ingItems;

  }



  void initiateCheeseItems(List<CheeseItem> cheeseItems0,List<String>defaultCheesesString ) async {


    print('cheeseItems0.length: ${cheeseItems0.length}');

//    print('defaultCheeses: $defaultCheeses length: ${defaultCheeses.length}');



    cheeseItems0.map((oneCheese) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneCheese.isDefaultSelected = false
    )).toList();

    cheeseItems0.map((oneCheese) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneCheese.isSelected = false
    )).toList();


    List <CheeseItem> cheeseItems = cheeseItems0;

    if(defaultCheesesString.length !=0) {
      print('??? ???  ???? defaultCheesesString.length !=0: ${defaultCheesesString.length !=0}');

      List<
          CheeseItem> allCheeseItemsDefaultIncluded2 = filterSelectedJuustoOrCheeses(
          cheeseItems,
          defaultCheesesString);


      print('allCheeseItemsDefaultIncluded.length: ${allCheeseItemsDefaultIncluded2.length}');
      logger.i('allCheeseItemsDefaultIncluded.length: ${allCheeseItemsDefaultIncluded2.length}');


//GGGGGG

      allCheeseItemsDefaultIncluded2.sort((a, b) => a.compareTo(b));

//      allCheeseItemsDefaultIncluded.sort((a, b) =>
//          checkIsDefault(a, b,
//          ));


      allCheeseItemsDefaultIncluded2.forEach((oneCheeseItem) {
        if (oneCheeseItem.isDefaultSelected) {
          oneCheeseItem.isSelected = true;
          oneCheeseItem.isDefaultSelected = true;


          print('oneCheeseItem.cheeseItemName: ${oneCheeseItem
              .cheeseItemName} and '
              ''
              'condition oneCheeseItem.isSelected == true ${oneCheeseItem
              .isSelected == true}');
        }
      }

      );

      _allCheeseItemsDBlocDefaultInculdedDeletedIncluded = allCheeseItemsDefaultIncluded2;

      _cheeseItemsController.sink.add(_allCheeseItemsDBlocDefaultInculdedDeletedIncluded);


      _allSelectedDeletedCheeseItems =
          allCheeseItemsDefaultIncluded2.where((element) => element.isSelected ==
              true).toList();

      print('WWW   WWWW   WWWW   WWWW_allSelectedCheeseItems.length: ${_allSelectedDeletedCheeseItems.length}');

      _selectedCheeseListController.sink.add(_allSelectedDeletedCheeseItems);
    }
    else{
      print(' ????      ???? defaultCheesesString.length ==0: ${defaultCheesesString.length ==0}');
      _allCheeseItemsDBlocDefaultInculdedDeletedIncluded = cheeseItems;
      _cheeseItemsController.sink.add(_allCheeseItemsDBlocDefaultInculdedDeletedIncluded);


      _allSelectedDeletedCheeseItems = cheeseItems.where((element) => element.isSelected==true).toList();
      print('WWW    WWWW  WWWW    WWWW_allSelectedCheeseItems.length: ${_allSelectedDeletedCheeseItems.length}');
      _selectedCheeseListController.sink.add(_allSelectedDeletedCheeseItems);
    }


  }




  // HELPER METHOD FOR TEST TO BE MODIFIED....  AUGUST 14 2020.....
  bool checkThisExtraIngredientForSomeCategory(NewIngredient x,String shortCategroyName) {

    print('_______ ________ shortCategroyName:  $shortCategroyName');
    print('x: $x');
    print('x: ${x.ingredientName}');
//    List<String>.from(x.extraIngredientOf);


    List<String> extraIngredientOFstringList = List<String>.from(x.extraIngredientOf);
    //x.extraIngredientOf;



    print('x.ingredientName ${x.ingredientName}  x.subgroup...: ${x.subgroup}');


    String elementExists = extraIngredientOFstringList.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == shortCategroyName.toLowerCase().trim(),
        orElse: () => '');

    if(elementExists!=''){

      print('elementExists: $elementExists and ingredient Name: ${x.ingredientName}');

      return true;

    }

//    print('elementExists: Line # 612:  $elementExists');

    print('element don\'t Exists: and  shortCategroyName:  $shortCategroyName ingredient Name: ${x.ingredientName}');



    return false;


  }


  // CONSTRUCTOR BEGINS HERE.
  FoodItemDetailsBloc(
      FoodItemWithDocID oneFoodItem,
//      List<NewIngredient> allIngsScoped ,
      List<CheeseItem> tempCheeseItems,
      List<SauceItem> tempSauceItems,
      List<NewIngredient> allExtraIngredients,
      ) {

//    fireStoreFieldName
//    oneFoodItem,
//    tempIngs,


//    FoodItemWithDocID



    logger.i('oneFoodItem.itemName: ${oneFoodItem.itemName}');
    print('|||| ||||| |||||| oneFoodItem.defaultKastike.length:'
        ' ${oneFoodItem.defaultKastike.length}');
    print('YYY YYYY YYYY YYYY YYYY YY oneFoodItem.defaultJuustoe.length: ${oneFoodItem.defaultJuusto.length}');
    print('YYY YYYY YYYY YYYY YYYY YY oneFoodItem.ingredients.length: ${oneFoodItem.ingredients.length}');



    print('||| |||| |||| ||| ||||| oneFoodItem.defaultKastike : ${oneFoodItem.defaultKastike}');
    print('YYY YYY YYYYY YYYYY YYYYY oneFoodItem.defaultJuustoe : ${oneFoodItem.defaultJuusto}');


    List<String> cheesesStrings2 =
    oneFoodItem.defaultJuusto.where((e) => ((e != null) && (e != ''))).toList();

    List<String> saucesStrings2 =
    oneFoodItem.defaultKastike.where((e) => ((e != null) && (e != ''))).toList();

    print('cheesesStrings2: $cheesesStrings2');

    print('saucesStrings2: $saucesStrings2');

    print('cheesesStrings2.length : ${cheesesStrings2.length}');
    print('saucesStrings2.length : ${saucesStrings2.length}');


    initiateSauces(tempSauceItems,saucesStrings2);
    initiateCheeseItems(tempCheeseItems,cheesesStrings2);

    initiateAllMultiSelectOptions();


    List<NewIngredient> ingredientsOfOnlyThisFoodItemsCategory =
    allExtraIngredients.where((e) => checkThisExtraIngredientForSomeCategory(e,oneFoodItem.shorCategoryName)).toList();


    print('{{{  {{{  {{{   ingredientsOfOnlyThisFoodItemsCategory[${oneFoodItem.shorCategoryName}.length ==> --> '
        '==> ${ingredientsOfOnlyThisFoodItemsCategory.length}');
    logger.i('{{{  {{{  {{{   ingredientsOfOnlyThisFoodItemsCategory[${oneFoodItem.shorCategoryName}.length ==> -->'
        ' ==> ${ingredientsOfOnlyThisFoodItemsCategory.length}');


    Set<String> allSubgroupsForThisFoodItem ={};

//    List<String> categories = [];

    int tempIndex=0;
    ingredientsOfOnlyThisFoodItemsCategory.forEach((oneExtraIngredient) {

      print('oneExtraIngredient.subgroup: ${oneExtraIngredient.subgroup} oneExtraIngredient.ingredientName:'
          ' ${oneExtraIngredient.ingredientName}');

      allSubgroupsForThisFoodItem.add(oneExtraIngredient.subgroup.trim());
      oneExtraIngredient.tempIndex = ++tempIndex;

    });

    print('subgroups.length => ${allSubgroupsForThisFoodItem.length}:  >               >               >');


    allSubgroupsForThisFoodItem.forEach((oneGroupString) {
      print('oneGroupString: $oneGroupString');
    });


    List<String> convertedSubgroups = allSubgroupsForThisFoodItem.toList();

    logger.w('convertedSubgroups.length: ${convertedSubgroups.length}');

    _allSubgroups = convertedSubgroups ;
    _categoryWiseSubGroupsController.sink.add(_allSubgroups);

    /* Ordered Food Related codes ends here. */


//    logger.e('oneFoodItem.discount: ${oneFoodItem.discount}');

    final Map<String, dynamic> foodSizePrice = oneFoodItem.sizedFoodPrices;

    /* INGREDIENTS HANDLING CODES STARTS HERE: */
    List<String> ingredientStringsForWhereInClause;


    // COUNTER MEASURES SINCE WE INVOKE APPBLOC FROM WELCOME PAGE WHERE THIS CONSTRUCTOR IS CALLED 1.
    // COUNTER MEASURE 01.

    //  print('^^  ^ ^^  oneFoodItem.itemName: ${oneFoodItem.itemName}');
    final List<dynamic> foodItemIngredientsList2 = oneFoodItem.itemName==null ? null:oneFoodItem.ingredients;

    print('foodItemIngredientsList2.length => : ${foodItemIngredientsList2.length}');
    logger.i('foodItemIngredientsList2.length: ${foodItemIngredientsList2.length}');

    // COUNTER MEASURE 02.
    List<String> listStringIngredients = oneFoodItem.itemName==null ?null:dynamicListFilteredToStringList(
        foodItemIngredientsList2);


    print('listStringIngredients.length => : ${listStringIngredients.length}');
    logger.i('listStringIngredients.length: ${listStringIngredients.length}');






    // ingredientsOfCategory
    // SHORT CIRCUIT WORKING HERE.
    if ((listStringIngredients != null) && (listStringIngredients.length != 0)) {

      filterSelectedDefaultIngredients(
          ingredientsOfOnlyThisFoodItemsCategory,
//          allExtraIngredients,
          listStringIngredients); // only default<NewIngredient>

      filterUnSelectedIngredients(
          ingredientsOfOnlyThisFoodItemsCategory,
//          allExtraIngredients,
          listStringIngredients); // only default<NewIngredient>


    }

    else {
      print('at else statement:  ===> ===> ===> ===>');

//      print('allIngsScoped.length  ===> ===> ===> ===> ${allIngsScoped.length}');
      List <NewIngredient> ingItems = new List<NewIngredient>();
      // ARE THIS TWO STATEMENTS WHERE I PUT A 'NONE' ITEM IN DEFAULT INGREDIENTS NECESSARY ???*/

      _defaultIngItems = ingItems;
      _defaultIngredientListController.sink.add(_defaultIngItems);



      List<NewIngredient> unSelectedDecremented =
      ingredientsOfOnlyThisFoodItemsCategory.map((oneIngredient) =>
          NewIngredient.updateUnselectedIngredient(
              oneIngredient
          )).toList();

      print('unSelectedIngredientsFiltered ===>  ${unSelectedDecremented
          .length}');
      print(
          "length of unSelectedIngredientsFiltered ===>  =======> ========>> ==========> =========> ");
      _unSelectedIngItems = unSelectedDecremented;


      _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

//      return ingItems;

    }

    //DDDD todo

    /* INGREDIENTS HANDLING CODES ENDS HERE: */

    // COUNTER MEASURE 04.
    dynamic normalPrice = oneFoodItem.itemName==null ? 0 :foodSizePrice['normal'];


    double normalPriceCasted = tryCast<double>(normalPrice, fallback: 0.00);

    SelectedFood selectedFoodInConstructor = new SelectedFood(
      foodItemName:oneFoodItem.itemName,
      foodItemImageURL: oneFoodItem.imageURL,
      unitPrice: 0, // this value will be set when increment and decreemnt
      //button pressed from the UI.
      unitPriceWithoutCheeseIngredientSauces:0,
      foodDocumentId: oneFoodItem.documentId,
      quantity:0,
      foodItemSize: 'normal', // to be set from the UI.
      selectedIngredients:_defaultIngItems,
      categoryName:oneFoodItem.categoryName,
//      discount:oneFoodItem.discount,
      selectedCheeseItems : _allSelectedDeletedCheeseItems,
      selectedSauceItems:   _allSelectedDeletedSauceItems,
      multiSelct: _multiSelectForFood,
    );

    _currentSelectedFoodDetails = selectedFoodInConstructor;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);


    FoodItemWithDocIDViewModel thisFood =
    FoodItemWithDocIDViewModel.customCastFrom(
        oneFoodItem, 'normal', normalPriceCasted);



    _thisFoodItem =
        thisFood; // important otherwise => The getter 'sizedFoodPrices' was called on null.




    _controller.sink.add(_thisFoodItem);
  }

  // CONSTRUCTOR ENDS HERE.

//  List<FoodPropertyMultiSelect> initiateAllMultiSelectOptions()
  void initiateAllMultiSelectOptions()
  {

    FoodPropertyMultiSelect _org = new FoodPropertyMultiSelect(
      borderColor: '0xff739DFA',
      index: 4,
      isSelected: false,
      itemName: 'ORG',
      itemFullName:'Oregano',
      itemImage:'assets/multiselectImages/multiSelectAssetORG.png',
      itemTextColor: '0xff739DFA',
    );

//    assets/multiselectImages/multiSelectAssetM.png
//    assets/multiselectImages/multiSelectAssetVSM.png
//    assets/multiselectImages/multiSelectAssetVS.png
//    assets/multiselectImages/multiSelectAssetORG.png

    FoodPropertyMultiSelect _vs = new FoodPropertyMultiSelect(
      borderColor: '0xff95CB04',
      index: 3,
      isSelected: false,
      itemName: 'VS',
      itemFullName:'Valkosipuli',
      itemImage:'assets/multiselectImages/multiSelectAssetVS.png',
      itemTextColor: '0xff95CB04',
    );


//     0xffFEE295 false
    FoodPropertyMultiSelect _vsm = new FoodPropertyMultiSelect(
      borderColor: '0xff34720D',
      index: 2,
      isSelected: false,
      itemName: 'VSM',
      itemFullName:'Valkosipuli Majoneesi',
      itemImage:'assets/multiselectImages/multiSelectAssetVSM.png',
      itemTextColor: '0xff34720D',
    );


    FoodPropertyMultiSelect _m = new FoodPropertyMultiSelect(
      borderColor: '0xffB47C00',
      index: 1,
      isSelected: false,
      itemName: 'M',
      itemFullName:'Majoneesi',
      itemImage:'assets/multiselectImages/multiSelectAssetM.png',
      itemTextColor: '0xffB47C00',
    );


    List <FoodPropertyMultiSelect> multiSelectArray = new List<FoodPropertyMultiSelect>();

    multiSelectArray.addAll([_org,_vs,_vsm,_m]);

    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.


//    initiateAllMultiSelectOptions();

    _multiSelectForFoodController.sink.add(_multiSelectForFood);

  }

  /*  Below ARE OrderedFoodItem related codes decrement increment( SET) */
  void decrementOneSelectedFoodForOrder(/* SelectedFood oneSelectedFoodFD,
   first arg IS NOT REQUIRED FOR DECREMENT */itemCount){



    print('/// ////         // itemCount at DEC : $itemCount');
    int numberOFSelectedFoods;
//    Order tempOrderDecrementOperation = _currentSelectedFoodDetails;

    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;

    if(itemCount==1){

      print('_currentSelectedFoodDetails.selectedFoodInOrder[0].quantity:'
          '${_currentSelectedFoodDetails.quantity}');


//      int newSelectedFoodOrderLength = tempOrderDecrementOperation.selectedFoodListLength-1;


      // from 1 to 0 and passed as parameter.
//      tempOrderDecrementOperation.selectedFoodInOrder.removeAt(newSelectedFoodOrderLength);
      tempSelectedFood.quantity =tempSelectedFood.quantity-1;

      // remove at 0 means first item.

      //      List x=[1,2,3,4];
//      print('List(0) $List(0)');


//      tempOrderDecrementOperation.selectedFoodListLength= 0;

      _currentSelectedFoodDetails = tempSelectedFood;

//      print('_currentSelectedFoodDetails.selectedFoodInOrder.length:'
//          +'${_currentSelectedFoodDetails.selectedFoodInOrder.length} ');

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);
    }
    else{

      tempSelectedFood.quantity = itemCount-1;

      _currentSelectedFoodDetails = tempSelectedFood;

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);

    }

//    x.selectedFoodInOrder.add(constructorSelectedFoodFD);
  }

  void incrementOneSelectedFoodForOrder(SelectedFood oneSelectedFoodFD,int  initialItemCount  /*ItemCount */){


    print('_   _    _ itemCount _   _   _:$initialItemCount');



    if( initialItemCount == 0 ) {

      print( '>>>> initialItemCount == 0  <<<< ');


      SelectedFood tempSelectedFood = oneSelectedFoodFD ;

      // REQUIRED ...
      oneSelectedFoodFD.selectedIngredients = _defaultIngItems;
      oneSelectedFoodFD.selectedCheeseItems = _allSelectedDeletedCheeseItems;
      oneSelectedFoodFD.selectedSauceItems  = _allSelectedDeletedSauceItems;
      oneSelectedFoodFD.multiSelct  = _multiSelectForFood;





      _currentSelectedFoodDetails =tempSelectedFood;

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);

    }
    else{



      SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;

      tempSelectedFood.quantity = tempSelectedFood.quantity +1;

      _currentSelectedFoodDetails = tempSelectedFood;

      _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);


    }


  }

  /*  ABOVE ARE OrderedFoodItem related codes*/

  void setMultiSelectOptionForFood(FoodPropertyMultiSelect x, int index){


    List <FoodPropertyMultiSelect> multiSelectArray = _multiSelectForFood;

    x.isSelected= !x.isSelected;
    multiSelectArray[index]=x;

    _multiSelectForFood = multiSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _multiSelectForFoodController.sink.add(_multiSelectForFood);



//    void remove....

    // selected update.
//    _allSelectedDeletedSauceItems = allTempSauceItems.where((element) => ((element.isSelected==true) ||
//        (element.isDeleted==true))).toList();
//    _selectedSauceListController.sink.add(_allSelectedDeletedSauceItems);

    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;
    tempSelectedFood.multiSelct= _multiSelectForFood;


    _currentSelectedFoodDetails = tempSelectedFood;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);

  }



  void incrementThisIngredientItem(NewIngredient thisIngredient){

    print('reached here: incrementThisIngredientItem ');
    print('_unSelectedIngItems.length: ${_unSelectedIngItems.length}');


    print('...${thisIngredient.ingredientName}');

//                          NewIngredient c1 = oneUnselectedIngredient;


//    print('modified ingredientAmountByUser at begin: ${_unSelectedIngItems[tempIndex].
//    ingredientAmountByUser}');



    NewIngredient c1 = new NewIngredient(
      ingredientName: thisIngredient
          .ingredientName,
      imageURL: thisIngredient.imageURL,

      price: thisIngredient.price,
      documentId: thisIngredient.documentId,
      ingredientAmountByUser: thisIngredient
          .ingredientAmountByUser + 1,

      extraIngredientOf: thisIngredient.extraIngredientOf,
      sequenceNo : thisIngredient.sequenceNo,
      subgroup: thisIngredient.subgroup,
//      tempIndex: tempIndex2,


      isDefault: false,
    );



    List<NewIngredient> tempUnSelectedAll = _unSelectedIngItems;

    tempUnSelectedAll.forEach((element) {
      print('...element.ingredientName =>> ${element.ingredientName}');
    });


    int index22 = tempUnSelectedAll.
    indexWhere((note) => note.ingredientName.toLowerCase().trim()==
        thisIngredient.ingredientName.toLowerCase().trim());


    print('index22 : :: $index22');

    print('----_unSelectedIngItems[index22].ingredientName: ${_unSelectedIngItems[index22].ingredientName}');


    tempUnSelectedAll.removeAt(index22);

    tempUnSelectedAll.insert(index22, c1);

    _unSelectedIngItems = tempUnSelectedAll;

    print('_unSelectedIngItems.length: ${_unSelectedIngItems.length}');
//      print('modified ingredientAmountByUser at end: ${_unSelectedIngItems[tempIndex2].ingredientAmountByUser}');



//   _thisFoodItem =thisFoodpriceModified;

    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);
//    }


  }


  void removeThisDefaultIngredientItem(NewIngredient unSelectedOneIngredient,int index){
    print('reached here ==> : <==  remove This Default Ingredient Item ');

    List<NewIngredient> allDefaultIngredientItems = _defaultIngItems;
    NewIngredient temp =  allDefaultIngredientItems[index];
    allDefaultIngredientItems.removeAt(index);

//    SINCE WE NEED TO SHOW THE DELETED INGREDIENT IN PAPER..
    /*

    NewIngredient temp =  allDefaultIngredientItems[index];



    */


    // TESTING TO BE UNCOMMENTED AGAIN....
    // BELOW 3 LINES.....

    NewIngredient tempButStillInDefault = temp;
    tempButStillInDefault.isDeleted = true;
    allDefaultIngredientItems.add(tempButStillInDefault);

    _defaultIngItems= allDefaultIngredientItems;
//    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _defaultIngredientListController.sink.add(_defaultIngItems);


    //  NOW ADD PART BEGINS HERE

    List<NewIngredient> allUnSelectedIngredientItems = _unSelectedIngItems;

    allUnSelectedIngredientItems.add(temp);


    _unSelectedIngItems  = allUnSelectedIngredientItems;
    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

    setNewPriceforSauceItemCheeseItemIngredientUpdate();
//    setNewPriceBySelectedSauceItems(_allSelectedSauceItems);
    // pqr.


  }

//  setThisCheeseAsSelectedCheeseItem
  void setThisSauceAsSelectedSauceItem(SauceItem oneSauceItem,int index){

//    print('index: $index');
    List<SauceItem> allTempSauceItems = _allSauceItemsDBloc;

    allTempSauceItems[index].isSelected= !allTempSauceItems[index].isSelected;

    _allSauceItemsDBloc = allTempSauceItems;
    _sauceItemsController.sink.add(_allSauceItemsDBloc);

    _allSelectedDeletedSauceItems = allTempSauceItems.where((element) => ((element.isSelected==true) || (element.isDefaultSelected ==true))).toList();
    _selectedSauceListController.sink.add(_allSelectedDeletedSauceItems);

    setNewPriceforSauceItemCheeseItemIngredientUpdate();


    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;

    tempSelectedFood.selectedSauceItems= _allSelectedDeletedSauceItems;
    _currentSelectedFoodDetails = tempSelectedFood;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);
  }


  void removeThisSauceFROMSelectedSauceItem(SauceItem oneSauceItem,int index){

    List<SauceItem> allTempSauceItems = _allSauceItemsDBloc;

    allTempSauceItems[index].isSelected = !allTempSauceItems[index].isSelected;
    allTempSauceItems[index].isDeleted = true;


    _allSauceItemsDBloc = allTempSauceItems;
    _sauceItemsController.sink.add(_allSauceItemsDBloc);

    // selected update.
    _allSelectedDeletedSauceItems = allTempSauceItems.where((element) => ((element.isSelected==true) ||
        (element.isDeleted==true))).toList();
    _selectedSauceListController.sink.add(_allSelectedDeletedSauceItems);


    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;
    tempSelectedFood.selectedSauceItems= _allSelectedDeletedSauceItems;
    _currentSelectedFoodDetails = tempSelectedFood;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);



    // selected update.
//    _allSelectedDeletedCheeseItems = allTempCheeseItems.where((element) => ((element.isSelected==true) ||
//        (element.isDeleted==true))).toList();
//    _selectedCheeseListController.sink.add(_allSelectedDeletedCheeseItems);

//    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;
//    tempSelectedFood.selectedCheeseItems= _allSelectedDeletedCheeseItems;
//    _currentSelectedFoodDetails = tempSelectedFood;
//    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);







    setNewPriceforSauceItemCheeseItemIngredientUpdate();

  }

  void setThisCheeseAsSelectedCheeseItem(CheeseItem oneCheeseItem,int index){

    // todo -- update selected cheese item in BBBB



    List<CheeseItem> allTempCheeseItems = _allCheeseItemsDBlocDefaultInculdedDeletedIncluded;

    allTempCheeseItems[index].isSelected= !allTempCheeseItems[index].isSelected;

    _allCheeseItemsDBlocDefaultInculdedDeletedIncluded = allTempCheeseItems;
    _cheeseItemsController.sink.add(_allCheeseItemsDBlocDefaultInculdedDeletedIncluded);

    // selected update.
    _allSelectedDeletedCheeseItems = allTempCheeseItems.where((element) => ((element.isSelected == true)||
        (element.isDefaultSelected ==true))).toList();
    _selectedCheeseListController.sink.add(_allSelectedDeletedCheeseItems);

    setNewPriceforSauceItemCheeseItemIngredientUpdate();


    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;

    tempSelectedFood.selectedCheeseItems= _allSelectedDeletedCheeseItems;
    _currentSelectedFoodDetails = tempSelectedFood;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);

//    selectedCheeseItems : _allSelectedCheeseItems,
//    selectedSauceItems:   _allSelectedSauceItems,
//    );
//
//    _currentSelectedFoodDetails = selectedFoodInConstructor;
//

  }

  // 911_1
  void removeThisCheeseFROMSelectedCheeseItem(CheeseItem oneCheeseItem,int index){

    List<CheeseItem> allTempCheeseItems = _allCheeseItemsDBlocDefaultInculdedDeletedIncluded;

    allTempCheeseItems[index].isSelected= !allTempCheeseItems[index].isSelected;
    allTempCheeseItems[index].isDeleted = true;

    _allCheeseItemsDBlocDefaultInculdedDeletedIncluded = allTempCheeseItems;
    _cheeseItemsController.sink.add(_allCheeseItemsDBlocDefaultInculdedDeletedIncluded);

    // selected update.
    _allSelectedDeletedCheeseItems = allTempCheeseItems.where((element) => ((element.isSelected==true) ||
        (element.isDeleted==true))).toList();
    _selectedCheeseListController.sink.add(_allSelectedDeletedCheeseItems);

    SelectedFood tempSelectedFood = _currentSelectedFoodDetails;//oneSelectedFoodFD ;
    tempSelectedFood.selectedCheeseItems= _allSelectedDeletedCheeseItems;
    _currentSelectedFoodDetails = tempSelectedFood;
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);




    setNewPriceforSauceItemCheeseItemIngredientUpdate();

  }



  void finishMoreDefaultIngredientItems(/*NewIngredient unSelectedOneIngredient,int index*/){
    print('reached here ==> : <==  update Default IngredientItem ');

    List<NewIngredient> allDefaultIngredientItems = _defaultIngItems;

    List<NewIngredient> allPreviouslyUnSelectedIngredientItems = _unSelectedIngItems;

    List <NewIngredient> valueIncrementedUNselectedIngredient =

    allPreviouslyUnSelectedIngredientItems.where((oneItem) => oneItem.ingredientAmountByUser >0).toList();


//    logger.e('valueIncrementedUNselectedIngredient: $valueIncrementedUNselectedIngredient');


    List <NewIngredient> valueUnChangedUNselectedIngredient =

    allPreviouslyUnSelectedIngredientItems.where((oneItem) => oneItem.ingredientAmountByUser == 0).toList();


//    List<String> stringList = List<String>.from(dlist);
//    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
//    ==
//    isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

//    logger.e('valueUnChangedUNselectedIngredient: $valueUnChangedUNselectedIngredient');



    allDefaultIngredientItems.addAll(valueIncrementedUNselectedIngredient);

    _defaultIngItems = allDefaultIngredientItems;
//    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _defaultIngredientListController.sink.add(_defaultIngItems);

    // --- price update invocation.

//    setNewPriceByIngredientAdd(_defaultIngItems);

    setNewPriceforSauceItemCheeseItemIngredientUpdate();
//    setNewPriceBySelectedIngredientItems();

    //  NOW ADD PART BEGINS HERE

    List<NewIngredient> allUnSelectedIngredientItems = valueUnChangedUNselectedIngredient;

    _unSelectedIngItems  = allUnSelectedIngredientItems;
    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

  }


  void decrementThisIngredientItem(NewIngredient thisIngredient,int index){

    print('reached here: decrementThisIngredientItem ');

//                          NewIngredient c1 = oneUnselectedIngredient;


    NewIngredient c1 = new NewIngredient(
      ingredientName: thisIngredient
          .ingredientName,
      imageURL: thisIngredient.imageURL,

      price: thisIngredient.price,
      documentId: thisIngredient.documentId,
      ingredientAmountByUser: thisIngredient
          .ingredientAmountByUser - 1,
      isDefault: false,

      extraIngredientOf: thisIngredient.extraIngredientOf,
      sequenceNo : thisIngredient.sequenceNo,
      subgroup: thisIngredient.subgroup,



    );



    List<NewIngredient> allUnselectedbutOneDecremented = _unSelectedIngItems;


//    List<NewIngredient> tempUnSelectedAll = _unSelectedIngItems;



    int index22 = allUnselectedbutOneDecremented.
    indexWhere((note) => note.ingredientName.toLowerCase().trim()== thisIngredient.ingredientName);


    print('index22 : :: $index22');

    print('----_unSelectedIngItems[index22].ingredientName: ${_unSelectedIngItems[index22].ingredientName}');


    allUnselectedbutOneDecremented.removeAt(index22);

    allUnselectedbutOneDecremented.insert(index22, c1);



//   sssss


//    allUnselectedbutOneDecremented[index] = c1;

    _unSelectedIngItems= allUnselectedbutOneDecremented;
//   _thisFoodItem =thisFoodpriceModified;

    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);

    //THIS LINE MIGHT NOT BE NECESSARY.


  }



  void setNewSizePlusPrice(String sizeKey) {
    final Map<String,dynamic> foodSizePrice = _thisFoodItem.sizedFoodPrices;

    print("_thisFoodItem.sizedFoodPrices: ${_thisFoodItem.sizedFoodPrices}");

//    logger.i('sizeKey: ',sizeKey);

    dynamic changedPrice1 = foodSizePrice[sizeKey];

    print('changedPrice1: $changedPrice1');

    double changedPriceDouble = tryCast<double>(changedPrice1, fallback: 0.00);


    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;
    thisFoodpriceModified.itemSize = sizeKey;
    thisFoodpriceModified.itemPriceBasedOnSize =  changedPriceDouble;
    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = changedPriceDouble;


    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);



  }

  // HELPER METHOD tryCast Number (1)
  double test1(NewIngredient x) {


    return x.price ;
  }

  void setNewPriceByIngredientAdd(List<NewIngredient> defaultIngredients) {

//    List<NewIngredient> defaultIngredientsLaterAdded = defaultIngredients.map((oneDefaultIngredient))

    List<NewIngredient> defaultIngredientsLaterAdded
    = defaultIngredients.where((oneDefaultIngredient) =>
    oneDefaultIngredient.isDefault!=true).toList();


    double addedIngredientItemsPrice= defaultIngredientsLaterAdded.fold(0, (t, e) => t + e.price);
    print('addedIngredientItemsPrice : $addedIngredientItemsPrice');

    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;

    double previousPrice = _thisFoodItem.priceBasedOnCheeseSauceIngredientsSize;
    print('previous  price: $previousPrice');

//    thisFoodpriceModified.itemPrice

    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = previousPrice + addedIngredientItemsPrice;


//    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);

  }

  /*
  void setNewPriceBySelectedCheeseItems(List<CheeseItem> cheeseItems) {

    double addedCheeseItemsPrice = cheeseItems.fold(0, (t, e) => t + e.price);
    print('addedCheeseItemsPrice : $addedCheeseItemsPrice');

    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;

    double previousPrice = _thisFoodItem.priceBasedOnCheeseSauceIngredientsSize;

    print('previous CheeseItem price: $previousPrice');

//    thisFoodpriceModified.itemPrice

    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = previousPrice + addedCheeseItemsPrice;

    print('modified price for new Cheese Item addition or remove: '
        '${thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize}');

//    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);


  }

  */

  void setNewPriceforSauceItemCheeseItemIngredientUpdate(/*List<SauceItem> sauceItems*/) {

//    _allSelectedCheeseItems = cheeseItems.where((element) =>
//    (element.isSelected==true && element.isDefaultSelected!=true)).toList();


    List<SauceItem> onlyNewSelectedSauceItems = _allSelectedDeletedSauceItems.where((element) =>((element.isSelected==true)
        && (element.isDefaultSelected!=true))).toList();

    List<CheeseItem> onlyNewSelectedCheeseItems = _allSelectedDeletedCheeseItems.where((element) =>((element.isSelected==true)
        && (element.isDefaultSelected!=true))).toList();

    List<NewIngredient> onlyNewSelectedIngredients = _defaultIngItems.where(
            (element) =>((element.isDefault == false))).toList();

    logger.i('_defaultIngItems: $_defaultIngItems');



    _defaultIngItems.forEach((oneIng) {


      print('element.isDefault ingredient check:::: ${oneIng.isDefault}');
      print('oneIng.name: ${oneIng.ingredientName}');
      print('oneIng.price: ${oneIng.price}');


    }
    );



    logger.i('onlyNewSelectedIngredients: $onlyNewSelectedIngredients');



    double addedSauceItemsPrice = onlyNewSelectedSauceItems.fold(0, (t, e) => t + e.price);
    double addedCheeseItemsPrice = onlyNewSelectedCheeseItems.fold(0, (t, e) => t + e.price);
    double addedIngredientsItemsPrice = onlyNewSelectedIngredients.fold(0, (t, e) => t + e.price);

    print('addedSauceItemsPrice : $addedSauceItemsPrice');
    print('addedCheeseItemsPrice : $addedCheeseItemsPrice');
    print('addedIngredientsItemsPrice : $addedIngredientsItemsPrice');

    logger.e('addedIngredientsItemsPrice : $addedIngredientsItemsPrice');


    FoodItemWithDocIDViewModel thisFoodpriceModified = _thisFoodItem;

//    double previousPrice = _thisFoodItem.priceBasedOnCheeseSauceIngredientsSize;
    double previousPrice = _thisFoodItem.itemPriceBasedOnSize;

    print('previous  price: $previousPrice');

//    thisFoodpriceModified.itemPrice

    thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize = previousPrice + addedSauceItemsPrice
        + addedCheeseItemsPrice + addedIngredientsItemsPrice;

    print('modified price for new SauceItem cheeseItem addition or remove: '
        '${thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize}');

//    print('changedPriceDouble: $changedPriceDouble');

    _thisFoodItem =thisFoodpriceModified;

    _controller.sink.add(thisFoodpriceModified);




    print( '>>>> initialItemCount == 0  <<<< ');


    SelectedFood tempSelectedFood = _currentSelectedFoodDetails ;

    // REQUIRED ...
    tempSelectedFood.selectedIngredients  = _defaultIngItems;
    tempSelectedFood.selectedCheeseItems  = _allSelectedDeletedCheeseItems;
    tempSelectedFood.selectedSauceItems   = _allSelectedDeletedSauceItems;
    tempSelectedFood.unitPrice            = thisFoodpriceModified.priceBasedOnCheeseSauceIngredientsSize;
    tempSelectedFood.unitPriceWithoutCheeseIngredientSauces = thisFoodpriceModified.itemPriceBasedOnSize;

    _currentSelectedFoodDetails = tempSelectedFood;

    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);

  }


  // HELPER METHOD tryCast Number (1)
  double tryCast<num>(dynamic x, {num fallback }) {

    print(" at tryCast");
    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}

    else return 0.0;
  }

  // HELPER METHOD  dynamicListFilteredToStringList Number (2)

  List<String> dynamicListFilteredToStringList(List<dynamic> dlist) {

    List<String> stringList = List<String>.from(dlist);

    logger.i('stringList.length: ${stringList.length}');


    return stringList;
    /*
    return stringList.where((oneItem) =>oneItem.toString().toLowerCase()
        ==
        isIngredientExist(oneItem.toString().trim().toLowerCase())).toList();

    */

  }

  // HELPER METHOD  isIngredientExist ==> NUMBER 3


  /*

  String isIngredientExist(String inputString) {
    List<String> allIngredients = [
      'ananas',
      'aurajuusto',
      'aurinklkuivattu_tomaatti',
      'cheddar',
      'emmental_laktoositon',
      'fetajuusto',
      'herkkusieni',
      'jalapeno',
      'jauheliha',
      'juusto',
      'kana',
      'kanakebab',
      'kananmuna',
      'kapris',
      'katkarapu',
      'kebab',
      'kinkku',
      'mieto_jalapeno',
      'mozzarella',
      'oliivi',
      'paprika',
      'pekoni',
      'pepperoni',
      'persikka',
      'punasipuli',
      'rucola',
      'salaatti',
      'salami',
      'savujuusto_hyla',
      'simpukka',
      'sipuli',
      'suolakurkku',
      'taco_jauheliha',
      'tomaatti',
      'tonnikala',
      'tuore_chili',
      'tuplajuusto',
      'vuohejuusto'
    ];

// String s= allIngredients.where((oneItem) =>oneItem.toLowerCase().contains(inputString.toLowerCase())).toString();
//
// print('s , $s');

//firstWhere(bool test(E element), {E orElse()}) {
    String elementExists = allIngredients.firstWhere(
            (oneItem) => oneItem.toLowerCase() == inputString.toLowerCase(),
        orElse: () => '');

    print('elementExists: $elementExists');

    return elementExists;

//allIngredients.every(test(t)) {
//contains(
//    searchString2.toLowerCase())).toList();
  }


  */


  // helper method 04 filterSelectedDefaultIngredients
  filterSelectedDefaultIngredients(List<NewIngredient> allIngList , List<String> listStringIngredients2) {
// foox

    logger.w("at filterSelectedDefaultIngredients  ...... >>> >>>> >>> > >> ");



//    print("allIngList: $allIngList");

    print("listStringIngredients2: $listStringIngredients2");

    print('allIngList.length: ${allIngList.length}');

//    allIngList.map((oneElement)=> print('oneElement.ingredientName:'
//        ' ${oneElement.ingredientName}'));


//    var mappedFruits2 = allIngList.map((oneElement)=> '${oneElement.ingredientName==''}').toList();
//    print('mappedFruits2.length: ${mappedFruits2.length}');


//    var mappedFruits = allIngList.map((oneElement)=> '${oneElement.ingredientName}').toList();
//
//    print('mappedFruits: $mappedFruits');
//    print('mappedFruits: ${mappedFruits.length}');



    List<NewIngredient> default2 =[];

//    List<NewIngredient> y = [];
    NewIngredient toBeDeleted= NewIngredient(
        ingredientName: 'None',
        imageURL: 'None',

        price: 0.001,
        documentId: 'None',
        ingredientAmountByUser: -1000

    );

    listStringIngredients2.forEach((stringIngredient) {



      NewIngredient elementExists = allIngList.firstWhere(
              (oneItem) => oneItem.ingredientName.trim().toLowerCase() == stringIngredient.trim().toLowerCase(),
          orElse: () => toBeDeleted);








//      print('elementExists: $elementExists');




//      print('elementExists: $elementExists');
      // WITHOUT THE ABOVE PRINT STATEMENT SOME TIMES THE APPLICATION CRUSHES.

      if(elementExists.ingredientName!='None') {
        default2.add(elementExists);
      }

    });

    print('default2.length: ${default2.length}');

    default2.map((oneIngredient) =>
    /*NewIngredient.updateSelectedIngredient */(
        oneIngredient.isDefault= true
    )).toList();


    default2.forEach((oneIng) {


      print('NewIngredient.updateSelectedIngredient check:::: oneIng.isDefault ${oneIng.isDefault}');
      print('oneIng.name: ${oneIng.ingredientName}');
      print('oneIng.price: ${oneIng.price}');


    }
    );


    _defaultIngItems = default2;
    _defaultIngredientListController.sink.add(default2);

  }



  List<CheeseItem> filterSelectedJuustoOrCheeses (
      List <CheeseItem> /* List<NewIngredient> */ allCheeses , List<String> defaultCheeseORJuusoItems
      ) {

//    List <CheeseItem> allUnSelected;



    List <CheeseItem> allCheeseItemsDefaultIncluded = allCheeses.map(
            (oneItem) =>
            checkThisCheeseItemInDefatultStringCheeseItems(
                oneItem,defaultCheeseORJuusoItems)).toList();

    return allCheeseItemsDefaultIncluded;

  }


  List<SauceItem> filterSelectedKastikesSauces (
      List <SauceItem> /* List<NewIngredient> */ allSauces , List<String> defaultSauceORKastikeItems
      ) {

    List <SauceItem> allUnSelected;


    List <SauceItem> allSauceItemsDefaultIncluded = allSauces.map(
            (oneItem) =>
            checkThisSauceItemInDefatultStringSauceItems(
                oneItem,defaultSauceORKastikeItems)
    ).toList();

    return allSauceItemsDefaultIncluded;

  }



  // #### helper method 05 filterUnSelectedIngredients
  //
  filterUnSelectedIngredients (
      List<NewIngredient> allIngList , List<String> listStringIngredients2
      ) {
// foox

//    logger.w("at filterUnSelectedIngredients ","filterUnSelectedIngredients");

//    print("at allIngList ${allIngList.length}");

//    print("allIngList: $allIngList");

//    print("listStringIngredients2: ${listStringIngredients2.length}");

    List <NewIngredient> allUnSelected;

//    Set<NewIngredient> elementUNSelected = new Set<NewIngredient>();
//    listStringIngredients2.forEach((stringIngredient) {
//
//      print('ingredient in foreach loop $stringIngredient');

    List<NewIngredient> unSelectedIngredientsFiltered = allIngList.where(
            (oneItem) => oneItem.ingredientName.trim().toLowerCase() !=
            checkThisIngredientInDefatultStringIngredient(
                oneItem,listStringIngredients2
            )
    ).toList();
//      print('elementUNSelected: $elementUNSelected');


    List<NewIngredient> unSelectedDecremented =
    unSelectedIngredientsFiltered.map((oneIngredient)=>
        NewIngredient.updateUnselectedIngredient(
            oneIngredient
        )).toList();

//    print('unSelectedIngredientsFiltered ===>  ${unSelectedDecremented.length}');


//      Set<NewIngredient> unSelectedIngredientsFilteredSet = unSelectedIngredientsFiltered.toSet();
//
//      elementUNSelected.addAll(unSelectedIngredientsFilteredSet);





//        print('unSelectedIngredientsFiltered: $unSelectedIngredientsFiltered');
//        elementUNSelected =  unSelectedIngredientsFiltered;

//


//    List<NewIngredient> convertSetToList = elementUNSelected.toList();

    _unSelectedIngItems = unSelectedDecremented;
//    _defaultIngredientListController.sink.add(default2);
    _unSelectedIngredientListController.sink.add(unSelectedDecremented);

//    return allUnSelected;

//    logger.i('allUnSelected: ',unSelectedDecremented);

  }

  // HELPER METHOD 08 checkThisIngredientInDefatultStringIngredient

  CheeseItem checkThisCheeseItemInDefatultStringCheeseItems(CheeseItem x, List<String> defaultCheeseJuustoItemString) {

//    print('ingredientsString: $ingredientsString');
//    print('.ingredientName.toLowerCase().trim(): ${x.ingredientName.toLowerCase().trim()}');

//    List<String> foodIngredients =ingredientsString;

//    logger.w('onlyIngredientsNames2',onlyIngredientsNames2);

    print('x.cheeseItemName == >   == >   == > : ${x.cheeseItemName}');

    String cheeseItemNameExists = defaultCheeseJuustoItemString.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == x.cheeseItemName.toLowerCase().trim(),
        orElse: () => '');

    if(cheeseItemNameExists!=''){

      print('cheeseItemNameExists   ');
      x.isDefaultSelected=true;
      return x;
    }
    print('cheeseItem dosn\'t exist.....');

//    print('elementExists: Line # 612:  $elementExists');

    return x;
  }

  // HELPER METHOD 07 checkThisIngredientInDefatultStringIngredient

  SauceItem checkThisSauceItemInDefatultStringSauceItems(SauceItem x,
      List<String> defaultSauceKastikeItemString) {

    /*
    logger.i('x.sauceItemName => ${x.sauceItemName} defaultSauceKastikeItemString[0] => '
        '${defaultSauceKastikeItemString[0]} ');

    */



    String elementExists = defaultSauceKastikeItemString.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == x.sauceItemName.toLowerCase().trim(),
        orElse: () => '');

    if(elementExists!=''){


      x.isDefaultSelected=true;

      print('elementExists!='' &&  x.sauceItemName  => ${x.sauceItemName}');
      return x;
    }

//    print('elementExists: Line # 612:  $elementExists');

    return x;
  }


  // HELPER METHOD 06 checkThisIngredientInDefatultStringIngredient

  String checkThisIngredientInDefatultStringIngredient(NewIngredient x, List<String> ingredientsString) {

//    print('ingredientsString: $ingredientsString');
//    print('.ingredientName.toLowerCase().trim(): ${x.ingredientName.toLowerCase().trim()}');

//    List<String> foodIngredients =ingredientsString;

//    logger.w('onlyIngredientsNames2',onlyIngredientsNames2);


    String elementExists = ingredientsString.firstWhere(
            (oneItem) => oneItem.toLowerCase().trim() == x.ingredientName.toLowerCase().trim(),
        orElse: () => '');

//    print('elementExists: Line # 612:  $elementExists');

    return elementExists.toLowerCase();

  }

  void clearSubscription(){

    print('calling clear Subscription method.... for /in food Details bloc ');


//    _curretnOrder=null;
//    _expandedSelectedFood =[];
//    _orderType =[];
//    _paymentType =[];


//    _orderController.sink.add(_curretnOrder);
//    _expandedSelectedFoodController.sink.add(_expandedSelectedFood);
//    _orderTypeController.sink.add(_orderType);
//    _paymentTypeController.sink.add(_paymentType);


    _thisFoodItem = null;
    _currentSelectedFoodDetails = null;
    _allIngItemsDetailsBlock = [];
    _defaultIngItems = [];
    _unSelectedIngItems = [];
    _multiSelectForFood = [];

    _allSauceItemsDBloc = [];
    _allCheeseItemsDBlocDefaultInculdedDeletedIncluded = [];

    print('_allSelectedCheeseItems = [];');
    print('_allSelectedSauceItems = [];');

    _allSelectedDeletedCheeseItems = [];
    _allSelectedDeletedSauceItems = [];
    _allSubgroups=[];


    _controller.sink.add(_thisFoodItem);
    _selectedFoodControllerFoodDetails.sink.add(_currentSelectedFoodDetails);
    _allIngredientListController.sink.add(_allIngItemsDetailsBlock);
    _defaultIngredientListController.sink.add(_defaultIngItems);
    _unSelectedIngredientListController.sink.add(_unSelectedIngItems);
    _multiSelectForFoodController.sink.add(_multiSelectForFood);

    _sauceItemsController.sink.add(_allSauceItemsDBloc);
    _cheeseItemsController.sink.add(_allCheeseItemsDBlocDefaultInculdedDeletedIncluded);

    _selectedCheeseListController.sink.add(_allSelectedDeletedCheeseItems);
    _selectedSauceListController.sink.add(_allSelectedDeletedSauceItems);
    _categoryWiseSubGroupsController.sink.add(_allSubgroups);

  }





  @override
  void dispose() {

    _controller.close();
    _selectedFoodControllerFoodDetails.close();
    _allIngredientListController.close();
    _defaultIngredientListController.close();
    _unSelectedIngredientListController.close();
    _multiSelectForFoodController.close();
    _sauceItemsController.close();
    _cheeseItemsController.close();

    _selectedSauceListController.close();
    _selectedCheeseListController.close();
    _categoryWiseSubGroupsController.close();
  }
}
