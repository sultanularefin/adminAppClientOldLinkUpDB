import 'package:image_picker/image_picker.dart';
import 'package:linkupadminolddb/src/BLoC/bloc.dart';
import 'package:linkupadminolddb/src/DataLayer/api/firebase_clientAdmin.dart';
// import 'package:linkupadminolddb/src/DataLayer/models/IngredientSubgroup.dart';
import 'package:linkupadminolddb/src/DataLayer/models/NewIngredient.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';
// import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';

//MODELS
import 'package:linkupadminolddb/src/DataLayer/models/OldCategoryItem.dart';
import 'package:mime_type/mime_type.dart';


class AdminFirebaseIngredientBloc implements Bloc {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

   bool _isDisposedIngredients = false;




  // File _image2;
  PickedFile _image2;
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
  FirebaseStorage(storageBucket: 'gs://linkupadminolddbandclientapp.appspot.com');

  String itemId;

  String uploadedBy = '';

  bool newsletter = false;


  void setImage(PickedFile localURL) {
  // void setImage(PickedFile localURL) {

    print('localURL : $localURL');
    _image2 = localURL;


    // print('localURL : $localURL');
    //
    // _image2 = localURL;
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


  void setIngredientName(var ingredientName) {

    logger.w('ingredient Name: $ingredientName');

    NewIngredient temp = new NewIngredient();
    temp = _thisIngredientItem;
    temp.ingredientName = ingredientName;
    temp.ingredientNameShort =  shortendCase(ingredientName);

    // temp.fireStoreFieldName = shortendCase(shortCategoryName);


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

  Future<String> _uploadFile(String itemId, itemName) async {
    print('at _uploadFile: ');

    print('itemId: $itemId');
    StorageReference storageReference_1 = storage
        .ref()
        .child('extraIngredients')
        .child(itemName +'__'+itemId + '.png');

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

    // return urlString;



  }

  void getLastSequenceNumberForAdminIngredientOld() async {
    print('at get Last SequenceNumberFromFireBaseFoodItems()');

//    if (_isDisposed_known_last_sequenceNumber == false) {
    int lastIndex =
    await _clientAdmin.getLastSequenceNumberForAdminIngredientOld();

    logger.i('lastIndex: $lastIndex');

    _thisIngredientItem.sequenceNo = lastIndex +1;

    _ingredientItemController.sink.add(_thisIngredientItem);


//    }
  }

  Future<int> saveIngredientItem() async {


      logger.i('at save ...');


      itemId = await generateItemId(6);
      //imageURL = await _uploadFile(itemId, _thisIngredientItem.ingredientName);

      String imageURL;

      if (_image2 != null) {
        imageURL =
        await _uploadFile(itemId, _thisIngredientItem.ingredientNameShort);
      } else {
        print('_image2= $_image2');

        String dummyIngredientImage =
            'https://firebasestorage.googleapis.com/v0/b/linkupadminolddbandclientapp.appspot.com/o/404%2Fingredient404.jpg';

        imageURL = Uri.decodeComponent(dummyIngredientImage
            .replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/linkupadminolddbandclientapp.appspot.com/o/',
            '')
            .replaceAll('?alt=media', ''));
      }

      print(
          'imageURL after stripping url for empty image or full image: $imageURL');

      print('itemId:____ $itemId');

      print('saving user using a web service');

      print('_thisIngredientItem.ingredientName 1st : ${_thisIngredientItem
          .ingredientName}');

      _thisIngredientItem.itemId = itemId;

      String documentID = await _clientAdmin.insertIngredientItems(
          _thisIngredientItem, _thisIngredientItem.sequenceNo, _firebaseUserEmail, imageURL);

      print('added document: $documentID');


      //    }

      _thisIngredientItem.price = 0;
      _thisIngredientItem.ingredientName = '';
      // _thisIngredientItem.extraIngredientOf = null;
      _thisIngredientItem.sequenceNo= _thisIngredientItem.sequenceNo+1;
      _ingredientItemController.sink.add(_thisIngredientItem);


      return (1);
    }


//    List<NewCategoryItem>_allCategoryList=[];
  final _clientAdmin = FirebaseClientAdmin();




  // CONSTRUCTOR BIGINS HERE..

  AdminFirebaseIngredientBloc() {
    print('at AdminFirebaseIngredientBloc  ......()');

    getLastSequenceNumberForAdminIngredientOld();

    print('at FoodGalleryBloc()');

  }

  // CONSTRUCTOR ENDS HERE..

  // 4
  @override
  void dispose() {
    _ingredientItemController.close();

  }
}
