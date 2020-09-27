import 'package:linkupadminolddb/src/BLoC/bloc.dart';
import 'package:linkupadminolddb/src/DataLayer/api/firebase_clientAdmin.dart';
import 'package:linkupadminolddb/src/DataLayer/models/SauceItem.dart';



import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:logger/logger.dart';



import 'package:firebase_storage/firebase_storage.dart';

//MODELS



class AdminFirebaseSauceBloc implements Bloc {
  var logger = Logger(
    printer: PrettyPrinter(),
  );


  File _image2;
  String _firebaseUserEmail;


  String imageURL = '';


  int sequenceNo = 0;


// main CheeseItem bloc component starts here...
  SauceItem _thisSauceItem = new SauceItem();
  SauceItem get getCurrentSauceItem => _thisSauceItem;
  final _sauceItemController = StreamController<SauceItem>();
  Stream<SauceItem> get thisSauceItemStream =>
      _sauceItemController.stream;
// main CheeseItem bloc component ends here...



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
    SauceItem temp = new SauceItem();
    temp = _thisSauceItem;
    temp.price = price;

    _thisSauceItem = temp;

    _sauceItemController.sink.add(_thisSauceItem);
  }

  void setItemName(var param) {

    logger.w('ingredient Name: $param');

    SauceItem temp = new SauceItem();
    temp = _thisSauceItem;
    temp.sauceItemName = param;

    _thisSauceItem = temp;

    _sauceItemController.sink.add(_thisSauceItem);


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
        .child('sauces2')
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

  Future<int> saveSauces() async {
  logger.i('at save ...');
    itemId = await generateItemId(6);
    //imageURL = await _uploadFile(itemId, _thisIngredientItem.ingredientName);

    String imageURL;

    if (_image2 != null) {
      imageURL = await _uploadFile(itemId, _thisSauceItem.sauceItemName);
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

    print('imageURL after stripping url for empty image or full image: $imageURL');

    print('itemId:____ $itemId');

    print('saving user using a web service');

    print('_thisIngredientItem.ingredientName 1st : ${_thisSauceItem.sauceItemName}');

//    String newIngredientName = titleCase(_thisIngredientItem.ingredientName);


//  print('_thisIngredientItem.ingredientName 2nd : ${_thisIngredientItem.ingredientName}');


    _thisSauceItem.itemId = itemId;

    String documentID = await _clientAdmin.insertSauceItem(
        _thisSauceItem, _thisSauceItem.sequenceNo, _firebaseUserEmail, imageURL);

    print('added document: $documentID');



    //    }

  _thisSauceItem.price=0;
  _thisSauceItem.sauceItemName='';
  _thisSauceItem.itemId='';
  _thisSauceItem.sequenceNo= _thisSauceItem.sequenceNo+1;
  _sauceItemController.sink.add(_thisSauceItem);

    return (1);
  }

//    List<NewCategoryItem>_allCategoryList=[];
  final _clientAdmin = FirebaseClientAdmin();



  void getLastSequenceNumberForAdminSacue() async {
    print('at get Last SequenceNumberFromFireBaseFoodItems()');

//    if (_isDisposed_known_last_sequenceNumber == false) {
      int lastIndex =
      await _clientAdmin.getLastSequenceNumberForAdminSacue2();

      logger.i('lastIndex: $lastIndex');

      _thisSauceItem.sequenceNo = lastIndex +1;

      _sauceItemController.sink.add(_thisSauceItem);


//    }
  }
//  CONSTRUCTOR BEGINS HERE..


  AdminFirebaseSauceBloc() {


    print('at AdminFirebaseIngredientBloc  ......()');

    print('at FoodGalleryBloc()');

    getLastSequenceNumberForAdminSacue();

  }

  // CONSTRUCTOR ENDS HERE..

  // 4
  @override
  void dispose() {
    _sauceItemController.close();
//    _foodItemController.close();
//    _categoryMultiSelectController.close();
//    _ingredientsGroupsController.close();

  }
}
