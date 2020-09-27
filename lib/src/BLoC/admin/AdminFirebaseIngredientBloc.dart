import 'package:linkupadminolddb/src/BLoC/bloc.dart';
import 'package:linkupadminolddb/src/DataLayer/api/firebase_clientAdmin.dart';
import 'package:linkupadminolddb/src/DataLayer/models/IngredientSubgroup.dart';
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
import 'package:linkupadminolddb/src/DataLayer/models/NewCategoryItem.dart';


class AdminFirebaseIngredientBloc implements Bloc {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  bool _isDisposedIngredients = false;

  bool _isDisposedFoodItems = false;

  bool _isDisposedCategories = false;

  bool _isDisposed_known_last_sequenceNumber = false;

  List<NewCategoryItem> _foodCategoryTypesForMultiSelect;
  List<NewCategoryItem> get getCategoryTypesForDropDown =>
      _foodCategoryTypesForMultiSelect;
  final _categoryMultiSelectController =
  StreamController<List<NewCategoryItem>>.broadcast();

  Stream<List<NewCategoryItem>> get getCategoryMultiSelectControllerStream =>
      _categoryMultiSelectController.stream;


  // multiselect category controller codes begins here ......

  List<IngredientSubgroup> _ingredientGroupes;
  List<IngredientSubgroup> get getIngredientTypes => _ingredientGroupes;
  final _ingredientsGroupsController =
  StreamController<List<IngredientSubgroup>>.broadcast();
  Stream<List<IngredientSubgroup>> get getIngredientGroupsControllerStream =>
      _ingredientsGroupsController.stream;

  // multiselect category controller codes ends here .....


  File _image2;
  String _firebaseUserEmail;



  String categoryName = 'PIZZA'.toLowerCase();
  String shortCategoryName;

  bool isHot = true;
  String priceInEuro = '';

  String imageURL = '';
  bool isAvailable = true;

  int sequenceNo = 0;


// main ingredient bloc component starts here...
  NewIngredient _thisIngredientItem = new NewIngredient();
  NewIngredient get getCurrentIngredientItem => _thisIngredientItem;
  final _ingredientItemController = StreamController<NewIngredient>();
  Stream<NewIngredient> get thisIngredientItemStream =>
      _ingredientItemController.stream;
// main foodItem bloc component ends here...
  final FirebaseStorage storage =
  FirebaseStorage(storageBucket: 'gs://kebabbank-37224.appspot.com');

  String itemId;

  String uploadedBy = '';

  bool newsletter = false;

  void setImage(File localURL) {
    print('localURL : $localURL');

    _image2 = localURL;
  }

  void setUser(var param) {
    _firebaseUserEmail = param;
  }

  void setPrice(String priceText) {
//    double minutes2 = double.parse(minutes);
    double price = double.parse(priceText);
    NewIngredient temp = new NewIngredient();
    temp = _thisIngredientItem;
    temp.price = price;

    _thisIngredientItem = temp;

    _ingredientItemController.sink.add(_thisIngredientItem);
  }

  void setItemName(var param) {

    logger.w('ingredient Name: $param');

    NewIngredient temp = new NewIngredient();
    temp = _thisIngredientItem;
    temp.ingredientName = param;

    _thisIngredientItem = temp;

    _ingredientItemController.sink.add(_thisIngredientItem);


  }

  Future<String> generateItemId(int length) async {
    String _result = "";
    int i = 0;
    String _allowedChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    while (i < length.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);

      _result += _allowedChars[randomInt];

      i++;
    }

