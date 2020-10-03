import 'package:image_picker/image_picker.dart';
import 'package:linkupadminolddb/src/BLoC/bloc.dart';
import 'package:linkupadminolddb/src/DataLayer/api/firebase_clientAdmin.dart';

import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';


// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';
import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';



import 'package:firebase_storage/firebase_storage.dart';

//MODELS

import 'package:linkupadminolddb/src/DataLayer/models/FoodItemWithDocID.dart';

import 'package:linkupadminolddb/src/DataLayer/models/OldCategoryItem.dart';
import 'package:mime_type/mime_type.dart';



//import 'dart:async';
//import 'dart:io';
//
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AdminFirebaseFoodBloc implements Bloc {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  bool _isDisposedIngredients = false;

  bool _isDisposedFoodItems = false;

  bool _isDisposedCategories = false;

  bool _isDisposed_known_last_sequenceNumber = false;
  bool _isDisposedExtraIngredients = false;


  List<OldCategoryItem> _categoryTypesForDropDown;
  List<OldCategoryItem> get getCategoryTypesForDropDown =>
      _categoryTypesForDropDown;

  final _categoryDropDownController =
  StreamController<List<OldCategoryItem>>.broadcast();

  Stream<List<OldCategoryItem>> get getCategoryDropDownControllerStream =>
      _categoryDropDownController.stream;

  // File _image2;

  PickedFile _image2;


  String _firebaseUserEmail;

//  String categoryName = 'PIZZA'.toLowerCase();
//  String shortCategoryName;

  bool isHot = true;
//  String priceInEuro = '';

//  String imageURL = '';
  bool isAvailable = true;

  int sequenceNo = 0;
// main foodItem bloc component starts here...


  // main bloc component for uploading one foode item begins here..


  FoodItemWithDocID _thisFoodItem = new FoodItemWithDocID(
    isHot: true,
  );
  FoodItemWithDocID get getCurrentFoodItem => _thisFoodItem;
  final _foodItemController = StreamController<FoodItemWithDocID>();
  Stream<FoodItemWithDocID> get thisFoodItemStream =>
      _foodItemController.stream;


  // ends here.


  List<NewIngredient> _allExtraIngredients =[];

  List<NewIngredient> get getAllExtraIngredients => _allExtraIngredients;
  Stream<List<NewIngredient>> get getExtraIngredientItemsStream => _allExtraIngredientItemsController.stream;
  final _allExtraIngredientItemsController = StreamController <List<NewIngredient>>.broadcast();


  // cheese items
  List<OldCategoryItem> _allOLDCategories =[];
  List<OldCategoryItem> get getAllOLDCategorisAdminFoodUpload => _allOLDCategories;
  final _oldCategoriesControllerFoodUploadAdmin      =  StreamController <List<OldCategoryItem>>.broadcast();
  Stream<List<OldCategoryItem>> get getOldCategoriesStream => _oldCategoriesControllerFoodUploadAdmin.stream;


  final FirebaseStorage storage =
  FirebaseStorage(storageBucket: 'gs://linkupadminolddbandclientapp.appspot.com');
  // gs://linkupadminolddbandclientapp.appspot.com
  // gs://kebabbank-37224.appspot.com

  String itemId;

  String uploadedBy = '';

  bool newsletter = false;

  void setImage(PickedFile localURL) {
    print('localURL : $localURL');
    _image2 = localURL;
  }

  void setCategoryValueFoodItemUPload(int index) {
    print('< > < > ZZZ  setting category food upload---------- [index]: $index');

    String categoryName =
    _categoryTypesForDropDown[index].categoryName.toLowerCase();

    String shortCategoryName =
    _categoryTypesForDropDown[index].fireStoreFieldName.toLowerCase();

    _thisFoodItem.categoryIndex= index;

    _thisFoodItem.categoryName = categoryName;
    _thisFoodItem.shorCategoryName = shortCategoryName;

    print('categoryName: $categoryName');
    print('shortCategoryName: $shortCategoryName');

    _foodItemController.sink.add(_thisFoodItem);
  }

  void setUser(var param) {
    _firebaseUserEmail = param;
  }

  void setIsHot(bool param) {
    FoodItemWithDocID temp = new FoodItemWithDocID();
    temp = _thisFoodItem;
    temp.isHot = param;
    _thisFoodItem = temp;
    _foodItemController.sink.add(_thisFoodItem);
  }

  void setIsAvailable(var param) {
    FoodItemWithDocID temp = new FoodItemWithDocID();
    temp = _thisFoodItem;
    temp.isAvailable = param;

    _thisFoodItem = temp;

    _foodItemController.sink.add(_thisFoodItem);
  }

  void setItemName(var foodItemName) {
//    _thisFoodItem
//    FoodItemWithDocID
    FoodItemWithDocID temp = new FoodItemWithDocID();
    temp = _thisFoodItem;
    temp.itemName = foodItemName;
    temp.shorItemName= shortendCase(foodItemName);
    // shortendCase(ingredientName);

    _thisFoodItem = temp;

    _foodItemController.sink.add(_thisFoodItem);

//    _firebaseUserEmail = param;
  }

  Future<String> generateItemId(int length) async {
    String _result = "";
    int i = 0;
    String _allowedChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);

      _result += _allowedChars[randomInt];

      i++;
    }

    return _result;
  }

  String titleCase(var text) {
    // print("text: $text");
    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');
    }
  }

  String shortendCase(var text) {


    print("text: $text");
    if (text is num) {
      return text.toString();
    } else if (text == null) {
      return '';
    } else if (text.length <= 1) {
      return text.toUpperCase();
    } else {
      return text
          .split(' ')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join('_');
    }
  }



  Future<String> _uploadFile(String itemId, itemName,String categoryName2) async {
    print('at _uploadFile: ');

    final String uuid = Uuid().v1();

    print('itemId: $itemId');
    StorageReference storageReference_1 = storage
        .ref()
        .child('foodItems2')
        .child(categoryName2)
        .child(itemName + itemId + '.png');

    print('_image2: $_image2');


    File x = File(_image2.path);

    String mimeType = mime(_image2.path);
    logger.i('mimeType................... $mimeType');

    if (mimeType == null) mimeType = 'text/plain; charset=UTF-8';


    StorageUploadTask uploadTask = storageReference_1.putFile(
      // _image2,
      File(_image2.path),
      StorageMetadata(
          contentType: mimeType,
          cacheControl: 'no-store', // disable caching
          customMetadata: {
            'itemName': itemName,
//            print('itemName: ${_thisFoodItem.itemName}');
          }),
    );

    if (uploadTask.isCanceled == true) {
      return "error";
    }

    await uploadTask.onComplete;

    String urlString =
    await storageReference_1.getDownloadURL().then((onValue) {
      print('onValue: $onValue');
//      print('t: $t');
      print('File Uploaded');
      return onValue;
    });

    print('am i printed :   ????????????????????');

    var uri = Uri.parse(urlString);
    // print(uri.isScheme("HTTP"));  // Prints true.

    if (uri.isScheme("HTTP") || (uri.isScheme("HTTPS"))) {
      print('on of them is true');
    } else {
      print('storage server error: ');
      print("try VPN ___________________________________________");

      logger.v("Verbose log");

      logger.d("Debug log");

      logger.i("Info log");

      logger.w("Warning log");

      logger.e("Error log");
      // return 0;
    }

    return urlString;
  }

  void getLastSequenceNumberFromFireBaseFoodItemsOld() async {
    print('at get Last SequenceNumberFromFireBaseFoodItems()');

//    if (_isDisposed_known_last_sequenceNumber == false) {
    int lastIndex =
    await _clientAdmin.getLastSequenceNumberFromFireBaseFoodItems();

    logger.i('lastIndex: $lastIndex');

    _thisFoodItem.sequenceNo = lastIndex +1;

    _foodItemController.sink.add(_thisFoodItem);

//      _isDisposed_known_last_sequenceNumber = true;
//    }
  }

  Future<int> saveFoodItem() async {







    itemId = await generateItemId(6);

    print('itemId: $itemId');

    String imageURL;
    if(_thisFoodItem.categoryIndex==null){
      _thisFoodItem.categoryIndex=0;
      _thisFoodItem.shorCategoryName = _categoryTypesForDropDown[0].fireStoreFieldName;
      _thisFoodItem.categoryName = _categoryTypesForDropDown[0].categoryName;
    }

    if (_image2 != null) {
      imageURL = await _uploadFile(itemId, _thisFoodItem.shorItemName,_thisFoodItem.shorCategoryName);
    } else {
      print('_image2= $_image2');

      String dummyImage =
          'https://firebasestorage.googleapis.com/v0/b/linkupadminolddbandclientapp.appspot.com/o/404%2FfoodItem404.jpg?alt=media';

      imageURL = Uri.decodeComponent(dummyImage
          .replaceAll(
          'https://firebasestorage.googleapis.com/v0/b/linkupadminolddbandclientapp.appspot.com/o/',
          '')
          .replaceAll('?alt=media', ''));
    }

    print(
        'imageURL after stripping url for empty image or full image: $imageURL');

    print('itemId: $itemId');
    print('itemName: ${_thisFoodItem.itemName}');


    print('isHot: $isHot');
    print('isAvailable: $isAvailable');

    print('_image2: $_image2');

    print('saving user using a web service');

    _thisFoodItem.itemName = titleCase(_thisFoodItem.itemName);


    _thisFoodItem.itemId = itemId;

    String documentID = await _clientAdmin.insertFoodItems(
        _thisFoodItem, _thisFoodItem.sequenceNo, _firebaseUserEmail, imageURL);

    print('added document: $documentID');


    clearSubscription(_thisFoodItem);



    return (1);
  }


  void clearSubscription(FoodItemWithDocID w) {

   w.shorCategoryName='';
   w.itemName='';
   w.shorItemName='';

    FoodItemWithDocID x = w;
    x.sequenceNo = x.sequenceNo+1;
    _thisFoodItem = x;
    _foodItemController.sink.add(_thisFoodItem);
  }


  final _clientAdmin = FirebaseClientAdmin();



  void initiateCategoryDropDownList() {
    logger.i('at initiateCategoryDropDownList()');

    OldCategoryItem pizza = new OldCategoryItem(
      categoryName: 'pizza',
      sequenceNo: 0,
      documentID: 'pizza',
      fireStoreFieldName: 'pizza',
    );

    OldCategoryItem kebab = new OldCategoryItem(
      categoryName: 'kebab',
      sequenceNo: 1,
      documentID: 'kebab',
      fireStoreFieldName: 'pizza',
    );

    OldCategoryItem jauheliha_kebab_vartaat = new OldCategoryItem(
      categoryName: 'jauheliha kebab & vartaat',
      sequenceNo: 2,
      documentID: 'jauheliha_kebab_vartaat',
      fireStoreFieldName: 'jauheliha_kebab_vartaat',
    );

    OldCategoryItem salaatti_kasvis = new OldCategoryItem(
      categoryName: 'salaatti & kasvis',
      sequenceNo: 3,
      documentID: 'salaatti_kasvis',
      fireStoreFieldName: 'salaatti_kasvis',
    );

    OldCategoryItem hampurilainen = new OldCategoryItem(
      categoryName: 'hampurilainen',
      sequenceNo: 4,
      documentID: 'hampurilainen',
      fireStoreFieldName: 'hampurilainen',
    );

    OldCategoryItem lasten_menu = new OldCategoryItem(
      categoryName: 'lasten menu',
      sequenceNo: 5,
      documentID: 'lasten_menu',
      fireStoreFieldName: 'lasten_menu',
    );

    // drinks, no cheese and ingredients required...
    OldCategoryItem juomat = new OldCategoryItem(
      categoryName: 'juomat',
      sequenceNo: 6,
      documentID: 'juomat',
      fireStoreFieldName: 'juomat',
    );

    OldCategoryItem grill = new OldCategoryItem(
      categoryName: 'grill',
      sequenceNo: 7,
      documentID: 'grill',
      fireStoreFieldName: 'grill',
    );



    List<OldCategoryItem> categoryItems2 = new List<OldCategoryItem>();

    categoryItems2.addAll([
      pizza,
      kebab,
      jauheliha_kebab_vartaat,
      salaatti_kasvis,
      hampurilainen,
      lasten_menu,
      juomat,
      grill
    ]);

    _categoryTypesForDropDown = categoryItems2;
    _categoryDropDownController.sink.add(_categoryTypesForDropDown);
  }
  // CONSTRUCTOR BIGINS HERE..



  // this code bloc cut paste from foodGallery Bloc:
  Future<void> getOldIngredientsAdminConstructor() async {

    print('at getAllExtraIngredientsConstructor()');

    if (_isDisposedExtraIngredients == false) {

      var snapshot = await _clientAdmin.fetchAllOldIngredientsAdmin();
      List docList = snapshot.docs;

      List <NewIngredient> ingItems = new List<NewIngredient>();

      ingItems = snapshot.docs.map((documentSnapshot) =>
          NewIngredient.ingredientConvertExtra
            (documentSnapshot.data(), documentSnapshot.id)
      ).toList();


      List<String> documents = snapshot.docs.map((documentSnapshot) =>
      documentSnapshot.id).toList();



      List<NewIngredient> ingredientImageURLUpdated = new List<NewIngredient>();


      for(int i= 0 ;i<ingItems.length; i++){

        String fileName2  = ingItems[i].imageURL;

        NewIngredient tempIngredient =ingItems[i];
        print('fileName2 =============> : $fileName2');

        StorageReference storageReferenceForIngredientImage = storage
            .ref()
            .child(fileName2);

        String newimageURL = await storageReferenceForIngredientImage.getDownloadURL();

        tempIngredient.imageURL= newimageURL;

        ingredientImageURLUpdated.add(tempIngredient);

      };

      logger.i('ingredientImageURLUpdated.length ${ingredientImageURLUpdated.length}');


      ingredientImageURLUpdated.forEach((oneIngItem)  {

        print('oneIngItem.imageURL => => => :  ${oneIngItem.imageURL}');

      });



      _allExtraIngredients = ingredientImageURLUpdated;

      _allExtraIngredientItemsController.sink.add(_allExtraIngredients);

      _isDisposedExtraIngredients=true;

    }
    else {
      return;
    }
  }


  Future<void> _downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();
  }




  void toggoleMultiSelectIngredientValue(int index) {


    _allExtraIngredients[index].isDefault =
    !_allExtraIngredients[index].isDefault;

    _allExtraIngredientItemsController.sink.add(_allExtraIngredients);

    List<String> selectedIngredients2 = new List<String>();


    _allExtraIngredients.forEach((newIngred) {



      if(newIngred.isDefault){
        selectedIngredients2.add(newIngred.ingredientName);
      }
    });

    print('selectedIngredients2.length: ${selectedIngredients2.length}');


    FoodItemWithDocID temp = _thisFoodItem;

    temp.ingredients = selectedIngredients2;

    _thisFoodItem = temp;
    _foodItemController.sink.add(_thisFoodItem);


  }

  void setCategoryValue(int index) {


    _allOLDCategories.forEach((oneOldCategory) {
      oneOldCategory.isSelected=false;
    });



    _allOLDCategories[index].isSelected =
    !_allOLDCategories[index].isSelected;

    print('_ingredientGroupes.length: ${_allOLDCategories.length}');

    _oldCategoriesControllerFoodUploadAdmin.sink.add(_allOLDCategories);




  }







  Future<void> getDownloadURL() async{

    StorageReference storageReference_2 = storage
        .ref()
        .child('404')
        .child('foodItem404.jpg');

    String x;
    try {
      x = await storageReference_2.getDownloadURL();
    } catch (e) {

      print('e         _____ -----: $e');

//        print('ip error, please check internet');
//        return devices;
    }


    print('x         _____ -----: $x');

    String token = x.substring(x.indexOf('?'));

//      print('........download url: $x');
    _thisFoodItem.urlAndTokenForStorageImage=token;
    _foodItemController.sink.add(_thisFoodItem);

//    return x.substring(x.indexOf('?'));
//    return x;
  }
  AdminFirebaseFoodBloc() {


//    setCategoryValueFoodItemUPload(0);
    print('at AdminFirebaseFoodBloc ......()');

    getLastSequenceNumberFromFireBaseFoodItemsOld();




    getOldIngredientsAdminConstructor();

    // getAllKastikeSaucesAdminConstructor();

    // getAllOldCategoriesAdminConstructor();



    initiateCategoryDropDownList();

    print('at AdminFirebaseFoodBloc()');
  }

  // CONSTRUCTOR ENDS HERE..

  // 4
  @override
  void dispose() {
    _foodItemController.close();
    _categoryDropDownController.close();

    _allExtraIngredientItemsController.close();
    // _sauceItemsControllerFoodUploadAdmin.close();
    _oldCategoriesControllerFoodUploadAdmin.close();



  }
}
