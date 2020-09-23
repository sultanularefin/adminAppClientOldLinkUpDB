


import 'package:foodgallery/src/BLoC/bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';

import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


import 'package:logger/logger.dart';

//MODELS
import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocID.dart';

import 'package:foodgallery/src/DataLayer/api/firebase_client.dart';
import 'dart:async';

//Map<String, int> mapOneSize = new Map();


/* printer related imports..*/

import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';


// this pkg i am using for searching device's only and for testing now on august 29....
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart' as primaryBlueToothPrinter;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';

/*printer related imports..*/
class UnPaidDetailsBloc /*with ChangeNotifier */ implements Bloc  {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final _client = FirebaseClient();


  // selected Sauce Items

  OneOrderFirebase _curretnFireBaseOrder ;
  OneOrderFirebase get getCurrentUnPaidFireBaseOrder => _curretnFireBaseOrder;
  final _oneFireBaseOrderController = StreamController <OneOrderFirebase>();
  Stream<OneOrderFirebase> get getCurrentUnPaidOrderStream => _oneFireBaseOrderController.stream;


  /* all _paymentType begins here.....*/

  List<PaymentTypeSingleSelect> _paymentType;
  List<PaymentTypeSingleSelect> get getCurrentPaymentType => _paymentType;
  final _paymentTypeController = StreamController <List<PaymentTypeSingleSelect>>.broadcast();
  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream => _paymentTypeController.stream;

  /* all _paymentType ends here.....*/



  // BLUETOOTH PRINTER DEVICES..

  List<PrinterBluetooth> _devicesBlueTooth = [];
  //  List<String> _devices =[];
  List<PrinterBluetooth> get getDevices => _devicesBlueTooth;
  final _devicesController = StreamController<List<PrinterBluetooth>>();
  Stream <List<PrinterBluetooth>> get getDevicesStream => _devicesController.stream;





  //  Stream  <List<PaymentTypeSingleSelect>> get getCurrentPaymentTypeSingleSelectStream => _paymentTypeController.stream;



  void initiatePaymentTypeSingleSelectOptionsUnPaidPage(int selectedPayment){



    PaymentTypeSingleSelect cash = new PaymentTypeSingleSelect(
      borderColor: '0xff95CB04',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Cash',
      iconDataString: 'FontAwesomeIcons.twitter',

      paymentIconName: 'Cash',
    );


//     0xffFEE295 false
    PaymentTypeSingleSelect card = new PaymentTypeSingleSelect(
      borderColor: '0xffFEE295',
      index: 1,
      isSelected: false,
      paymentTypeName: 'Card',
      iconDataString: 'FontAwesomeIcons.home',

      paymentIconName: 'Card',
    );

    List <PaymentTypeSingleSelect> paymentTypeSingleSelectArray = new List<PaymentTypeSingleSelect>();


    paymentTypeSingleSelectArray.addAll([cash, card  ]);

    paymentTypeSingleSelectArray[selectedPayment].isSelected =true;

    _paymentType = paymentTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

    _paymentTypeController.sink.add(_paymentType);


  }



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




  // CONSTRUCTOR BEGINS HERE.
  UnPaidDetailsBloc(
      OneOrderFirebase oneFireBaseOrder,
      ) {

    discoverDevicesConstructorNewPKG();

    initiatePaymentTypeSingleSelectOptionsUnPaidPage(1);
    logger.i('___ ___ || || @@@@  oneFireBaseOrder.documentId: ${oneFireBaseOrder.documentId}');

    oneFireBaseOrder.tempPaymentIndex =1;
    oneFireBaseOrder.tempPaidType='Card';

    _curretnFireBaseOrder= oneFireBaseOrder;
    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);

  }

  // CONSTRUCTOR ENDS HERE.




  void setPaymentTypeSingleSelectOptionForOrderUnPaidDetailsPage(
      PaymentTypeSingleSelect x,
      int newPaymentIndex,
      int oldPaymentIndex
      ){

    logger.i('at setPaymentTypeSingleSelectOptionForOrder');
    print('new Payment Index is $newPaymentIndex');
    print('old Payment Index is $oldPaymentIndex');


    List <PaymentTypeSingleSelect> singleSelectArray = _paymentType;

    singleSelectArray[oldPaymentIndex].isSelected =
    !singleSelectArray[oldPaymentIndex].isSelected;


    singleSelectArray[newPaymentIndex].isSelected =
    !singleSelectArray[newPaymentIndex].isSelected;


    _paymentType = singleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.
    _paymentTypeController.sink.add(_paymentType);


    OneOrderFirebase temp = _curretnFireBaseOrder;


    temp.tempPaymentIndex = newPaymentIndex;
    temp.tempPaidType = newPaymentIndex==0?'Cash':'Card';
    _curretnFireBaseOrder = temp;
    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);


  }



  // not added to anything yet...

  void clearSubscription(){

    _curretnFireBaseOrder = null; ;
    _paymentType = [];

    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);
    _paymentTypeController.sink.add(_paymentType);


  }


  Future<String> recitePrinted(String orderDocumentID,String status) async{

    String documentID = orderDocumentID;


    var updateResult =
    await _client.updateOrderCollectionDocumentWithRecitePrintedInformation(documentID,status);

    Map getDocs = updateResult.data();

    print('updateResult is:: :: $updateResult');



    String                    recitePrintedString = getDocs['recitePrinted'];

    print('recitePrintedString: $recitePrintedString');

    return recitePrintedString;

  }


  Future<OneOrderFirebase>  paymentButtonPressedUnPaidDetailsPage() async{
  // Future<int>  paymentButtonPressedUnPaidDetailsPage() async{

    OneOrderFirebase currenttempUnPaidOneOrderFB = _curretnFireBaseOrder;

    print('temp.documentId: ${currenttempUnPaidOneOrderFB.documentId}');
    String previouslyLaterPaidDocumentID = currenttempUnPaidOneOrderFB.documentId;

    String paidType0 =   currenttempUnPaidOneOrderFB.tempPaymentIndex==0?'Cash':'Card'; // no later option..


    print('paidType0 : $paidType0');

    var updateResult =
    await _client.updateOrderCollectionDocumentWithRecitePrintedInformation(previouslyLaterPaidDocumentID,paidType0);

    Map getDocs = updateResult.data();
    currenttempUnPaidOneOrderFB.paidStatus='Paid';
    currenttempUnPaidOneOrderFB.paidType= paidType0;


    // OneOrderFirebase returningOrder= currenttempUnPaidOneOrderFB;

    // currenttempUnPaidOneOrderFB.tempPayButtonPressed =false;

    _curretnFireBaseOrder = currenttempUnPaidOneOrderFB;
    _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);




    print('updateResult is:: :: $updateResult');
    String                    paidType2 = getDocs['paidType'];

    print('paidType2: $paidType2');

    if(paidType2 == paidType0){
      print('update successfull');

      currenttempUnPaidOneOrderFB.updateSuccess=true;
      return currenttempUnPaidOneOrderFB;
      // return 1;

    }


    return currenttempUnPaidOneOrderFB;
    // return 0;




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




  @override
  void dispose() {


    _oneFireBaseOrderController.close();
    _paymentTypeController.close();

    // _oneFireBaseOrderController.sink.add(_curretnFireBaseOrder);
    // _paymentTypeController.sink.add(_paymentType);

  }
}