    return _result;
  }

  String titleCase(var text) {


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
          .join(' ');
    }
  }

  void toggoleMultiSelectCategoryValue(int index) {
    _foodCategoryTypesForMultiSelect[index].isSelected =
    !_foodCategoryTypesForMultiSelect[index].isSelected;

    _categoryMultiSelectController.sink.add(_foodCategoryTypesForMultiSelect);

    List<String> extraIngredientOf2 = new List<String>();
    _foodCategoryTypesForMultiSelect.forEach((newCategoryItem) {




      if(newCategoryItem.isSelected){
        extraIngredientOf2.add(newCategoryItem.categoryName);
      }
    });

    print('extraIngredientOf2.length: ${extraIngredientOf2.length}');


   NewIngredient temp = _thisIngredientItem;

   temp.extraIngredientOf = extraIngredientOf2;

    _thisIngredientItem = temp;
    _ingredientItemController.sink.add(_thisIngredientItem);


  }

  void toggoleMultiSelectSubgroupValue(int index) {


    _ingredientGroupes.forEach((oneIngredientGroupe) {
      oneIngredientGroupe.isSelected=false;
    });



    _ingredientGroupes[index].isSelected =
    !_ingredientGroupes[index].isSelected;

    print('_ingredientGroupes.length: ${_ingredientGroupes.length}');

    _ingredientsGroupsController.sink.add(_ingredientGroupes);


    print('_thisIngredientItem: $_thisIngredientItem');

    NewIngredient xTemp = _thisIngredientItem;

    print('_ingredientGroupes[index].ingredientSubgroupName: ${_ingredientGroupes[index].ingredientSubgroupName}');


    print('xTemp: $xTemp');




    xTemp.subgroup = _ingredientGroupes[index].ingredientSubgroupName;
    print('xTemp.subgroup: ${xTemp.subgroup}');

    _thisIngredientItem = xTemp;
    _ingredientItemController.sink.add(_thisIngredientItem);

  }

  Future<String> _uploadFile(String itemId, itemName) async {
    print('at _uploadFile: ');

    print('itemId: $itemId');
    StorageReference storageReference_1 = storage
        .ref()
        .child('extraIngredients')
        .child(itemName +'__'+itemId + '.png');

    print('_image2: $_image2');

    StorageUploadTask uploadTask = storageReference_1.putFile(
      _image2,
      StorageMetadata(
          contentType: 'image/jpg',
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

    // return urlString;



  }

  void getLastSequenceNumberForAdminIngredient() async {
    print('at get Last SequenceNumberFromFireBaseFoodItems()');

//    if (_isDisposed_known_last_sequenceNumber == false) {
    int lastIndex =
    await _clientAdmin.getLastSequenceNumberForAdminIngredient2();

    logger.i('lastIndex: $lastIndex');

    _thisIngredientItem.sequenceNo = lastIndex +1;

    _ingredientItemController.sink.add(_thisIngredientItem);


//    }
  }

  Future<int> saveIngredientItem() async {
    //  save() {

//    pizza

//    kebab
//
//    jauheliha_kebab_vartaat
//
//    salaatti_kasvis
//
//    lasten_menu
//
//    juomat

    if((_thisIngredientItem.extraIngredientOf==null) ||(_thisIngredientItem.extraIngredientOf.length==0)){
      return 4;
    }

    else if((_thisIngredientItem.subgroup==null) || (_thisIngredientItem.subgroup.length==0)){
      return 5;
    }
    else {
      logger.i('at save ...');


      itemId = await generateItemId(6);
      //imageURL = await _uploadFile(itemId, _thisIngredientItem.ingredientName);

      String imageURL;

      if (_image2 != null) {
        imageURL =
        await _uploadFile(itemId, _thisIngredientItem.ingredientName);
      } else {
        print('_image2= $_image2');

        String dummyIngredientImage =
            'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/404%2Fingredient404.jpg';

        imageURL = Uri.decodeComponent(dummyIngredientImage
            .replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/',
            '')
            .replaceAll('?alt=media', ''));
      }

      print(
          'imageURL after stripping url for empty image or full image: $imageURL');

      print('itemId:____ $itemId');

      print('saving user using a web service');

      print('_thisIngredientItem.ingredientName 1st : ${_thisIngredientItem
          .ingredientName}');

//    String newIngredientName = titleCase(_thisIngredientItem.ingredientName);


//  print('_thisIngredientItem.ingredientName 2nd : ${_thisIngredientItem.ingredientName}');


      _thisIngredientItem.itemId = itemId;

      String documentID = await _clientAdmin.insertIngredientItems(
          _thisIngredientItem, _thisIngredientItem.sequenceNo, _firebaseUserEmail, imageURL);

      // _thisIngredientItem, _firebaseUserEmail);

      print('added document: $documentID');


      //    }

      _thisIngredientItem.price = 0;
      _thisIngredientItem.ingredientName = '';
      _thisIngredientItem.extraIngredientOf = null;
      _thisIngredientItem.sequenceNo= _thisIngredientItem.sequenceNo+1;
      _ingredientItemController.sink.add(_thisIngredientItem);


      return (1);
    }
  }

//    List<NewCategoryItem>_allCategoryList=[];
  final _clientAdmin = FirebaseClientAdmin();

  void initiateIngredientGroups() {
    List<IngredientSubgroup> ingredientSubgroups =
    new List<IngredientSubgroup>();

//   liha =meat hedelma= fruit muut=other vihannekset vegetables


    IngredientSubgroup meat = new IngredientSubgroup(
        ingredientSubgroupName: 'meat', isSelected: false);

    IngredientSubgroup fruit = new IngredientSubgroup(
        ingredientSubgroupName: 'fruit', isSelected: false);


    IngredientSubgroup vegetables = new IngredientSubgroup(
        ingredientSubgroupName: 'vegetables', isSelected: false);

    IngredientSubgroup other = new IngredientSubgroup(
        ingredientSubgroupName: 'other', isSelected: false);


//    ingredientSubgroups.addAll([liha, hedelma,vihannekset, muut]);

    ingredientSubgroups.addAll([meat, fruit, other, vegetables]);

    _ingredientGroupes = ingredientSubgroups;
    _ingredientsGroupsController.sink.add(_ingredientGroupes);
  }

  void initiateCategoryForMultiSelectFoodCategory() {
    NewCategoryItem pizza = new NewCategoryItem(
      categoryName: 'pizza',
      sequenceNo: 0,
      documentID: 'pizza',
      fireStoreFieldName: 'pizza',
    );

    NewCategoryItem kebab = new NewCategoryItem(
      categoryName: 'kebab',
      sequenceNo: 1,
      documentID: 'kebab',
      fireStoreFieldName: 'pizza',
    );

    NewCategoryItem jauheliha_kebab_vartaat = new NewCategoryItem(
      categoryName: 'jauheliha kebab & vartaat',
      sequenceNo: 2,
      documentID: 'jauheliha_kebab_vartaat',
      fireStoreFieldName: 'jauheliha_kebab_vartaat',
    );

    NewCategoryItem salaatti_kasvis = new NewCategoryItem(
      categoryName: 'salaatti & kasvis',
      sequenceNo: 3,
      documentID: 'salaatti_kasvis',
      fireStoreFieldName: 'salaatti_kasvis',
    );

    NewCategoryItem hampurilainen = new NewCategoryItem(
      categoryName: 'hampurilainen',
      sequenceNo: 4,
      documentID: 'hampurilainen',
      fireStoreFieldName: 'hampurilainen',
    );

    NewCategoryItem lasten_menu = new NewCategoryItem(
      categoryName: 'lasten menu',
      sequenceNo: 5,
      documentID: 'lasten_menu',
      fireStoreFieldName: 'lasten_menu',
    );

    NewCategoryItem juomat = new NewCategoryItem(
      categoryName: 'juomat',
      sequenceNo: 6,
      documentID: 'juomat',
      fireStoreFieldName: 'juomat',
    );

    List<NewCategoryItem> categoryItems2 = new List<NewCategoryItem>();

    categoryItems2.addAll([
      pizza,
      kebab,
      jauheliha_kebab_vartaat,
      salaatti_kasvis,
      hampurilainen,
      lasten_menu,
      juomat
    ]);

    _foodCategoryTypesForMultiSelect = categoryItems2;
    _categoryMultiSelectController.sink.add(_foodCategoryTypesForMultiSelect);
  }
  // CONSTRUCTOR BIGINS HERE..

  AdminFirebaseIngredientBloc() {
    print('at AdminFirebaseIngredientBloc  ......()');

    getLastSequenceNumberForAdminIngredient();
    initiateIngredientGroups();
    initiateCategoryForMultiSelectFoodCategory();

//    initiateCategoryDropDownList();

//    getLastSequenceNumberFromFireBaseFoodItems();

    // need to use this when moving to food Item Details page.

    print('at FoodGalleryBloc()');

//    getAllIngredients();
    // invoking this here to make the transition in details page faster.

//    this.getAllFoodItems();
//    this.getAllCategories();
  }

  // CONSTRUCTOR ENDS HERE..

  // 4
  @override
  void dispose() {
    _ingredientItemController.close();
//    _foodItemController.close();
    _categoryMultiSelectController.close();
    _ingredientsGroupsController.close();

    // _isDisposedIngredients = true;
    // _isDisposedFoodItems = true;
    // _isDisposedCategories = true;
    // _isDisposed_known_last_sequenceNumber = true;
  }
}
