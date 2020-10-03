import 'package:image_picker/image_picker.dart';
import 'package:linkupadminolddb/src/BLoC/bloc.dart';
import 'package:linkupadminolddb/src/DataLayer/api/firebase_clientAdmin.dart';
import 'package:linkupadminolddb/src/DataLayer/models/OldCategoryItem.dart';
import 'package:mime_type/mime_type.dart';




// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';

// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';

//MODELS

//import 'package:linkupadminolddb/src/DataLayer/api/firebase_client.dart';

class AdminFirebaseOLDCategoryBloc implements Bloc {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  bool _isDisposedIngredients = false;
  bool _isDisposedFoodItems = false;
  bool _isDisposedCategories = false;

  final _clientAdmin = FirebaseClientAdmin();


  PickedFile _image2;
  String _firebaseUserEmail;



  String categoryName = 'PIZZA'.toLowerCase();
  String shortCategoryName;

  bool isHot = true;
  String priceInEuro = '';

  String imageURL = '';
  bool isAvailable = true;

  int sequenceNo = 0;


// main OldCategoryItem bloc component starts here...
  OldCategoryItem _thisOldCategoryItem = new OldCategoryItem();
  OldCategoryItem get getCurrentOldCategoryItem => _thisOldCategoryItem;
  final _oldCategoryItemController = StreamController<OldCategoryItem>();

  Stream<OldCategoryItem> get thisOldCategoryItemStream =>
      _oldCategoryItemController.stream;
// main OldCategoryItem bloc component ends here...



  // final FirebaseStorage storage =
  // FirebaseStorage(storageBucket: 'gs://kebabbank-37224.appspot.com');
  final FirebaseStorage storage =
  FirebaseStorage(storageBucket: 'gs://linkupadminolddbandclientapp.appspot.com');

  String itemId;

  String uploadedBy = '';

  bool newsletter = false;

  void setImage(PickedFile localURL) {
    print('localURL : $localURL');
    _image2 = localURL;
  }

  void setUser(var param) {
    _firebaseUserEmail = param;
  }

  /*
  void setPrice(String priceText) {
//    double minutes2 = double.parse(minutes);
    double price = double.parse(priceText);
    OldCategoryItem temp = new OldCategoryItem();
    temp = _thisOldCategoryItem;
    temp.price = price;

    _thisOldCategoryItem = temp;

    _OldCategoryItemController.sink.add(_thisOldCategoryItem);
  }

  */


  void setCategoryName(String categoryName) {

    logger.w('category Name Name: $categoryName');

    OldCategoryItem temp = new OldCategoryItem();
    temp = _thisOldCategoryItem;
    temp.categoryName = categoryName;

    _thisOldCategoryItem = temp;

    _oldCategoryItemController.sink.add(_thisOldCategoryItem);


  }

  void setShortCategoryName(String shortCategoryName) {

    logger.w('at setShortCategoryName: $shortCategoryName');

    OldCategoryItem temp = new OldCategoryItem();
    temp = _thisOldCategoryItem;
    temp.fireStoreFieldName = shortendCase(shortCategoryName);

    _thisOldCategoryItem = temp;

    _oldCategoryItemController.sink.add(_thisOldCategoryItem);


  }

  void setCategoryValueFoodItemUPload(int index) {
    // print('< > < > ZZZ  setting category food upload---------- [index]: $index');
    //
    // String categoryName =
    // _categoryTypesForDropDown[index].categoryName.toLowerCase();
    //
    // String shortCategoryName =
    // _categoryTypesForDropDown[index].fireStoreFieldName.toLowerCase();
    //
    // _thisFoodItem.categoryIndex= index;
    //
    // _thisFoodItem.categoryName = categoryName;
    // _thisFoodItem.shorCategoryName = shortCategoryName;
    //
    // print('categoryName: $categoryName');
    // print('shortCategoryName: $shortCategoryName');
    //
    // _foodItemController.sink.add(_thisFoodItem);
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


  Future<String> _uploadFile(String itemId, itemName) async {
    print('at _uploadFile: ');

    print('itemId: $itemId');

    print('itemName: $itemName');




    // print('itemId: $itemId');

    StorageReference storageReference_1 = storage
        .ref()
        .child('categories')
        .child(itemName +'__'+itemId + '.png');

    print('_image2: $_image2');

    File x = File(_image2.path);

    String mimeType = mime(_image2.path);
    logger.i('mimeType................... $mimeType');

    if (mimeType == null) mimeType = 'text/plain; charset=UTF-8';
    // you can change the default content type
    // or, you can choose to send error message
    // response.headers.set('Content-Type', mimeType);

    StorageUploadTask uploadTask = storageReference_1.putFile(
      File(_image2.path),
      // _image2.path,
      StorageMetadata(
          contentType: mimeType,//_image2. //'image/jpg',
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

  Future<int> save() async {
  logger.i('at save ... old category item.....');
    itemId = await generateItemId(6);

    String imageURL;

    if (_image2 != null) {
      imageURL = await _uploadFile(itemId, _thisOldCategoryItem.fireStoreFieldName);
    } else {
      print('_image2= $_image2');

      String dummyIngredientImage =
          'https://firebasestorage.googleapis.com/v0/b/linkupadminolddbandclientapp.appspot.com/o/404%2Fingredient404.jpg';
      // 'https://firebasestorage.googleapis.com/v0/b/kebabbank-37224.appspot.com/o/404%2Fingredient404.jpg';
      // linkupadminolddbandclientapp
      imageURL = Uri.decodeComponent(dummyIngredientImage
          .replaceAll(
          'https://firebasestorage.googleapis.com/v0/b/linkupadminolddbandclientapp.appspot.com/o/',
          '')
          .replaceAll('?alt=media', ''));
    }

    print('imageURL after stripping url for empty image or full image: $imageURL');

    print('itemId:____ $itemId');

    print('saving user using a web service');

    print('_thisIngredientItem.ingredientName 1st : ${_thisOldCategoryItem.categoryName}');


    _thisOldCategoryItem.itemId = itemId;

    String documentID = await _clientAdmin.insertOldCategoryItem(
        _thisOldCategoryItem, _thisOldCategoryItem.sequenceNo, _firebaseUserEmail, imageURL);

    print('added document: $documentID');


  _thisOldCategoryItem.fireStoreFieldName='';
  _thisOldCategoryItem.categoryName='';
  _thisOldCategoryItem.sequenceNo= _thisOldCategoryItem.sequenceNo+1;
  _thisOldCategoryItem.itemId='';
  _oldCategoryItemController.sink.add(_thisOldCategoryItem);



    return (1);
  }

//    List<NewCategoryItem>_allCategoryList=[];


  void getLastSequenceNumberForAdminOldCategory() async {
    print('at get Last SequenceNumberFromFireBaseFoodItems()');

//    if (_isDisposed_known_last_sequenceNumber == false) {
    int lastIndex =
    await _clientAdmin.getLastSequenceNumberForAdminOldCategory();

    logger.i('lastIndex: $lastIndex');

    _thisOldCategoryItem.sequenceNo = lastIndex +1;

    _oldCategoryItemController.sink.add(_thisOldCategoryItem);


//    }
  }

  AdminFirebaseOLDCategoryBloc() {
    print('at AdminFirebaseOLDCategoryBloc  ......()');



    getLastSequenceNumberForAdminOldCategory();

  }

  // CONSTRUCTOR ENDS HERE..

  // 4
  @override
  void dispose() {
    _oldCategoryItemController.close();

  }
}
