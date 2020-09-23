import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart' as ImageAliasAnotherSource;
//import 'package:image/image.dart';
import 'package:flutter/services.dart'; // InputFormatters.
import 'package:flutter/widgets.dart';

import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';


import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/Restaurant.dart';
//import 'package:ping_discover_network/ping_discover_network.dart';




import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/* classes added */
//import 'dart:convert';
//import 'dart:typed_data';
import 'dart:ui' as ui;


//import 'package:esc_pos_printer/esc_pos_printer.dart';

import 'package:flutter/rendering.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:oktoast/oktoast.dart';
import 'dart:async';


//  TODO: REdirect to food gallery page after pay button is pressed.

/*
* MODIFICATIONS: for REAL DEVICES.
1.
onTap: () =>  _testPrintDummyDevices(blueToothDevicesState[index]),

above to below for real devices.

onTap: () => _testPrint(blueToothDevicesState[index]),
* _testPrint(blueToothDevicesFromStream[index])

*
*
*
*
2.
  void _startScanDummyDevices() {
  *
  *
  * above to below for real devices.

  void _startScanDevices() {


* */

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
//import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/BLoC/shoppingCart_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';
//import 'package:foodgallery/src/screens/foodGallery/UNPaidPage.dart';

import 'package:foodgallery/src/screens/shoppingCart/widgets/FoodImage_inShoppingCart.dart';
import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
import 'package:logger/logger.dart';

import 'package:foodgallery/src/DataLayer/models/Order.dart';

// model files

import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
//import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';
import 'package:foodgallery/src/DataLayer/models/OrderTypeSingleSelect.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';

// LOCAL SCREEN FILES:

import './widgets/ShoppingCartPagePainters.dart';

// final Firestore firestore = Firestore();

class ShoppingCart extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  final FoodItem oneFoodItemData;

//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(

  ShoppingCart({Key key, this.child}) : super(key: key);

  @override
  _ShoppingCartState createState() => new _ShoppingCartState();

//  _FoodItemDetailsState createState() => _FoodItemDetailsState();

}

class _ShoppingCartState extends State<ShoppingCart> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final GlobalKey<ScaffoldState> _scaffoldKeyShoppingCartPage =
  new GlobalKey<ScaffoldState>();

//  String _currentSize;
//  int _itemCount = 1;
  int _currentOrderTypeIndex = 0; // phone, takeaway, delivery, dinning.
  int _currentPaymentTypeIndex =
  2; // PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
  bool showFullOrderDeliveryType = true;
  bool showUserInputOptionsLikeFirstTime = true;
  bool showCustomerInformationHeader = false;
  bool showFullPaymentType = true;
//  bool showFullOrderType = true;

  bool showEditingCompleteCustomerAddressInformation = false;
  bool showEditingCompleteCustomerHouseFlatIformation = false;
  bool showEditingCompleteCustomerPhoneIformation = false;
  bool showEditingCompleteCustomerReachoutIformation = false;

//  bool showInputtedCustomerIformation = false;

  final addressController = TextEditingController();
  final houseFlatNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final etaController = TextEditingController();

  bool loadingState = false;
  Timer _timer;

  // Set<String> categories ={}; // for Recite dummy Print

  /*
  * PRINTING RELATED STATE VARIABLES ARE HERE.
  * */

//  PrinterNetworkManager printerManager = PrinterNetworkManager();

  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

  List<PrinterBluetooth> blueToothDevicesState = [];
//  bool localScanAvailableState = true; // meant not busy.

//  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
//  List<PrinterBluetooth> _devices = [];

  /*
  String localIp = '';
  List<String> devices = [];
  bool isDiscovering = false;
  int found = -1;
  TextEditingController portController = TextEditingController(text: '9100');

  */
  /*
  * PRINTING RELATED STATE VARIABLES ENDS HERE.
  * */

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    addressController.dispose();
    houseFlatNumberController.dispose();
    phoneNumberController.dispose();
    etaController.dispose();
  }

//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false

/*
  @override
  void initState() {
//    setDetailForFood();
//    retrieveIngredientsDefault();

//    checkBlueToothDevices();




    print('debug print came to init State');
    print('debug print before invoking printerManager.scanResults.listen((devices) async { ');

    printerManager.scanResults.listen((devices) async {
      print('UI: Devices found ${devices.length}');
      setState(() {
        blueToothDevicesState = devices;
//        localScanAvailableState=!localScanAvailableState;
      });
    });

    super.initState();
  }

  */

//  void _startScanDummyDevices() {
  void _startScanDevices() {
    print('debug print inside _startScanDevices() method ');

    setState(() {
      // blueToothDevicesState = [];
    });

    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');

    // temporarily closing (COMMENTING).. july 12. 8:30 pm. for debugging...
    printerManager.startScan(Duration(seconds: 4));

    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');
    // Test devices added.

    /*
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );
    */

    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;

    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;

    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      blueToothDevicesState = tempBlueToothDevices;
    });
  }

  void _startScanDummyDevices() {
    print('debug print inside _startScanDevices() method ');

    /*
    setState(() {
      blueToothDevicesState = [];
    });
    */
    print('debug print blueToothDevicesState set to empty/ []  ');
    print(
        'debug print before calling  printerManager.startScan(Duration(seconds: 4));  ');

    // temporarily closing (COMMENTING).. july 12. 8:30 pm. for debugging...
    /* printerManager.startScan(Duration(seconds: 4)); */

    print(
        'debug print after calling  printerManager.startScan(Duration(seconds: 4));'
            ' inside _startScanDevices() method   ');
    // Test devices added.

    /*
    PaymentTypeSingleSelect Later = new PaymentTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: false,
      paymentTypeName: 'Later',
      iconDataString: 'FontAwesomeIcons.facebook',

      paymentIconName: 'Later',
    );
    */

    BluetoothDevice _x = new BluetoothDevice();
    _x.name = 'Restaurant Printer';
    _x.address = '0F:02:18:51:23:46';
    _x.type = 3;
    _x.connected = null;

    PrinterBluetooth x = new PrinterBluetooth(_x);

    BluetoothDevice _y = new BluetoothDevice();
    _y.name = 'JBL Charge 4';
    _y.address = '98:52:3D:BB:18:26';
    _y.type = 3;
    _y.connected = null;

    PrinterBluetooth y = new PrinterBluetooth(_y);

    List<PrinterBluetooth> tempBlueToothDevices = new List<PrinterBluetooth>();
    tempBlueToothDevices.addAll([x, y]);

    setState(() {
      // blueToothDevicesState = tempBlueToothDevices;
    });
  }

  void _stopScanDevices() {
    print('debug print inside _stopScanDevices() method ');
    printerManager.stopScan();
    print(
        'debug print inside _stopScanDevices() method and finished calling printerManager.stopScan() method');
  }

  /// Creates an image from the given widget by first spinning up a element and render tree,
  /// then waiting for the given [wait] amount of time and then creating an image via a [RepaintBoundary].
  ///
  /// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
//  Future<Uint8List> createImageFromWidget(
  Future<Uint8List> createImageFromWidget(Widget widget,
      {
        /* Duration wait, */
        Size logicalSize,
        Size imageSize}) async {
    print('at here: $createImageFromWidget');

    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
    imageSize ??= ui.window.physicalSize;

    assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    final RenderView renderView = RenderView(
      window: null,
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner();

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
    RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

//    if (wait != null) {
//      await Future.delayed(wait);
//    }
//    print('wait ** ** **: $wait');

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(
        pixelRatio: imageSize.width / logicalSize.width);
    final ByteData byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);

//    final Uint8List bytes =  byteData.buffer.asUint8List();

//    final Uint8List bytes = data.buffer.asUint8List();
//    final Image image = decodeImage(bytes);
//
//    final Image oneImage = ImageAliasAnotherSource.decodeImage(bytes);
    // decodePng(bytes);
//    decodeImage(bytes)

//    bytesArefins = bytes;
//    uint8LIstController.sink.add(bytesArefins);

    print('byteData: $byteData');
    return byteData.buffer.asUint8List();
  }

  Widget customerInformationOnlyWidget(OneOrderFirebase oneOrderForReceipt) {
    print(
        'at paidUnpaidDeliveryType: && oneOrderForReceipt.orderBy: ${oneOrderForReceipt.orderBy}'
            'oneOrderForReceipt.paidStatus: ${oneOrderForReceipt.paidStatus}');

    print('oneOrderForReceipt.orderBy: ${oneOrderForReceipt.orderBy}');

    if (oneOrderForReceipt.orderBy.toLowerCase() == 'TakeAway'.toLowerCase() ||
        oneOrderForReceipt.orderBy.toLowerCase() ==
            'DinningRoom'.toLowerCase()) {
      return new Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            height: 50,
            child: Text(
              'phone || address empty...',
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Itim-Regular',
              ),
            ),
          ));
    } else {
      CustomerInformation customerForReciteGeneration =
          oneOrderForReceipt.oneCustomer;

//  Widget paidUnpaidDeliveryType =
      return new Directionality(
        textDirection: TextDirection.ltr,
        child:

        /// toDo: multiline. maxlines
        Container(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                child: Text(
                  ((customerForReciteGeneration.address == null) ||
                      (customerForReciteGeneration.address.length == 0))
                      ? ''
                      : customerForReciteGeneration.address.length > 39
                      ? customerForReciteGeneration.address
                      .substring(0, 35) +
                      '...'
                      : customerForReciteGeneration.address,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Itim-Regular',
                  ),
                ),
              ),

              Container(
                height: 50,
                child: Text(
                  ((customerForReciteGeneration.flatOrHouseNumber == null) ||
                      (customerForReciteGeneration
                          .flatOrHouseNumber.length ==
                          0))
                      ? ''
                      : customerForReciteGeneration.flatOrHouseNumber.length >
                      39
                      ? customerForReciteGeneration.flatOrHouseNumber
                      .substring(0, 35) +
                      '...'
                      : customerForReciteGeneration.flatOrHouseNumber,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Itim-Regular',
                  ),
                ),
              ),

              Container(
                height: 50,
                child: Text(
                  ((customerForReciteGeneration.phoneNumber == null) ||
                      (customerForReciteGeneration.phoneNumber.length == 0))
                      ? ''
                      : customerForReciteGeneration.phoneNumber.length > 39
                      ? customerForReciteGeneration.phoneNumber
                      .substring(0, 35) +
                      '...'
                      : customerForReciteGeneration.phoneNumber,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Itim-Regular',
                  ),
                ),
              ),

              // 3 ends here.
            ],
          ),
        ),
      );
    }
  }

  Widget restaurantName(String name) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text('${name.toLowerCase()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Itim-Regular',
          )),
    );
  }

  Widget subTotalTotalDeliveryCost(double subtotal,
      {double deliveryCost: 2.50}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 130,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //  SizedBox(width: 5,),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'SUBTOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                            fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 18, fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ),

                  // qwe
//                          '${
//                              (unObsecuredInputandPayment.totalPrice
//                                  /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
//                              '\u20AC',
                  Text(
                    subtotal.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                          fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 18, fontFamily: 'Itim-Regular',
                    ),
                  ),
                ],
              ),
            ),

            // 1st row ends here.

            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //  SizedBox(width: 5,),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'Delivery Cost',
                      textAlign: TextAlign.center,
                      style: TextStyle(
//                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 18, fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ),
                  Text(
                    deliveryCost.toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
//                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 18, fontFamily: 'Itim-Regular',
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //  SizedBox(width: 5,),
                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      'TOTAL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                          color: Color(0xffF50303),
                        fontSize: 18, fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ),
                  Text(
                    (deliveryCost + subtotal).toStringAsFixed(2) + '\u20AC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 18, fontFamily: 'Itim-Regular',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cusomTtimerTest() {
    print('-------- .  ...  . at here: ::   ------- cusomTtimerTest');
//    _timer = new Timer(const Duration(milliseconds: 800), () {
    const Color beginColor = Colors.deepPurple;
    const Color endColor = Colors.deepOrange;
    AnimationController controller;

    return Container(
      margin: EdgeInsets.fromLTRB(0, displayHeight(context) / 2, 0, 0),
      child: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.cyanAccent,
                      valueColor: ColorTween(begin: beginColor, end: endColor)
                          .animate(controller))),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor: ColorTween(begin: beginColor, end: endColor)
                          .animate(controller))),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                      valueColor: ColorTween(begin: beginColor, end: endColor)
                          .animate(controller))),
            ),
            Center(
              child: Container(
                  alignment: Alignment.center,
                  child: new CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                      valueColor: ColorTween(begin: beginColor, end: endColor)
                          .animate(controller))),
            ),
          ],
        ),
      ),
    );
//    _timer = new Timer(const Duration(seconds: 1), () {
//
//
//     return Navigator.push(context, MaterialPageRoute(builder: (context) => FoodGallery2()));
//    });
//    });
  }

  @override
  Widget build(BuildContext context) {
    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    var logger = Logger(
      printer: PrettyPrinter(),
    );

    return GestureDetector(
        onTap: () {
          print('s');
//                      Navigator.pop(context);
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
//                  Navigator.pop(context);

          }
        },
        child: Scaffold(
          key: _scaffoldKeyShoppingCartPage,
          backgroundColor: Colors.white.withOpacity(0.05),

//          backgroundColor: Colors.purpleAccent,

//      resizeToAvoidBottomPadding: false ,
          // appBar: AppBar(title: Text('Food Gallery')),
          body: WillPopScope(
            onWillPop: () {
              final shoppingCartBloc =
              BlocProvider.of<ShoppingCartBloc>(context);
              print('at WillPopScope: ');

              List<SelectedFood> backUP =
                  shoppingCartBloc.getExpandedSelectedFood;
              print('at WillPopScope : $backUP');

              print('backUP.length == 0 ${backUP.length == 0}');

              if (backUP.length == 0) {
                Navigator.pop(context);
              }

              Order z = shoppingCartBloc.getCurrentOrder;

              print('order z: $z');
              z.selectedFoodInOrder = backUP;

              shoppingCartBloc.clearSubscription();

              logger.e(
                  'at WillPopScope Quantity: ${z.selectedFoodInOrder[0].quantity}');

              Navigator.pop(context, z);
              return new Future(() => false);
            },

              child: SingleChildScrollView(
                child: StreamBuilder<Order>(
                    stream: shoppingCartBloc.getCurrentOrderStream,
                    initialData: shoppingCartBloc.getCurrentOrder,
                    builder: (context, snapshot) {
//            if (snapshot.hasData) {

//              print('snapshot.hasData in main build(BuildContext context) : ${snapshot.hasData}');
                      // ---
                      const Color beginColor = Colors.deepPurple;
                      const Color endColor = Colors.deepOrange;
                      AnimationController controller;

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          print(
                              'at ConnectionState.none || ConnectionState.waiting ||  ');
                          return Container(
                            margin: EdgeInsets.fromLTRB(
                                0, displayHeight(context) / 2, 0, 0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: new CircularProgressIndicator(
                                          backgroundColor: Colors.green,
//                                          valueColor:
//                                          ColorTween(begin: beginColor, end: endColor).animate(controller)
                                        )),
                                  ),
                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: new CircularProgressIndicator(
                                          backgroundColor: Colors.yellow,
//                                        valueColor:
//                                            ColorTween(begin: beginColor, end: endColor).animate(controller)
                                        )),
                                  ),
                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: new CircularProgressIndicator(
                                          backgroundColor: Colors.blue,
//                                          valueColor:
//                                          ColorTween(begin: beginColor, end: endColor).animate(controller)
                                        )),
                                  ),
                                  Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: new CircularProgressIndicator(
                                          backgroundColor: Colors.pink,
//                                          valueColor:
//                                          ColorTween(begin: beginColor, end: endColor).animate(controller)
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          );
                          break;

                        case ConnectionState.active:
                        default:
                          if (snapshot.data is Order) {
                            print(
                                'at snapshot.data is Order for ConnectionState.active or default ');

//                      <<<<<<< finnishLanguage
                            Order oneOrder = snapshot.data;

                            logger.i(
                                'oneOrder.orderingCustomer.etaTimeOfDay.hour =>'
                                    ' ${oneOrder.orderingCustomer.etaTimeOfDay.hour}');
                            logger.w(
                                'oneOrder.orderingCustomer.etaTimeInMinutes =>'
                                    ' ${oneOrder.orderingCustomer.etaTimeInMinutes}');
                            logger.e(
                                'oneOrder.orderingCustomer.etaTimeOfDay.minute => '
                                    '${oneOrder.orderingCustomer.etaTimeOfDay.minute}'); // always return's -1;


                            //              int x = 5;
                            if (oneOrder.paymentButtonPressed == true) {




                              print('....payment button pressed.....');
                              if(oneOrder.paymentTypeIndex !=0) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, displayHeight(context) / 2, 0, 0),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[

                                        Center(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: new CircularProgressIndicator(
                                                backgroundColor: Colors
                                                    .lightGreenAccent,
//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)


                                              )
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                              'printing recite... please wait.',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 34,
                                                fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                color: Colors.redAccent,
                                                fontFamily: 'Itim-Regular',

                                              )
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: new CircularProgressIndicator(
                                                backgroundColor: Color(
                                                    0xffFC0000),

//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                );
                              }
                              else{
                                return Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, displayHeight(context)/2, 0, 0),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[

                                        Center(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: new CircularProgressIndicator(
                                                backgroundColor: Colors
                                                    .lightGreenAccent,
//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)


                                              )
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                              'later button pressed... please wait.',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 34,
                                                fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                                color: Colors.redAccent,
                                                fontFamily: 'Itim-Regular',

                                              )
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                              alignment: Alignment.center,
                                              child: new CircularProgressIndicator(
                                                backgroundColor: Color(
                                                    0xffFC0000),

//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                );
                              }
                            }
                            else {
                              CustomerInformation x = oneOrder.orderingCustomer;


                              logger.e(
                                  '\n\n AM I EXECUTED TWICE snapshot.data !=null  in build method  ;;; \n\n ');

                              return Container(
                                height: displayHeight(context),
                                child: Column(
                                  children: <Widget>[
                                    Container(

//                                    color:Colors.indigoAccent,
                                      height: displayHeight(context) / 1.10,

                                      width: displayWidth(context) / 1.03,

                                      margin: EdgeInsets.fromLTRB(12,
                                          displayHeight(context) / 16, 10, 0),

                                      child: Neumorphic(
                                        curve: Neumorphic.DEFAULT_CURVE,
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.concave,
                                          depth: 8,
                                          lightSource: LightSource.topLeft,
                                          color: Colors.white,
                                          boxShape:
                                          NeumorphicBoxShape.roundRect(
                                            BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),

                                        // THIS CHILD COLUMNS HOLDS THE CONTENTS OF THIS PAGE. BEGINS HERE.

                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
//                                          /WWW??

                                            // IMAGES OF FOODS   QUANTITY TIMES PUT HERE

                                            Container(
                                              width:
                                              displayWidth(context) / 1.03,
                                              height:
                                              displayHeight(context) / 20,
                                              color: Color(0xffffffff),
//                                            color:Colors.yellowAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                    displayWidth(context) /
                                                        1.5,
                                                    height:
                                                    displayHeight(context) /
                                                        30,
                                                    color: Color(0xffffffff),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                10, 0),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                'Shopping Cart',
                                                                style:
                                                                TextStyle(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                                                  color: Color(
                                                                      0xff000000),
                                                                )),
                                                          ),

                                                          /*
                                                        CustomPaint(
                                                          size: Size(
                                                              0, 19),
                                                          painter: LongHeaderPainterAfterShoppingCartPage(
                                                              context),
                                                        ),


                                                        */
                                                        ]),
                                                  ),

                                                  // 2ND CONTAINER HOLDING THE SHOPPING CART ICON. BEGINS HERE.
                                                ],
                                              ),
                                            ),

                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
//                                            color: Colors.white,
                                              color: Colors.blue,
//                                      FROM height: displayHeight(context) / 5.2 TO 4.8 ON JUNE 16
                                              height:
                                              displayHeight(context) / 5.4,
                                              width:
                                              displayWidth(context) / 1.03,
//                                            width: displayWidth(context) * 0.57,
                                              child:

                                              //ssd
                                              StreamBuilder<
                                                  List<SelectedFood>>(
                                                  stream: shoppingCartBloc
                                                      .getExpandedFoodsStream,
                                                  initialData: shoppingCartBloc
                                                      .getExpandedSelectedFood,
                                                  builder:
                                                      (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<SelectedFood>
                                                      expandedSelectedFoodInOrder =
                                                          snapshot.data;

                                                      if (expandedSelectedFoodInOrder ==
                                                          null) {
                                                        print(
                                                            'Order has no data');
                                                        print(
                                                            'this will never happen don\'t worry');

                                                        return Container(
                                                            child: Text(
                                                                'expandedSelectedFoodInOrder == Null'));
                                                      } else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

                                                        List<SelectedFood>
                                                        allOrderedFoods =
                                                            expandedSelectedFoodInOrder;

                                                        logger.e(
                                                            '\n\n AM I EXECUTED TWICE  ;;;'
                                                                ' allOrderedFoods.length: ${allOrderedFoods.length} \n\n ');
                                                        return Container(
//                color: Colors.green,
                                                          color: Color(
                                                              0xffFFFFFF),

                                                          child: ListView
                                                              .builder(
                                                            scrollDirection:
                                                            Axis.horizontal,

                                                            reverse: false,
                                                            shrinkWrap:
                                                            false,
                                                            itemCount:
                                                            allOrderedFoods
                                                                .length,
                                                            // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;

                                                            itemBuilder: (_,
                                                                int index) {
//            return Text('ss');

                                                              return FoodImageInShoppingCart(
                                                                  allOrderedFoods[
                                                                  index]
                                                                      .foodItemImageURL,
                                                                  /*OrderedFoodImageURL,*/
                                                                  allOrderedFoods[
                                                                  index]
                                                                      .foodItemName,
                                                                  /*OrderedFoodItemName, */
                                                                  allOrderedFoods[
                                                                  index]
                                                                      .selectedIngredients,
                                                                  allOrderedFoods[
                                                                  index]
                                                                      .unitPrice,
                                                                  index);
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);
                                                            },
                                                          ),

                                                          // M VSM ORG VS TODO. ENDS HERE.
                                                        );
                                                      }
                                                    } else {
                                                      print(
                                                          '!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
                                                      return Container(
                                                          child:
                                                          Text('Null'));
                                                    }
                                                  }),
                                              //ssd
                                            ),

                                            Container(
//                                        width: displayWidth(context) /1.8,
                                              width:
                                              displayWidth(context) / 1.03,
                                              child: AnimatedSwitcher(
                                                duration: Duration(
                                                    milliseconds: 1000),
//
                                                child: showFullOrderDeliveryType
                                                    ? animatedWidgetShowFullOrderDeliveryType()
                                                    : /*1 */
                                                animatedWidgetShowSelectedOrderDeliveryType(
                                                    oneOrder), /* 2*/
                                              ),
                                            ),

                                            /*
                                            * INITIAL CHOOSE ORDER TYPE ENDS HERE.*/

                                            // work_2
                                            // 911_2
                                            Container(
//                                          color: Colors.red,
//                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                        width: displayWidth(context) /1.8,
                                              width:
                                              displayWidth(context) / 1.03,
                                              height:
                                              displayHeight(context) / 2.2,

                                              //Text('AnimatedSwitcher('),
                                              child: AnimatedSwitcher(
                                                duration:
                                                Duration(milliseconds: 300),
//
//                                                child: showFullOrderType? animatedObscuredTextInputContainer():
//                                                animatedUnObscuredTextInputContainer(),
                                                child: oneOrder
                                                    .orderTypeIndex ==
                                                    0
                                                    ? _buildShoppingCartInputFieldsUNObscuredTakeAway(
                                                    oneOrder)
                                                    : oneOrder.orderTypeIndex ==
                                                    1
                                                    ? _buildShoppingCartInputFieldsUNObscuredDelivery(
                                                    oneOrder)
                                                    : oneOrder.orderTypeIndex ==
                                                    2
                                                    ? _buildShoppingCartInputFieldsUNObscuredPhone(
                                                    oneOrder)
                                                    :
                                                //OBSCURED NOT REQUIRED SINCE FOR DINNING ROOM OPTION WE WILL HAVE
                                                // WHEN DO YOU WANT THE FOOD ON YOUR TABLE.
//                                        _buildShoppingCartInputFieldsUNObscuredTakeAway(oneOrder)

                                                _buildShoppingCartInputFieldsUNObscuredDinningRoom(
                                                    oneOrder),
//                                        animatedObscuredTextInputContainer (oneOrder.ordersCustomer),
                                              ),
                                            ),

                                            /*
                                        // workTest
                                        Container(
                                          height:68,
//                                          color:Colors.lightBlueAccent,
                                          child: showAvailableDevices(),
                                        ),


                                        */
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            print('sanp shot.data !is Order');
                            return Container(
                              margin: EdgeInsets.fromLTRB(
                                  0, displayHeight(context) / 2, 0, 0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: new CircularProgressIndicator(
                                            backgroundColor:
                                            Colors.lightGreenAccent,
//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)
                                          )),
                                    ),
                                    Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: new CircularProgressIndicator(
                                            backgroundColor: Color(0xffFC0000),

//                                              valueColor:
//                                              ColorTween(begin: beginColor, end: endColor).animate(controller)
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      }
//                          }

//                    }
                    }),

            ),
          ),
          /*
          floatingActionButton: StreamBuilder<bool>(
            stream: printerManager.isScanningStream,
            // dEFINED IN HERE: C:\src\flutter\.pub-cache\hosted\
            // pub.dartlang.org\esc_pos_bluetooth-0.2.8\lib\
            // src\printer_bluetooth_manager.dart
            initialData: false,
            builder: (c, snapshot) {
              if (snapshot.data) {
                return FloatingActionButton(
                  child: Icon(Icons.stop),
//                  onPressed: _stopScanDevices,
                  onPressed: () =>
                  {
                    print(
                        'debug print in onPressed() of floating action button: before calling _stopScanDevices'),
                    _stopScanDevices(),

                    /*
                  setState(() {
                  localScanAvailableState = !localScanAvailableState;
                  })
                    */


                  },
                  backgroundColor: Colors.red,
                );
              } else {
                return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () =>
                  {
                    print(
                        'debug print in onPressed() of floating action button: before calling _startScanDevices'),
                    _startScanDevices(),

                    /*
                    setState(() {
                      localScanAvailableState = !localScanAvailableState;
                    })
                    */

                  },
//                  onPressed: _startScanDevices,
                );
              }
            },
          ),



          */
        ));
    //return Text('${x.toString()}');

//  }
//    }
//}
//
////---
//);
////    }
  }

  double tryCast<num>(dynamic x, {num fallback}) {
//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if (status) {
      return x.toDouble();
    }

    if (x is int) {
      return x.toDouble();
    } else if (x is double) {
      return x.toDouble();
    } else
      return 0.0;
  }

  Widget test1(Order oneOrder) {
//    final Order oneOrder = snapshot.data;
//              _currentPaymentTypeIndex = oneOrder.paymentTypeIndex;
  }

  Widget animatedWidgetShowFullOrderDeliveryType() {
//    print ('at animatedWidgetShowFullOrderType() ');

    return Container(
      height: displayHeight(context) / 20
          /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */
          +
          displayHeight(context) / 6 /* HEIGHT OF MULTI SELECT PORTION */,
//        from 7 to /8.5 on june 03
      width: ((displayWidth(context) / 1.03) - 40),
//        color:Colors.blue,

      child: Column(
        children: <Widget>[
          Container(
            width: displayWidth(context) / 1.03,
            height: displayHeight(context) / 20,
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: displayWidth(context) / 1.5,
                  height: displayHeight(context) / 20,
                  color: Color(0xffffffff),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          alignment: Alignment.center,
                          child: Text('valinta tilaus tyyppi'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff000000),
                              )),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            height: displayHeight(context) / 6,
            width: displayWidth(context) / 1.03,
            child: _buildOrderTypeSingleSelectOption(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeSingleSelectOption() {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentOrderType,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          } else {
            List<OrderTypeSingleSelect> allOrderTypesSingleSelect =
                snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('orderTypes: $allOrderTypesSingleSelect');
            OrderTypeSingleSelect selectedOne = allOrderTypesSingleSelect
                .firstWhere((oneOrderType) => oneOrderType.isSelected == true);
            _currentOrderTypeIndex = selectedOne.index;

            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: allOrderTypesSingleSelect.length,
                itemBuilder: (_, int index) {
                  return oneSingleDeliveryType(
                      allOrderTypesSingleSelect[index], index);
                },
              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }

  Widget animatedWidgetShowSelectedOrderDeliveryType(
      Order unObsecuredInputandPayment) {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

//    Widget unobscureInputandRestDeliveryPhone(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser =
        unObsecuredInputandPayment.orderingCustomer;

    return Container(
      height: displayHeight(context) / 20 +
          displayHeight(context) / 6 /* HEIGHT OF MULTI SELECT PORTION */,

//        color:Colors.lightGreenAccent,
//        width:displayWidth(context)/1.03,
      width: ((displayWidth(context) / 1.03) - 40),

      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentOrderTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentOrderType,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            } else {
              List<OrderTypeSingleSelect> allOrderTypesSingleSelect =
                  snapshot.data;

              OrderTypeSingleSelect selectedOne =
              allOrderTypesSingleSelect.firstWhere(
                      (oneOrderType) => oneOrderType.isSelected == true);
              _currentOrderTypeIndex = selectedOne.index;

              String orderTypeName = selectedOne.orderType;

              String orderTyepImage = selectedOne.orderTyepImage;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);

              return Container(
                width: displayWidth(context) / 1.03,
                height:
                displayHeight(context) / 20 + displayHeight(context) / 6,
                child: Row(
                  children: [
                    Container(
                      width: displayWidth(context) / 8,
//                        height: displayHeight(context) / 10,
                      height: displayHeight(context) / 9,
                      child: InkWell(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: Color(0xffFCF5E4),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                width: displayWidth(context) / 8.4,
                                height: displayHeight(context) / 15,
                                child: Container(
//                            color:Colors.pinkAccent,

                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),

                                  child: Image.asset(
                                    orderTyepImage,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  orderTypeName,
                                  style: TextStyle(
                                      color: Color(0xffFC0000),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            showFullOrderDeliveryType =
                            !showFullOrderDeliveryType;

//                            showFullOrderType
                            /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
                            showCustomerInformationHeader = false;
                            showUserInputOptionsLikeFirstTime = true;

                            showFullPaymentType = true; //DEFAULT.

                            // JUST LIKE THE FIRST TIME.
                            showEditingCompleteCustomerAddressInformation =
                            false;
                            showEditingCompleteCustomerHouseFlatIformation =
                            false;
                            showEditingCompleteCustomerPhoneIformation = false;
                            showEditingCompleteCustomerReachoutIformation =
                            false;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: ((displayWidth(context) / 1.03) - 140),
                      height: displayHeight(context) / 9,
//                height: displayHeight(context) / 12,

//                      color: Colors.red,
                      decoration: BoxDecoration(
                        border: Border.all(
//                    color: Colors.black,
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 0.5,
                        ),
                        shape: BoxShape.rectangle,
                      ),

//
//                        911
                      child: orderTypeName == 'Delivery'
                          ? animatedShowUserAddressDetailsInLineDeliveryOrderType(
                          currentUser)
                          : orderTypeName == 'TakeAway'
                          ? animatedShowUserAddressDetailsInLineTakeAwayOrderType(
                          currentUser)
                          : orderTypeName == 'Phone'
                          ? animatedShowUserAddressDetailsInLinePhoneOrderType(
                          currentUser)
                          : animatedShowUserAddressDetailsInLineTakeAwayOrderType(
                          currentUser),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  Widget animatedObscuredTextInputContainer(
      CustomerInformation forObscuredCustomerInputDisplay) {
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print('at animated Obscured Text Input Container');
    return AbsorbPointer(
      child: Opacity(
        opacity: 0.4,
        child: Container(
//            Colors.white.withOpacity(0.10),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                                      padding::::
            color: Colors.white,
//                                            height: 200,
            height: displayHeight(context) / 4,
            width: displayWidth(context) - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,
            /*
                                                    child:  AbsorbPointer(
                                                      child: _buildShoppingCartInputFields()
                                                  ),
                                                  */
            child: _buildShoppingCartInputFieldsObscured(
                forObscuredCustomerInputDisplay)),
      ),
    );
  }

  /*
  Widget _buildQuantityTimesofFood(/*Order qTimes */) {
//   height: 40,
//   width: displayWidth(context) * 0.57,

    var logger = Logger(
      printer: PrettyPrinter(),
    );

    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);



    return StreamBuilder<List<SelectedFood>>(
        stream: shoppingCartbloc.getExpandedFoodsStream,
        initialData: shoppingCartbloc.getExpandedSelectedFood,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SelectedFood> expandedSelectedFoodInOrder = snapshot.data;


//            logger.e(
//                'selectedFoodListLength: ${qTimes.selectedFoodListLength}');

//    final foodItemDetailsbloc = BlocProvider.of<ShoppingCartBloc>(context);

            if (expandedSelectedFoodInOrder == null) {
              print('Order has no data');
              print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('expandedSelectedFoodInOrder == Null'));
            }

            //    VIEW MODEL CHANGE THUS CONDITION CHANGE 1.
            /*
    if ((qTimes.foodItemName == '') && (qTimes.quantity == 0)) {
      print('Order has no data');
      print('this will never happen don\'t worry');
//        return Center(child: new LinearProgressIndicator());
      return Container(child: Text('Null'));
    }
    */
            else {
//      int quantity = qTimes.quantity;
//      int quantity = qTimes.selectedFoodInOrder.length;

              List<SelectedFood> allOrderedFoods = expandedSelectedFoodInOrder;
/*
//      int tempItemCount = allOrderedFoods.fold(0, (t, e) => t + e.quantity);

//      const tempAllOptionsState =ChildrensFromData.map((oneQuestion,index) => {
//      const opt1 = Array(oneQuestion.option1.length).fill({...templateOptionsState, key: index + 'o1'})
//      for(let i=0; i<opt1.length;i++){
//        opt1[i]= {key:index+'_o1_'+i,value:false};
//
//        }

//      void forEach(void f(E element)) {
//        for (E element in this) f(element);
//      }
              List<SelectedFood> selectedFoodforDisplay = new List<
                  SelectedFood>();

//      List<SelectedFood> test = makeMoreFoodByQuantity(allOrderedFoods.first);


              allOrderedFoods.forEach((oneFood) {
                print('oneFood details: ===> ===> ');
                print('oneFood: ${oneFood.foodItemName}');
                print('oneFood: ${oneFood.quantity}');
//         print('oneFood: ${oneFood.foodItemName}');
                List<SelectedFood> test = makeMoreFoodByQuantity(oneFood);

                print('MOMENT OF TRUTH: ');
                print(':::: ::: :: $test');
                selectedFoodforDisplay.addAll(test);
              });


//      selectedFoodforDisplay.addAll(test);

              logger.i('|| || || || forDisplay: $selectedFoodforDisplay');
              print('item count : ${selectedFoodforDisplay.length}');

              print('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
//       allOrderedFoods.map((oneFood)=>
//      makeMoreFoodByQuantity(oneFood.quantity));
//      String OrderedFoodItemName = qTimes.foodItemName;
//      String OrderedFoodImageURL = qTimes.foodItemImageURL;

//      final String imageURLBig;
//      final String foodItemName;

//      final List<NewIngredient> selectedIngredients =qTimes.ingredients;
//      final double price = qTimes.unitPrice;

              */

              logger.e('\n\n AM I EXECUTED TWICE  ;;; \n\n ');
              print('expandedSelectedFoodInOrder: $expandedSelectedFoodInOrder');

              return Container(

//                color: Colors.green,
                color: Color(0xffFFFFFF),

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

                  reverse: false,

                  shrinkWrap: false,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
//          itemCount: quantity,
                  itemCount: allOrderedFoods.length,
                  // List<SelectedFood> tempSelectedFoodInOrder = totalCartOrder.selectedFoodInOrder;


                  itemBuilder: (_, int index) {
//            return Text('ss');

                    return FoodImageInShoppingCart(
                        allOrderedFoods[index].foodItemImageURL, /*OrderedFoodImageURL,*/
                        allOrderedFoods[index].foodItemName, /*OrderedFoodItemName, */
                        allOrderedFoods[index].selectedIngredients,
                        allOrderedFoods[index].unitPrice,
                        index
                    );
//          oneMultiSelectInDetailsPage(foodItemPropertyOptions[index],
//            index);


                  },
                ),


                // M VSM ORG VS TODO. ENDS HERE.
              );
            }
          }
          else {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
        }
    );
  }

   */

//  animatedShowUserAddressDetailsInLineTakeAway

  Widget animatedShowUserAddressDetailsInLineDinningRoom(
      CustomerInformation currentUserForInline) {
    return Container(
      width: displayWidth(context) / 1.03,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
//      height: displayHeight(context) / 8,
      // CHANGED FROM THIS */*  height: displayHeight(context) / 8, */ TO
      // THIS :  height: displayHeight(context) / 20, ON june  04 2020.
      color: Color(0xFFffffff),
      child: Column(children: <Widget>[
        Container(
          height: displayHeight(context) / 21,
//              color:Colors.purple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: displayWidth(context) / 1.5,
                height: displayHeight(context) / 21,
                color: Color(0xffffffff),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.center,
                        child: Text('when you want to receive it',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            )),
                      ),
                      CustomPaint(
                        size: Size(0, 19),
                        painter:
                        LongPainterForanimatedWidgetShowSelectedOrderType(
                            context),
                      ),
                    ]),
              ),
              // THE ABOVE PART DEALS WITH LINES AND TEXT,
              // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

              //ZZZZ
            ],
          ),
        ),
        // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.

        // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
        //HHH

        Container(
          height: displayHeight(context) / 15,
//              color:Colors.amber,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              RaisedButton(
                color: Color(0xffFC0000),
//                    color:Color(0xffFC0000),
                // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                // clipBehavior: Clip.hardEdge,
                // splashColor: Color(0xffFC0000),
                highlightElevation: 12,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff707070),
                    style: BorderStyle.solid,
//            width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: currentUserForInline.etaTimeInMinutes != -1
                    ? Container(
                  color: Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                  width: displayWidth(context) / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.watch, size: 32.0, color: Colors.black),

                      // : Container for 2nd argument of ternary condition ends here.

                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        alignment: Alignment.center,
                        child: Text(
                            '${currentUserForInline.etaTimeInMinutes}',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            )),
                      ),

                      //ZZZZ
                    ],
                  ),
                )
                    : Container(
                  width: displayWidth(context) / 4,
//                       width:displayWidth(context) /10,
                )

                // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                ,
                onPressed: () => {
                  setState(() {
                    showEditingCompleteCustomerReachoutIformation =
                    !showEditingCompleteCustomerReachoutIformation;

                    etaController.text =
                        currentUserForInline.etaTimeInMinutes.toString();

//                      showFullOrderType = !showFullOrderType;
                  })
                },
              ),

              /*
                   Container(
                     height: 50,
                     color: Colors.amber[500],
                     child: const Center(child: Text('Entry B')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   Container(
                     height: 50,
                     color: Colors.amber[100],
                     child: const Center(child: Text('Entry C')),
                   ),
                   */
            ],
          ),
        )
      ]),
    );
//          }
//        }
//    );
  }

  Widget animatedShowUserAddressDetailsInLineTakeAway(
      CustomerInformation currentUserForInline) {
    return Container(
      width: displayWidth(context) / 1.03,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
      color: Color(0xffffffff),
      child: Column(children: <Widget>[
        Container(
          height: displayHeight(context) / 21,
//              color:Colors.purple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: displayWidth(context) / 1.5,
                height: displayHeight(context) / 21,
                color: Color(0xffffffff),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        alignment: Alignment.center,
                        child: Text('when you want to receive it',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            )),
                      ),
                      CustomPaint(
                        size: Size(0, 19),
                        painter:
                        LongPainterForanimatedWidgetShowSelectedOrderType(
                            context),
                      ),
                    ]),
              ),
              // THE ABOVE PART DEALS WITH LINES AND TEXT,
              // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

              //ZZZZ
            ],
          ),
        ),
        // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.

        // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
        //HHH

        Container(
          height: displayHeight(context) / 15,
//              color:Colors.amber,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              RaisedButton(
                color: Color(0xffFC0000),
                // highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
                // clipBehavior: Clip.hardEdge,
                // splashColor: Color(0xffFC0000),
                highlightElevation: 12,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff707070),
                    style: BorderStyle.solid,
//            width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: currentUserForInline.etaTimeInMinutes != -1
                    ? Container(
                  color: Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                  width: displayWidth(context) / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.watch, size: 32.0, color: Colors.black),

                      // : Container for 2nd argument of ternary condition ends here.

                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        alignment: Alignment.center,
                        child: Text(
                            '${currentUserForInline.etaTimeInMinutes}',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            )),
                      ),

                      //ZZZZ
                    ],
                  ),
                )
                    : Container(
                  width: displayWidth(context) / 4,
//                       width:displayWidth(context) /10,
                )

                // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                ,
                onPressed: () => {
                  setState(() {
                    showEditingCompleteCustomerReachoutIformation =
                    !showEditingCompleteCustomerReachoutIformation;

                    etaController.text =
                        currentUserForInline.etaTimeInMinutes.toString();

//                      showFullOrderType = !showFullOrderType;
                  })
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

//}

//  p-h-o-n-e

//  animatedShowUserAddressDetailsInLine

  Widget animatedShowUserInputPhoneOrderInLine(
      CustomerInformation currentUserForInline) {
    return Container(
      width: displayWidth(context) / 1.03,
      height: displayHeight(context) / 21 + displayHeight(context) / 15,
      color: Color(0xffffffff),
      child: Column(children: <Widget>[
        Container(
          height: displayHeight(context) / 21,
//              color:Colors.purple,
          child: Container(
            width: displayWidth(context) / 1.3,
            height: displayHeight(context) / 21,
            color: Color(0xffffffff),
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text('client\'s phone and duration in minutes:',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                    color: Color(0xff000000),
                  )),
            ),

            /*
                          CustomPaint(
                            size: Size(0, 19),
                            painter: LongPainterForPhone(
                                context),
                          ),
                          */
          ),
          // THE ABOVE PART DEALS WITH LINES AND TEXT,
          // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:

          //ZZZZ
        ),
        // ABOVE ROW CONTROLS THE TEXT AND LINE PAINTER AND EDIT BUTTON.

        // BELOW ROW HANDLES THE CUSTOMER INFORMATION ALONG WITH ICON AND POSSIBLY EDIT BUTTON.
        //HHH

        Container(
          height: displayHeight(context) / 15,
//              color:Colors.amber,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              // THIS CONTAINER ABOVE IS ABOUT HOUSE OR FLAT NUMBER INFORMATION ENDS HERE.
              // THIS CONTAINER BELOW IS ABOUT PHONE NUMBER INFORMATION BEGINS HERE.
              RaisedButton(
                splashColor: Color(0xffEEF6CE),
                highlightColor: Color(0xffEEF6CE),
                color: Color(0xffFFFFFF),
                child: currentUserForInline.phoneNumber != ''
                    ? Container(
                  color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                  width: displayWidth(context) / 3,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone, size: 32.0, color: Colors.black),

                      // : Container for 2nd argument of ternary condition ends here.

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          alignment: Alignment.center,
                          child:
                          Text('${currentUserForInline.phoneNumber}',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xff000000),
                              )),
                        ),
                      ),

                      //ZZZZ
                    ],
                  ),
                )
                    : Container(
                  color: Color(0xffFFFFFF),
//                      color:Colors.lightGreenAccent,
                  width: displayWidth(context) / 3,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone, size: 32.0, color: Colors.black),

                      // : Container for 2nd argument of ternary condition ends here.

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          alignment: Alignment.center,
                          child: Text('phone',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xff000000),
                              )),
                        ),
                      ),

                      //ZZZZ
                    ],
                  ),
                ),
                onPressed: () => {
                  setState(() {
                    showEditingCompleteCustomerPhoneIformation =
                    !showEditingCompleteCustomerPhoneIformation;

                    phoneNumberController.text =
                        currentUserForInline.phoneNumber;

//                      showFullOrderType = !showFullOrderType;
                  })
                },
              ),

              RaisedButton(
                splashColor: Color(0xffEEF6CE),
                highlightColor: Color(0xffEEF6CE),
                color: Color(0xffFFFFFF),
                child: currentUserForInline.etaTimeInMinutes != -1
                    ? Container(
                  color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                  width: displayWidth(context) / 3.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.watch, size: 32.0, color: Colors.black),

                      // : Container for 2nd argument of ternary condition ends here.

                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        alignment: Alignment.center,
                        child: Text(
                            '${currentUserForInline.etaTimeInMinutes}',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            )),
                      ),

                      //ZZZZ
                    ],
                  ),
                )
                    : Container(
                  color: Color(0xffFFFFFF),
//                      color:Color(0xffFC0000),
//                       width:displayWidth(context) /10,
                  width: displayWidth(context) / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.watch, size: 32.0, color: Colors.black),

                      // : Container for 2nd argument of ternary condition ends here.

                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        alignment: Alignment.center,
                        child: Text('ETA',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                              color: Color(0xff000000),
                            )),
                      ),

                      //ZZZZ
                    ],
                  ),
                )

                // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                ,
                onPressed: () => {
                  setState(() {
                    showEditingCompleteCustomerReachoutIformation =
                    !showEditingCompleteCustomerReachoutIformation;

                    etaController.text =
                        currentUserForInline.etaTimeInMinutes.toString();

//                      showFullOrderType = !showFullOrderType;
                  })
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget animatedShowUserAddressDetailsInLineDeliveryOrderType(
      CustomerInformation currentUserForInline) {
    return Container(
//      color:Colors.pink,
      width: displayWidth(context) / 1.3,
      height: displayHeight(context) / 9,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
              child: Text('Address',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff000000),
                  )),
              height: displayHeight(context) / 33,
            ),
            Container(
              height: displayHeight(context) / 13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                children: <Widget>[
                  Container(
                    width: displayWidth(context) / 4,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),
                      child: currentUserForInline.address != ''
                          ? Container(
                        width: displayWidth(context) / 5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
//                        color:Colors.pinkAccent,

                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.location_on,
                                size: 32.0,
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 5.5,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
//                                color: Color(0xffFFFFFF),
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.centerLeft,
                              child:
                              Text('${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : showEditingCompleteCustomerAddressInformation
                          ? Container(
                        width: displayWidth(context) / 5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
//                        color:Colors.pinkAccent,

                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.location_on,
                                size: 32.0,
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 5.5,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
//                                color: Color(0xffFFFFFF),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  '${currentUserForInline.address}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
//                                      textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : Container(
                        color: Color(0xffFFFFFF),
                        width: displayWidth(context) / 5,
                        height: displayHeight(context) / 9,
                        child: Container(),
                      ),
                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerAddressInformation =
                          !showEditingCompleteCustomerAddressInformation;
                          addressController.text = currentUserForInline.address;
                        })
                      },
                    ),
                  ),

                  Container(
                    width: displayWidth(context) / 5,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),
                      child: currentUserForInline.flatOrHouseNumber != ''
                          ? Container(
//                      color:Colors.brown,
//                        color: Color(0xffFFFFFF),

                        width: displayWidth(context) / 6.8,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.home,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 7.4,
                              height: displayHeight(context) / 9,
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Colors.redAccent,
                                  )),
                            ),

                            //ZZZZ
                          ],
                        ),
                      )
                          : (showEditingCompleteCustomerHouseFlatIformation)
                          ? Container(
//                      color:Colors.brown,
//                        color: Color(0xffFFFFFF),

                        width: displayWidth(context) / 6.8,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.home,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 7.4,
                              height: displayHeight(context) / 9,
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.flatOrHouseNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                    color: Colors.redAccent,
                                  )),
                            ),

                            //ZZZZ
                          ],
                        ),
                      )
                          : Container(
//                      color:Colors.brown,
                        color: Color(0xffFFFFFF),
//                       width:displayWidth(context) /2.6,
                        width: displayWidth(context) / 6.8,
                        height: displayHeight(context) / 9,
                        child: Container(),
                      ),
                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerHouseFlatIformation =
                          !showEditingCompleteCustomerHouseFlatIformation;

                          addressController.text = currentUserForInline.address;
                          houseFlatNumberController.text =
                              currentUserForInline.flatOrHouseNumber;

//                      showFullOrderType = !showFullOrderType;
                        })
                      },
                    ),
                  ),

                  //phone begins here...

                  Container(
                    width: displayWidth(context) / 5,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),
                      child: currentUserForInline.phoneNumber != ''
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.phone,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 7.4,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : (showEditingCompleteCustomerPhoneIformation)
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.phone,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 7.4,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : Container(
                        color: Color(0xffFFFFFF),
                        width: displayWidth(context) / 6.8,
                        height: displayHeight(context) / 9,
                        child: Container(),
                      ),
                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerPhoneIformation =
                          !showEditingCompleteCustomerPhoneIformation;
                          phoneNumberController.text =
                              currentUserForInline.phoneNumber;
                        })
                      },
                    ),
                  ),

                  //phone ends here....

                  // Time begins here...
                  Container(
                    width: displayWidth(context) / 5.5,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),

                      child: ((currentUserForInline.etaTimeOfDay.hour == 0) &&
                          (currentUserForInline.etaTimeOfDay.minute == 0) &&
                          (currentUserForInline.etaTimeInMinutes == -1) &&
                          (showEditingCompleteCustomerReachoutIformation ==
                              false))
                          ? Container(
                        color: Colors.white,
                      )
                          : (currentUserForInline.etaTimeInMinutes != -1)
                          ? Container(
                        width: displayWidth(context) / 7.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 10,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeInMinutes} min',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : ((showEditingCompleteCustomerReachoutIformation) &&
                          (currentUserForInline.etaTimeOfDay.hour ==
                              0) &&
                          (currentUserForInline
                              .etaTimeOfDay.minute ==
                              0))
                          ? Container(
                        width: displayWidth(context) / 7.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              width: displayWidth(context) / 10,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeInMinutes}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),

                            //ZZZZ
                          ],
                        ),
                      )
                          : Container(
                        width: displayWidth(context) / 7.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 10,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeOfDay.hour} :'
                                      '${currentUserForInline.etaTimeOfDay.minute} ',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      ),

                      //ZZZZ

                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerReachoutIformation =
                          !showEditingCompleteCustomerReachoutIformation;
                          etaController.text =
                              currentUserForInline.etaTimeInMinutes.toString();
                        })
                      },
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }

  Widget animatedShowUserAddressDetailsInLinePhoneOrderType(
      CustomerInformation currentUserForInline) {
    return Container(
//      color:Colors.pink,
      width: displayWidth(context) / 1.3,
      height: displayHeight(context) / 9,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
              child: Text('phone and select time:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff000000),
                  )),
              height: displayHeight(context) / 33,
            ),
            Container(
              height: displayHeight(context) / 13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                children: <Widget>[
                  //phone begins here...

                  Container(
                    width: displayWidth(context) / 5,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),
                      child: currentUserForInline.phoneNumber != ''
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.phone,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 7.4,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : (showEditingCompleteCustomerPhoneIformation)
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.phone,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 7.4,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : Container(
                        color: Color(0xffFFFFFF),
                        width: displayWidth(context) / 6.8,
                        height: displayHeight(context) / 9,
                        child: Container(),
                      ),
                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerPhoneIformation =
                          !showEditingCompleteCustomerPhoneIformation;
                          phoneNumberController.text =
                              currentUserForInline.phoneNumber;
                        })
                      },
                    ),
                  ),

                  //phone ends here....

                  Container(
                    width: displayWidth(context) / 5,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),

                      child: ((currentUserForInline.etaTimeOfDay.hour == 0) &&
                          (currentUserForInline.etaTimeOfDay.minute == 0) &&
                          (currentUserForInline.etaTimeInMinutes == -1) &&
                          (showEditingCompleteCustomerReachoutIformation ==
                              false))
                          ? Container(
                        color: Colors.white,
                      )
                          : (currentUserForInline.etaTimeInMinutes != -1)
                          ? Container(
                        width: displayWidth(context) / 9,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeInMinutes}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff000000),
                                  )),
                            ),

                            //ZZZZ
                          ],
                        ),
                      )
                          : ((showEditingCompleteCustomerReachoutIformation) &&
                          (currentUserForInline.etaTimeOfDay.hour ==
                              0) &&
                          (currentUserForInline
                              .etaTimeOfDay.minute ==
                              0))
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              width: displayWidth(context) / 9,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeInMinutes}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 9,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeOfDay.hour} :'
                                      '${currentUserForInline.etaTimeOfDay.minute} ',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      ),

                      //ZZZZ

                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerReachoutIformation =
                          !showEditingCompleteCustomerReachoutIformation;
                          etaController.text =
                              currentUserForInline.etaTimeInMinutes.toString();
                        })
                      },
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }

  Widget animatedShowUserAddressDetailsInLineTakeAwayOrderType(
      CustomerInformation currentUserForInline) {
    return Container(
//      color:Colors.pink,
      width: displayWidth(context) / 1.3,
      height: displayHeight(context) / 9,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
              child: Text('valitse aika:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff000000),
                  )),
              height: displayHeight(context) / 33,
            ),
            Container(
              height: displayHeight(context) / 23,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                children: <Widget>[
                  //phone ends here....

                  Container(
//                    color:Colors.red,
                    width: displayWidth(context) / 5,
                    height: displayHeight(context) / 9,
                    child: InkWell(
                      splashColor: Color(0xffEEF6CE),
                      highlightColor: Color(0xffEEF6CE),

                      child: ((currentUserForInline.etaTimeOfDay.hour == 0) &&
                          (currentUserForInline.etaTimeOfDay.minute == 0) &&
                          (currentUserForInline.etaTimeInMinutes == -1) &&
                          (showEditingCompleteCustomerReachoutIformation ==
                              false))
                          ? Container(
                        color: Colors.white,
                      )
                          : (currentUserForInline.etaTimeInMinutes != -1)
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 20,
                              child: Icon(
                                Icons.watch_later_outlined,
                                size: 32.0,
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              width: displayWidth(context) / 9,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeInMinutes}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      )
                          : ((showEditingCompleteCustomerReachoutIformation) &&
                          (currentUserForInline.etaTimeOfDay.hour ==
                              0) &&
                          (currentUserForInline
                              .etaTimeOfDay.minute ==
                              0))
                          ? Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),

                            // : Container for 2nd argument of ternary condition ends here.

                            Container(
                              width: displayWidth(context) / 9,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeInMinutes}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),

                            //ZZZZ
                          ],
                        ),
                      )
                          : Container(
                        width: displayWidth(context) / 6.5,
                        height: displayHeight(context) / 9,
                        decoration: BoxDecoration(
                          color: Color(0xffFCF5E4),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Color(0xffFCF5E4),
                              width: displayWidth(context) / 30,
                              child: Icon(
                                Icons.watch,
                                size: 32.0,
                                // color: Colors.black
                              ),
                            ),
                            Container(
                              width: displayWidth(context) / 9,
                              height: displayHeight(context) / 9,
                              color: Color(0xffFCF5E4),
                              padding:
                              EdgeInsets.fromLTRB(5, 0, 5, 0),
                              alignment: Alignment.center,
                              child: Text(
                                  '${currentUserForInline.etaTimeOfDay.hour} :'
                                      '${currentUserForInline.etaTimeOfDay.minute} ',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.redAccent,
                                  )),
                            ),
                          ],
                        ),
                      ),

                      //ZZZZ

                      onTap: () => {
                        setState(() {
                          showEditingCompleteCustomerReachoutIformation =
                          !showEditingCompleteCustomerReachoutIformation;
                          etaController.text =
                              currentUserForInline.etaTimeInMinutes.toString();
                        })
                      },
                    ),
                  )

                  // THIS CONTAINER ABOVE IS ABOUT ETA INFORMATION ENDS HERE.
                ],
              ),
            )
          ]),
    );
  }

// YYYY

  Widget whenYouWillPickTheOrder(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser =
        unObsecuredInputandPayment.orderingCustomer;

//    currentUser.etaTimeInMinutes!=-1
//    currentUser.etaTimeOfDay.hour != 0
//    currentUser.etaTimeOfDay.minute !=0

    print('currentUser.etaTimeOfDay.hour: ${currentUser.etaTimeOfDay.hour}');

    print(
        'currentUser.etaTimeOfDay.minute: ${currentUser.etaTimeOfDay.minute}');

    TimeOfDay tempTimeOfDay = new TimeOfDay(hour: 0, minute: 0);

    if ((currentUser.etaTimeOfDay.minute != 0) ||
        (currentUser.etaTimeOfDay.hour != 0)) {
      tempTimeOfDay = new TimeOfDay(
          hour: currentUser.etaTimeOfDay.hour,
          minute: currentUser.etaTimeOfDay.minute);
    }

//    911_4
//work_4
//    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;

    return Container(
      child: showEditingCompleteCustomerReachoutIformation
          ? Container()
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
//              color:Colors.purple,
//              width: displayWidth(context) / 4.5,
            width: displayWidth(context) / 3.5,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: displayHeight(context) / 24,
            padding:
            EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),

            child: OutlineButton(
              onPressed: () async {
                Future<TimeOfDay> selectedTime24Hour = showTimePicker(
                  context: context,
                  initialTime: tempTimeOfDay,

//                    TimeOfDay(hour: 10, minute: 47),

                  builder: (BuildContext context, Widget child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child,
                    );
                  },
                );

                selectedTime24Hour.whenComplete(() {
                  print(
                      "selectedTime24Hour called when future completes");
                }).then((selectedTime24HourResult) async {
                  print(
                      "selectedTime24HourResult: $selectedTime24HourResult");

                  final shoppingCartBloc =
                  BlocProvider.of<ShoppingCartBloc>(context);

                  shoppingCartBloc
                      .setETATimeOFDayForOrder(selectedTime24HourResult);
                  setState(() {
                    showFullOrderDeliveryType = false;
                    showCustomerInformationHeader = true;
                    showUserInputOptionsLikeFirstTime = false;
                    showFullPaymentType =
                    true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                    showEditingCompleteCustomerReachoutIformation = true;
                  });
                }).catchError((onError) {
                  print('getting time not successful: $onError');
                  return false;
                });
//                                  RRRRRGHGHGHGH
              },

              splashColor: Colors.indigoAccent,
//                                highlightElevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),

              borderSide: BorderSide(
                color: Colors.grey,
//                                        color:Color(0xff707070),
                style: BorderStyle.solid,
                width: 1.0,
              ),

              highlightElevation: 12,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0 /*15*/),
                width: displayWidth(context) / 4.5,
                height: displayHeight(context) / 24,
                child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 0),
                      child: Icon(
                        Icons.access_alarm,
                        size: 28,
                        color: Color(0xffBCBCBD),
                      ),
                    ),
                    Container(
//                        color:Colors.pinkAccent,
                      alignment: Alignment.center,
                      width: displayWidth(context) / 5.5,
//                                        color:Colors.purpleAccent,
                      // do it in both Container
                      child: Text(
                        // 'milloin tulet',
                        'time of day',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Color(0xffBCBCBD),
                style: BorderStyle.solid,
                width: 1.0,
              ),

              boxShadow: [
                BoxShadow(
                    color: Color(0xffFFFFFF),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 2.0))
              ],
              color: Color(0xffFFFFFF),
            ),
            width: displayWidth(context) / 2.5,
            height: displayHeight(context) / 24,
            padding:
            EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: displayHeight(context) / 40,
                  width: 5,
                  margin: EdgeInsets.only(left: 0),
                  child: Icon(
                    Icons.watch_later_outlined,
                    size: 28,
                    color: Color(0xffBCBCBD),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: displayWidth(context) / 4,
                  child: TextField(
                    controller: etaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                      //'Valitse sopiva aika',
                      'minutes from now',
                      hintStyle:
                      TextStyle(color: Colors.black26, fontSize: 17),
                    ),
                    style:
                    TextStyle(color: Color(0xffFC0000), fontSize: 16),
                    onChanged: (text) {
                      print("0444: $text");

                      print("33: $text");
                      final shoppingCartBloc =
                      BlocProvider.of<ShoppingCartBloc>(context);

                      shoppingCartBloc.setETAForOrder(text);
                      setState(() {
                        showFullOrderDeliveryType = false;

                        // showFullOrderType
                        /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                        showCustomerInformationHeader = true;
                        showUserInputOptionsLikeFirstTime = false;
                        showFullPaymentType =
                        true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                      });
                    },
                    onTap: () {
                      if ((currentUser.address.trim().length) > 0 ||
                          (currentUser.flatOrHouseNumber.trim().length) >
                              0 ||
                          (currentUser.phoneNumber.trim().length) > 0) {
                        showEditingCompleteCustomerHouseFlatIformation =
                        true;
                      } else {
                        setState(() {
                          showFullOrderDeliveryType = false;
                          showCustomerInformationHeader = true;
                          showUserInputOptionsLikeFirstTime = false;
                          showFullPaymentType =
                          true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                        });
                      }
                    },
                    onEditingComplete: () {
                      logger.i(
                          '...................on onEditingComplete of  ETA..........  ');
                      showEditingCompleteCustomerReachoutIformation =
                      true;
                      print(
                          'MMMM      MMMM           MMMM     at editing complete of Customer\'s address ETA Time:');
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputFieldsPhoneOrderType(Order unObsecuredInputandPayment) {
    logger.i('at  inputFieldsPhoneOrderType(Order unObsecuredInputandPayment)');
    CustomerInformation currentUser =
        unObsecuredInputandPayment.orderingCustomer;

    return Container(
//        color:Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: (showEditingCompleteCustomerPhoneIformation == false)
                ? Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xffBCBCBD),
                  style: BorderStyle.solid,
                  width: 2.0,
                ),

                boxShadow: [
                  BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                      color: Color(0xffFFFFFF),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 2.0))
                ],

                color: Color(0xffFFFFFF),
//                                      Colors.black54
              ),

//                                  color: Color(0xffFFFFFF),
              width: displayWidth(context) / 2.5,
              height: displayHeight(context) / 24,
              padding:
              EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
//                                            height: 25,
                    height: displayHeight(context) / 40,
                    width: 5,
                    margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                    child: Icon(
//                                          Icons.add_shopping_cart,
                      Icons.phone,
                      size: 28,
                      color: Color(0xffBCBCBD),
                    ),
                  ),
                  Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                    alignment: Alignment.center,
                    width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                    // do it in both Container
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(16),
                        WhitelistingTextInputFormatter.digitsOnly,
//                                                WhitelistingTextInputFormatter(RegExp("+[0-9]"))
//                                                WhitelistingTextInputFormatter(RegExp("[+]"))
                      ],
                      controller: phoneNumberController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                        border: InputBorder.none,
                        hintText: 'Enter phone / telephone number',
                        hintStyle: TextStyle(
                            color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                      ),
                      style: TextStyle(
                          color: Color(0xffFC0000), fontSize: 16),
                      onChanged: (text) {
                        print("33: $text");

                        final shoppingCartBloc =
                        BlocProvider.of<ShoppingCartBloc>(context);
//
                        shoppingCartBloc.setPhoneNumberForOrder(text);

                        setState(() {
                          showFullOrderDeliveryType = false;
                          // showFullOrderType = false;
                          // showFullOrderType
                          /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                          showCustomerInformationHeader = true;
                          showUserInputOptionsLikeFirstTime = false;
                          showFullPaymentType =
                          true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                        });
                        // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                      },
                      onTap: () {
                        setState(() {
                          showFullOrderDeliveryType = false;
                          // showFullOrderType = false;
                          // showFullOrderType
                          /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                          showCustomerInformationHeader = true;
                          showUserInputOptionsLikeFirstTime = false;
                          showFullPaymentType =
                          true; // default.// NOTHING TO DO WITH INPUT FIELDS.
//                                                showFullOrderType = false,
                        });
                      },
                      onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                        print(
                            'at editing complete of Customer Phone Iformation ');
                        setState(() => {
                          showEditingCompleteCustomerPhoneIformation =
                          true
//                                          showInputtedCustomerIformation= true,
                        });
                      },
                    ),
                  )
                ],
              ),
            )
                : Container(),
          ),
          Container(
              child: ((showEditingCompleteCustomerPhoneIformation) &&
                  (showEditingCompleteCustomerReachoutIformation == false))
                  ? Container(
                height: displayHeight(context) / 18,
                width: displayWidth(context) / 1.03,
                child:
                whenYouWillPickTheOrder(unObsecuredInputandPayment),
              )
                  : Container()),
        ],
      ),
    );
  }

  Widget inputFieldsDelivery(Order unObsecuredInputandPayment) {
    CustomerInformation currentUser =
        unObsecuredInputandPayment.orderingCustomer;

    return Container(
//        color:Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: showEditingCompleteCustomerAddressInformation
                ? Container()
                : Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xffBCBCBD),
                  style: BorderStyle.solid,
                  width: 2.0,
                ),

                boxShadow: [
                  BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                      color: Color(0xffFFFFFF),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 2.0))
                ],

                color: Color(0xffFFFFFF),
//                                      Colors.black54
              ),

//                                  color: Color(0xffFFFFFF),
              width: displayWidth(context) / 2.5,
              height: displayHeight(context) / 24,
              padding:
              EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
//                                            height: 25,
                    height: displayHeight(context) / 40,
                    width: 5,
                    margin: EdgeInsets.only(left: 0),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 28,
                      color: Color(0xffBCBCBD),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                    // do it in both Container
                    child: TextField(
                      controller: addressController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusColor: Color(0xffFC0000),
                        border: InputBorder.none,
                        // hintText: 'katuosoite ja talon numero ',
                        hintText: 'street address and house number',
                        hintStyle: TextStyle(
                            color: Colors.black54, fontSize: 14),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                      ),
                      onChanged: (text) {
                        //RRRR

                        print('at address of unobsecured (deliver loc)');

                        final shoppingCartBloc =
                        BlocProvider.of<ShoppingCartBloc>(context);
//
                        shoppingCartBloc.setAddressForOrder(text);
                        if ((text.trim().length) > 0) {
                          print('at (text.trim().length) >0)');
                          setState(() {
                            showFullOrderDeliveryType = false;

                            showCustomerInformationHeader = true;
                            showUserInputOptionsLikeFirstTime = false;
                            showFullPaymentType =
                            true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                          });
                        } else {
                          setState(() {
                            showFullOrderDeliveryType = false;

                            showCustomerInformationHeader = true;
                            showUserInputOptionsLikeFirstTime = false;
                            showFullPaymentType =
                            true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                                                showCustomerInformationHeader = true,
                          });
                        }
                      },
                      onTap: () {
                        setState(() {
                          showFullOrderDeliveryType = false;
                          showCustomerInformationHeader = true;
                          showUserInputOptionsLikeFirstTime = false;
                          showFullPaymentType =
                          true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                        });
                      },
                      onEditingComplete: () {
                        print('at editing complete of address ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                        setState(() => {
                          showEditingCompleteCustomerAddressInformation =
                          true
//                                          showInputtedCustomerIformation= true,
                        });
                      },
                      style: TextStyle(
                          color: Color(0xffFC0000), fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),

          Container(
              child: ((showEditingCompleteCustomerAddressInformation) &&
                  (showEditingCompleteCustomerHouseFlatIformation == false))
                  ? Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xffBCBCBD),
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),

                  boxShadow: [
                    BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                        color: Color(0xffFFFFFF),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 2.0))
                  ],

                  color: Color(0xffFFFFFF),
//                                      Colors.black54
                ),

//                                  color: Color(0xffFFFFFF),
                width: displayWidth(context) / 2.5,
                height: displayHeight(context) / 24,
                padding:
                EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: displayHeight(context) / 40,
                      width: 5,
                      margin: EdgeInsets.only(left: 0),
                      child: Icon(
                        Icons.home_outlined,
                        size: 28,
                        color: Color(0xffBCBCBD),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: displayWidth(context) / 4,
                      child: TextField(
                        controller: houseFlatNumberController,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: 'asunto numero',
                          hintText: 'flat number',
                          hintStyle: TextStyle(
                              color: Colors.black54, fontSize: 14),

//                                        labelText: 'Search about meal.'
                        ),
                        onChanged: (text) {
                          final shoppingCartBloc =
                          BlocProvider.of<ShoppingCartBloc>(context);
//
                          shoppingCartBloc
                              .setHouseorFlatNumberForOrder(text);

                          setState(() {
                            showFullOrderDeliveryType = false;

                            showCustomerInformationHeader = true;
                            showUserInputOptionsLikeFirstTime = false;
                            showFullPaymentType =
                            true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                          });
                          // NECESSARY TO SHRINK THE SELECTED ORDER WIDGET.
                        },
                        onTap: () {
                          setState(() {
                            showFullOrderDeliveryType = false;
                            showCustomerInformationHeader = true;
                            showUserInputOptionsLikeFirstTime = false;
                            showFullPaymentType =
                            true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                          });
                        },
                        onEditingComplete: () {
                          print(
                              'at editing complete of House or Flat Iformation ');
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');
                          setState(() => {
                            showEditingCompleteCustomerHouseFlatIformation =
                            true
//                                          showInputtedCustomerIformation= true,
                          });
                        },
                        style: TextStyle(
                            color: Color(0xffFC0000), fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
                  : Container()),

          Container(
            child: ((showEditingCompleteCustomerAddressInformation) &&
                (showEditingCompleteCustomerHouseFlatIformation) &&
                (showEditingCompleteCustomerPhoneIformation == false))
                ? Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xffBCBCBD),
                  style: BorderStyle.solid,
                  width: 2.0,
                ),

                boxShadow: [
                  BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                      color: Color(0xffFFFFFF),
                      blurRadius: 10.0,
                      offset: Offset(0.0, 2.0))
                ],

                color: Color(0xffFFFFFF),
//                                      Colors.black54
              ),

//                                  color: Color(0xffFFFFFF),
              width: displayWidth(context) / 2.5,
              height: displayHeight(context) / 24,
              padding:
              EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
//                                            height: 25,
                    height: displayHeight(context) / 40,
                    width: 5,
                    margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                    child: Icon(
//                                          Icons.add_shopping_cart,
                      Icons.phone_outlined,
                      size: 28,
                      color: Color(0xffBCBCBD),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: displayWidth(context) / 4,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(16),
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      controller: phoneNumberController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) =>
                          FocusScope.of(context).nextFocus(),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // hintText: 'puhelin numero',
                        hintText: 'phone number',
                        hintStyle: TextStyle(
                            color: Colors.black54, fontSize: 16),
                      ),
                      style: TextStyle(
                          color: Color(0xffFC0000), fontSize: 16),
                      onChanged: (text) {
                        print("33: $text");

                        final shoppingCartBloc =
                        BlocProvider.of<ShoppingCartBloc>(context);

                        shoppingCartBloc.setPhoneNumberForOrder(text);

                        setState(() {
                          showFullOrderDeliveryType = false;

                          showCustomerInformationHeader = true;
                          showUserInputOptionsLikeFirstTime = false;
                          showFullPaymentType =
                          true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                        });
                      },
                      onTap: () {
                        setState(() {
                          showFullOrderDeliveryType = false;
                          // showFullOrderType = false;
                          // showFullOrderType
                          /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                                showCustomerInformationHeader = false;
                          showCustomerInformationHeader = true;
                          showUserInputOptionsLikeFirstTime = false;
                          showFullPaymentType =
                          true; // default.// NOTHING TO DO WITH INPUT FIELDS.
//                                                showFullOrderType = false,
                        });
                      },
                      onEditingComplete: () {
//                                                              logger.i('onEditingComplete  of condition 4');
//                                                              print('called onEditing complete');

                        print(
                            'at editing complete of Customer Phone Iformation ');
                        setState(() => {
                          showEditingCompleteCustomerPhoneIformation =
                          true
//                                          showInputtedCustomerIformation= true,
                        });
                      },
                    ),
                  )
                ],
              ),
            )
                : Container(),
          ),

          Container(
              child: ((showEditingCompleteCustomerAddressInformation) &&
                  (showEditingCompleteCustomerHouseFlatIformation) &&
                  (showEditingCompleteCustomerPhoneIformation) &&
                  (showEditingCompleteCustomerReachoutIformation == false))
                  ? Container(
                height: displayHeight(context) / 18,
                width: displayWidth(context) / 1.03,
                child:
                whenYouWillPickTheOrder(unObsecuredInputandPayment),
              )
                  : Container()),

//          whenYouWillPickTheOrder(unObsecuredInputandPayment),
        ],
      ),
    );
  }

  Widget _buildShoppingCartInputFieldsUNObscuredDinningRoom(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;

    CustomerInformation currentUser = x;

//    print('currentUser.address: ${currentUser.address}');
//    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
//    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
//    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

    print('currentUser.address: ${currentUser.address}');

    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

    // work_1
    // return unobscureInputandRestforDinningRoom(unObsecuredInputandPayment);

//    return
//      unobscureInputandRestforTakeAway(unObsecuredInputandPayment);

    // Widget unobscureInputandRestforDinningRoom(Order unObsecuredInputandPayment) {

    // CustomerInformation currentUser = unObsecuredInputandPayment
    //     .orderingCustomer;

    print('at VV VV ^^ ^^ unobscureInputandRestDeliveryPhone.......\" \"\" ');

    print(
        'showEditingCompleteCustomerAddressInformation: $showEditingCompleteCustomerAddressInformation');
    print(
        'showEditingCompleteCustomerHouseFlatIformation: $showEditingCompleteCustomerHouseFlatIformation');
    print(
        'showEditingCompleteCustomerPhoneIformation : $showEditingCompleteCustomerPhoneIformation');
    print(
        'showEditingCompleteCustomerReachoutIformation: $showEditingCompleteCustomerReachoutIformation');
    print(
        'allCustomerInputsCompleted(unObsecuredInputandPayment.orderingCustomer):'
            ' ${allCustomerInputsCompleted(unObsecuredInputandPayment.orderingCustomer)} ');

    return Container(
      height: displayHeight(context) / 2.2,
      width: displayWidth(context) / 1.03,
      // color:Colors.lightBlueAccent,

      child: Container(
        height:
        displayHeight(context) / 2.2 - displayHeight(context) / 20 - 100,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: ((takeAwayDinningTimeInputCompleted(
              unObsecuredInputandPayment.orderingCustomer) ==
              true) &&
              (showEditingCompleteCustomerReachoutIformation == true))
              ? animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
              unObsecuredInputandPayment)
              : Container(
            // color:Colors.lightBlueAccent,
            // color: Color(0xffFFFFFF),
            child: Container(
              // color:Colors.red,
              height: displayHeight(context) / 18,
              width: displayWidth(context) / 1.03,
              child: whenYouWillPickTheOrder(unObsecuredInputandPayment),
            )
            // child:  whenYouWillPickTheOrder(unObsecuredInputandPayment),
            ,
          ),
        ),
      ),
    );
// GGG),

    // }
  }

  Widget _buildShoppingCartInputFieldsUNObscuredTakeAway(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

    // return
    //   unobscureInputandRestforTakeAway(unObsecuredInputandPayment);

    // Widget unobscureInputandRestforTakeAway(Order unObsecuredInputandPayment) {
    //   CustomerInformation currentUser = unObsecuredInputandPayment
    //       .orderingCustomer;

    print('at VV VV ^^ ^^ unobscureInputandRestDeliveryPhone.......\" \"\" ');

    print(
        'showEditingCompleteCustomerAddressInformation: $showEditingCompleteCustomerAddressInformation');
    print(
        'showEditingCompleteCustomerHouseFlatIformation: $showEditingCompleteCustomerHouseFlatIformation');
    print(
        'showEditingCompleteCustomerPhoneIformation : $showEditingCompleteCustomerPhoneIformation');
    print(
        'showEditingCompleteCustomerReachoutIformation: $showEditingCompleteCustomerReachoutIformation');
    print(
        'allCustomerInputsCompleted(unObsecuredInputandPayment.orderingCustomer):'
            ' ${allCustomerInputsCompleted(unObsecuredInputandPayment.orderingCustomer)} ');

    return Container(
      height: displayHeight(context) / 2.2,
      width: displayWidth(context) / 1.03,
      // color:Colors.lightBlueAccent,

      child: Container(
        height:
        displayHeight(context) / 2.2 - displayHeight(context) / 20 - 100,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: ((takeAwayDinningTimeInputCompleted(
              unObsecuredInputandPayment.orderingCustomer) ==
              true)

              // 911_3
              //     work_3

              &&
              (showEditingCompleteCustomerReachoutIformation == true))
              ? animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
              unObsecuredInputandPayment)
              : Container(
            // color:Colors.lightBlueAccent,
            // color: Color(0xffFFFFFF),
            child: Container(
              // color:Colors.red,
              height: displayHeight(context) / 18,
              width: displayWidth(context) / 1.03,
              child: whenYouWillPickTheOrder(unObsecuredInputandPayment),
            )
            // child:  whenYouWillPickTheOrder(unObsecuredInputandPayment),
            ,
          ),
        ),
      ),
    );
// GGG),

    // }
  }

  Widget _buildShoppingCartInputFieldsUNObscuredPhone(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;

    CustomerInformation currentUser = x;

    print(
        'currentUser.address:--should be null or empty..... ${currentUser.address}');
    print(
        'currentUser.flatOrHouseNumber: --should be null or empty..... ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

    // work 1
    // return unobscureInputandOthersPhone(unObsecuredInputandPayment);

    // Widget unobscureInputandOthersPhone(Order unObsecuredInputandPayment) {

    // CustomerInformation currentUser = unObsecuredInputandPayment.orderingCustomer;

    print('at VV VV ^^ ^^ unobscureInputandRestDeliveryPhone.......\" \"\" ');

    print(
        'showEditingCompleteCustomerAddressInformation: $showEditingCompleteCustomerAddressInformation');
    print(
        'showEditingCompleteCustomerHouseFlatIformation: $showEditingCompleteCustomerHouseFlatIformation');
    print(
        'showEditingCompleteCustomerPhoneIformation : $showEditingCompleteCustomerPhoneIformation');
    print(
        'showEditingCompleteCustomerReachoutIformation: $showEditingCompleteCustomerReachoutIformation');
    print(
        'inputsForPhoneOrderTypeCompleted(unObsecuredInputandPayment.orderingCustomer):'
            ' ${inputsForPhoneOrderTypeCompleted(unObsecuredInputandPayment.orderingCustomer)}');

    return Container(
      height: displayHeight(context) / 2.2,
      width: displayWidth(context) / 1.03,
      child: Container(
        height:
        displayHeight(context) / 2.2 - displayHeight(context) / 20 - 100,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: ((inputsForPhoneOrderTypeCompleted(
              unObsecuredInputandPayment.orderingCustomer) ==
              true) &&
              (showEditingCompleteCustomerPhoneIformation == true) &&
              (showEditingCompleteCustomerReachoutIformation == true))
              ? animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
              unObsecuredInputandPayment)
              : Container(
            color: Color(0xffFFFFFF),
            child: Center(
//              child: inputFieldsDelivery(unObsecuredInputandPayment),
              child:
              inputFieldsPhoneOrderType(unObsecuredInputandPayment),
            ),
          ),
        ),
      ),
    );
// GGG),
//     }
  }

// work 3
  Widget _buildShoppingCartInputFieldsUNObscuredDelivery(
      Order unObsecuredInputandPayment) {
    CustomerInformation x = unObsecuredInputandPayment.orderingCustomer;
    //if(getOneOrdercustomerInfoFieldsNotEmpty(x)!=0){

    print('...._buildShoppingCartInputFieldsUNObscuredDelivery....  ...... ');

    CustomerInformation currentUser = x;

    print('currentUser.address: ${currentUser.address}');
    print('currentUser.flatOrHouseNumber: ${currentUser.flatOrHouseNumber}');
    print('currentUser.phoneNumber: ${currentUser.phoneNumber}');
    print('currentUser.etaTimeInMinutes: ${currentUser.etaTimeInMinutes}');

    // return unobscureInputandRestDeliveryPhone(unObsecuredInputandPayment);

    // Widget unobscureInputandRestDeliveryPhone(Order unObsecuredInputandPayment) {

    // CustomerInformation currentUser = unObsecuredInputandPayment.orderingCustomer;

    print('at VV VV ^^ ^^ unobscureInputandRestDeliveryPhone.......\" \"\" ');

    print(
        'showEditingCompleteCustomerAddressInformation: $showEditingCompleteCustomerAddressInformation');
    print(
        'showEditingCompleteCustomerHouseFlatIformation: $showEditingCompleteCustomerHouseFlatIformation');
    print(
        'showEditingCompleteCustomerPhoneIformation : $showEditingCompleteCustomerPhoneIformation');
    print(
        'showEditingCompleteCustomerReachoutIformation: $showEditingCompleteCustomerReachoutIformation');
    print(
        'allCustomerInputsCompleted(unObsecuredInputandPayment.orderingCustomer):'
            ' ${allCustomerInputsCompleted(unObsecuredInputandPayment.orderingCustomer)} ');

    return Container(
      height: displayHeight(context) / 2.2,
      width: displayWidth(context) / 1.03,
      child: Container(
        height:
        displayHeight(context) / 2.2 - displayHeight(context) / 20 - 100,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: ((allCustomerInputsCompleted(
              unObsecuredInputandPayment.orderingCustomer) ==
              true) &&
              (showEditingCompleteCustomerAddressInformation == true) &&
              (showEditingCompleteCustomerHouseFlatIformation == true) &&
              (showEditingCompleteCustomerPhoneIformation == true) &&
              (showEditingCompleteCustomerReachoutIformation == true))
              ? animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
              unObsecuredInputandPayment)
              : Container(
            color: Color(0xffFFFFFF),
            child: Center(
              child: inputFieldsDelivery(unObsecuredInputandPayment),
            ),
          ),
        ),
      ),
    );
// GGG),

    // }
  }

  Widget _buildShoppingCartInputFieldsObscured(
      CustomerInformation obscuredDisplay) {
    CustomerInformation currentUser = obscuredDisplay;
    // THIS INFORMATION ABOVE IS NOT USED NOW.

    return Center(
        child: Container(
//                  color: Colors.green,
//                    color:Colors.white.withOpacity(0.9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Enter user address',
                      style: TextStyle(
                        color: Color(0xffFC0000),
                        fontSize: 30,
                      ),
                    )),

                // CUSTOMER LOCATION ADDRESS CONTAINER BEGINS HERE.
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],

                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.location_on,

                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),
                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          controller: addressController,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
                            focusColor: Color(0xffFC0000),
//                                                            fillColor: Color(0xffFC0000),
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter delivery location',
                            hintStyle:
                            TextStyle(color: Color(0xffFC0000), fontSize: 17),

//                                      currentUser
//                                        labelText: 'Search about meal.'
                          ),
                          onChanged: (text) {
                            //RRRR

                            final shoppingCartBloc =
                            BlocProvider.of<ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setAddressForOrder(text);

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderDeliveryType = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            }
//                            showFullOrderType = false;
                            );
                          },
                          onTap: () {
                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderDeliveryType = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            });
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },



                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                          */

                          style: TextStyle(color: Color(0xffFC0000), fontSize: 16),
                        ),
                      )

//                                  Spacer(),

//                                  Spacer(),
                    ],
                  ),
                ),

                // CUSTOMER LOACATION ADDRESS CONTAINER ENDS HERE.

                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER BEGINS HERE.
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],

                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.home,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),
                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter House/Flat address/number',
                            hintStyle:
                            TextStyle(color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),
                          onChanged: (text) {
                            final shoppingCartBloc =
                            BlocProvider.of<ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setHouseorFlatNumberForOrder(text);

                            setState(() {
                              // showFullOrderType = false;
                              showFullOrderDeliveryType = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                                showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;

                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                              showFullOrderType = false;
                            });
                          },
                          onTap: () {
                            setState(() {
//                              showFullOrderType = false;

                              // showFullOrderType = false;
                              showFullOrderDeliveryType = false;
                              // showFullOrderType = false;
                              // showFullOrderType
                              /* WHEN CHANGE showFullOrderType CHANGE BELOW THIS 2 BOOLEAN STATE'S */
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.

//                              showFullOrderType = false;
                            });
                          },
                          /*

                                                            onEditingComplete: (){
                                                              logger.i('onEditingComplete  of condition 4');
                                                              print('called onEditing complete');
                                                              setState(() => _searchString = "");
                                                            },

                                                            onSubmitted: (String value) async {
                                                              await showDialog<void>(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                    title: const Text('Thanks!'),
                                                                    content: Text ('You typed "$value".'),
                                                                    actions: <Widget>[
                                                                      FlatButton(
                                                                        onPressed: () { Navigator.pop(context); },
                                                                        child: const Text('OK'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },

                                                            */

                          style: TextStyle(color: Color(0xffFC0000), fontSize: 16),
                        ),
                      )

//                                  Spacer(),

//                                  Spacer(),
                    ],
                  ),
                ),

                // CUSTOMER HOUSE || FLAT NUMBER CONTAINER ENDS HERE.

                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER BEGINS HERE.
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],

                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.phone,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),
                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(16),
                            WhitelistingTextInputFormatter.digitsOnly,
//                            WhitelistingTextInputFormatter(RegExp("[0-9]"))
//                            WhitelistingTextInputFormatter(RegExp("[+]"))
                          ],
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter phone / telephone number',

                            hintStyle:
                            TextStyle(color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),
                          style: TextStyle(color: Color(0xffFC0000), fontSize: 16),
                          onChanged: (text) {
                            print("33: $text");

                            final shoppingCartBloc =
                            BlocProvider.of<ShoppingCartBloc>(context);
//
                            shoppingCartBloc.setPhoneNumberForOrder(text);

                            setState(() {
                              showFullOrderDeliveryType = false;
//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            });
                          },
                          onTap: () {
                            setState(() {
                              showFullOrderDeliveryType = false;

//                              showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showUserInputOptionsLikeFirstTime = false;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            });
                          },
                        ),
                      )

//                                  Spacer(),

//                                  Spacer(),
                    ],
                  ),
                ),

                // CUSTOMER PHONE || MOBILE NUMBER CONTAINER ENDS HERE.

                // CUSTOMER LOCATION REACH OUT TIME CONTAINER BEGINS HERE.

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  decoration: BoxDecoration(
//                                      shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xffBCBCBD),
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),

                    boxShadow: [
                      BoxShadow(
//                                            color: Color.fromRGBO(250, 200, 200, 1.0),
                          color: Color(0xffFFFFFF),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 2.0))
                    ],

                    color: Color(0xffFFFFFF),
//                                      Colors.black54
                  ),

//                                  color: Color(0xffFFFFFF),
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 24,
                  padding: EdgeInsets.only(left: 4, top: 3, bottom: 3, right: 3),
                  child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
//                        height: 25,
                        height: displayHeight(context) / 40,
                        width: 5,
                        margin: EdgeInsets.only(left: 0),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                        child: Icon(
//                                          Icons.add_shopping_cart,
                          Icons.watch_later,
                          size: 28,
                          color: Color(0xffBCBCBD),
                        ),
                      ),

                      Container(
//                                        margin:  EdgeInsets.only(
//                                          right:displayWidth(context) /32 ,
//                                        ),
                        alignment: Alignment.center,
                        width: displayWidth(context) / 4,
//                                        color:Colors.purpleAccent,
                        // do it in both Container
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
//                                            prefixIcon: new Icon(Icons.search),
//                                        borderRadius: BorderRadius.all(Radius.circular(5)),
//                                        border: Border.all(color: Colors.white, width: 2),
                            border: InputBorder.none,
                            hintText: 'Enter reach out time',
                            hintStyle:
                            TextStyle(color: Color(0xffFC0000), fontSize: 17),

//                                        labelText: 'Search about meal.'
                          ),
                          style: TextStyle(color: Color(0xffFC0000), fontSize: 16),
                          onChanged: (text) {
                            print("0444: $text");

                            print("33: $text");
                            final shoppingCartBloc =
                            BlocProvider.of<ShoppingCartBloc>(context);

                            shoppingCartBloc.setETAForOrder(text);
                            setState(() {
                              showFullOrderDeliveryType = false;

//                            showCustomerInformationHeader = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                              showUserInputOptionsLikeFirstTime = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              showFullOrderDeliveryType = false;
//                              showCustomerInformationHeader = false;
                              showUserInputOptionsLikeFirstTime = false;
                              showCustomerInformationHeader = true;
                              showFullPaymentType =
                              true; // default.// NOTHING TO DO WITH INPUT FIELDS.
                            });
                          },
                        ),
                      )

//                                  Spacer(),

//                                  Spacer(),
                    ],
                  ),
                ),

                // CUSTOMER LOCATION REACH OUT TIME CONTAINER ENDS HERE.
              ],
            )));
  }

  Widget animatedUnObscuredPaymentUnSelectContainerPhoneOnly(
      Order unObsecuredInputandPayment) {
    print('at animated Un Obscured Card UnSelect Container');
    return Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            width: displayWidth(context) / 1.03,
//                                            width: displayWidth(context) * 0.57,

            // Work 5.
            child: Container(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                child: showFullPaymentType == false
                    ? animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
                    unObsecuredInputandPayment)
                    : _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    unObsecuredInputandPayment),
              ),
            )
          //HHHH

        ),
        Container(
//            alignment: Alignment.center,
          /*
    padding: EdgeInsets.fromLTRB(displayWidth(context)/3,
                0, 0, 0),


            */

          width: displayWidth(context) / 1.03,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 0),
//
            child: showFullPaymentType == false
                ? animatedUnObscuredCancelPayButtonDeliveryPhone(
                unObsecuredInputandPayment)
                : animatedObscuredCancelPayButtonDeliveryPhone(
                unObsecuredInputandPayment),
          ),
        ),
      ],
    );
  }

  Widget animatedUnObscuredPaymentUnSelectContainerDeliveryPhone(
      Order unObsecuredInputandPayment) {
    print('at animated Un Obscured  Payment UnSelect Container Delivery Phone');
    return Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            width: displayWidth(context) / 1.03,
            child: Container(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 0),
//
                child: showFullPaymentType == false
                    ? animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
                    unObsecuredInputandPayment)
                    : _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                    unObsecuredInputandPayment),
              ),
            )),
        Container(
          width: displayWidth(context) / 1.03,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 0),
//
            child: showFullPaymentType == false
                ? animatedUnObscuredCancelPayButtonDeliveryPhone(
                unObsecuredInputandPayment)
                : animatedObscuredCancelPayButtonDeliveryPhone(
                unObsecuredInputandPayment),
          ),
        ),
      ],
    );
  }

  Widget animatedObscuredCancelPayButtonTakeAwayDinning(Order cancelPaySelect) {
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return AbsorbPointer(
      child: Opacity(
        opacity: 0.2,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: displayWidth(context) / 4,
                height: displayHeight(context) / 24,
                child: OutlineButton(
                  onPressed: () {
                    print(
                        'Cancel Pressed obscured animatedObscuredCancelPayButtonTakeAwayDinning');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                  },
                  color: Color(0xffFC0000),
                  // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                  borderSide: BorderSide(
                    color: Color(0xffFC0000), // 0xff54463E
                    style: BorderStyle.solid,
                    width: 7.6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Container(
//              alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xffFC0000),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: displayWidth(context) / 12,
              ),
              Container(
                width: displayWidth(context) / 4,
//                  width:displayWidth(context)/3.1,
                height: displayHeight(context) / 24,
                child: OutlineButton(
                  onPressed: () async {
                    print('obscure pay');
                  },
                  color: Colors.green,
                  // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
                  borderSide: BorderSide(
                    color: Colors.green, // 0xff54463E
                    style: BorderStyle.solid,
                    width: 7.6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Container(
//              alignment: Alignment.center,

                    //OBSCURE PAY

                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget animatedObscuredCancelPayButtonDeliveryPhone(Order cancelPaySelect) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Cancel Pay Button()');
    return AbsorbPointer(
      child: Opacity(
        opacity: 0.2,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: displayWidth(context) / 4,
                height: displayHeight(context) / 24,
                child: RaisedButton(
                  onPressed: () {
                    print('Cancel Pressed obscured delivery phone obscured');
//                    onPressed: _testPrintDummyDe
//                    return Navigator.pop(context,true);
                  },
                  color: Color(0xffFC0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Container(
                    child: Text(
                      //'peruuta'.toUpperCase(),
                      'cancel'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: displayWidth(context) / 12,
              ),
              Container(
                width: displayWidth(context) / 4,
                height: displayHeight(context) / 24,
                child: RaisedButton(
                  onPressed: () async {
                    print(
                        'pay button Pressed obscured delivery phone obscured');
                  },
                  color: Colors.green,
                  // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Container(
//              alignment: Alignment.center,

                    // PAY OBSCURED DELIVERY PHONE...
                    child: Text(
                      /*'maksaa */ 'pay'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget animatedUnObscuredCancelPayButtonTakeAwayDinning(
      Order cancelPaySelectUNObscuredTakeAwayDinning) {
    //  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animatedUnObscuredCancelPayButtonTakeAwayDinning()');
    return Container(
      margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: displayWidth(context) / 4,
            height: displayHeight(context) / 24,
            child: OutlineButton(
              color: Color(0xffFC0000),
              // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
              borderSide: BorderSide(
                color: Color(0xffFC0000), // 0xff54463E
                style: BorderStyle.solid,
                width: 7.6,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Container(
//              alignment: Alignment.center,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xffFC0000),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                print(
                    'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');

                /*
                        cancelPaySelect.page=1;
                        return Navigator.of(context).pop(
                            BlocProvider<ShoppingCartBloc>(
                                bloc: ShoppingCartBloc(cancelPaySelect),
                            child:
                            BlocProvider<FoodGalleryBloc>(
                                bloc: FoodGalleryBloc(),
                                child: FoodGallery2()
                            )
                        ),);
                        */

                print(
                    'debug print before invoking _stopScanDevices(); in cancelPaySelectUNObscuredTakeAway cancel button ');
                _stopScanDevices();
                print(
                    'debug print after invoking _stopScanDevices(); in cancelPaySelectUNObscuredTakeAway cancel button');

                final shoppingCartBloc =
                BlocProvider.of<ShoppingCartBloc>(context);
                shoppingCartBloc.clearSubscription();

                cancelPaySelectUNObscuredTakeAwayDinning.isCanceled = true;

                return Navigator.pop(
                    context, cancelPaySelectUNObscuredTakeAwayDinning);

//                  return Navigator.pop(context,expandedFoodReturnTemp);
              },
            ),
          ),
          SizedBox(
            width: displayWidth(context) / 12,
          ),
          Container(
            width: displayWidth(context) / 4,
            height: displayHeight(context) / 24,
            child: OutlineButton(
              color: Colors.green,
              // clipBehavior:Clip.hardEdge,
//            ContinuousRectangleBorder
//            BeveledRectangleBorder
//            RoundedRectangleBorder
              borderSide: BorderSide(
                color: Colors.green, // 0xff54463E
                style: BorderStyle.solid,
                width: 7.6,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Container(
//              alignment: Alignment.center,

                // PAY UNOBSCURED DINNING TAKEAWAY.
                child: Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              onPressed: () async {
                // TAkEAWAY AND DINNING DUMMY PRINT ....
                final shoppingCartBloc =
                BlocProvider.of<ShoppingCartBloc>(context);

                print(
                    'cancelPaySelect.paymentTypeIndex: ${cancelPaySelectUNObscuredTakeAwayDinning.paymentTypeIndex}');

                // PRINTING CODES WILL BE PUTTED HERE.

                print(
                    'debug print before invoking _startScanDevices(); in cancelPaySelectUNObscuredTakeAway || pay button');

                Order tempOrderWithdocId =
                await shoppingCartBloc.paymentButtonPressed(
                    cancelPaySelectUNObscuredTakeAwayDinning);

                if ((cancelPaySelectUNObscuredTakeAwayDinning
                    .paymentButtonPressed ==
                    true) &&
                    (cancelPaySelectUNObscuredTakeAwayDinning.orderdocId ==
                        '')) {
                  _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                      .showSnackBar(
                      SnackBar(content: Text("someThing went wrong")));
                  print('something went wrong');
                } else {
                  print(
                      'tempOrderWithdocId.orderdocId: ${cancelPaySelectUNObscuredTakeAwayDinning.orderdocId}');

                  List<PrinterBluetooth> blueToothDevicesState =
                      shoppingCartBloc.getDevices;

                  print(
                      'blueToothDevicesState.length: ${blueToothDevicesState.length}');

                  BluetoothDevice _x = new BluetoothDevice();
                  _x.name = 'Restaurant Printer';
                  _x.address = '0F:02:18:51:23:46';
                  _x.type = 3;
                  _x.connected = null;

                  PrinterBluetooth x = new PrinterBluetooth(_x);

                  _testPrintDummyDevices(x);

                  shoppingCartBloc.clearSubscription();

                  print('Unboscured takeAway || '
                      'DinningRoom Dummy print--- returning to FoodGallery Page');
                  return Navigator.pop(
                      context, cancelPaySelectUNObscuredTakeAwayDinning);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog2(String message) async {
    logger.e('in showMyDialog2');
    print(' at the beginning of  _showMyDialog2 ....');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$message'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return Home page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// animatedUnObscuredCancelPayButton
// animatedUnObscuredCancelPayButtonDeliveryPhone
  Widget animatedUnObscuredCancelPayButtonDeliveryPhone(
      Order cancelPaySelectUnobscuredDeliveryPhone) {
    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animatedUnObscuredCancelPayButtonDeliveryPhone Pay Button()');
    return Container(
      margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: displayWidth(context) / 4,
            height: displayHeight(context) / 24,
            child: RaisedButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Container(
//              alignment: Alignment.center,
                child: Text(
                  //'peruuta'.toUpperCase(),
                  'cancel'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                print(
                    'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');

                print(
                    'debug print before invoking _stopScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button ');
                _stopScanDevices();
                print(
                    'debug print after invoking _stopScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button');

                final shoppingCartBloc =
                BlocProvider.of<ShoppingCartBloc>(context);
                shoppingCartBloc.clearSubscription();

//                  List<SelectedFood> expandedFoodReturnTemp= new List<SelectedFood>(0);
//                  shoppingCartBloc.getExpandedSelectedFood;
                cancelPaySelectUnobscuredDeliveryPhone.isCanceled = true;

                /*
                  //MIGHT NOT BE NECESSARY.
                  setState(() {
                    localScanAvailableState = !localScanAvailableState;
                  });
                  */

                return Navigator.pop(
                    context, cancelPaySelectUnobscuredDeliveryPhone);
//                  return Navigator.pop(context,cancelPaySelect);

//                  return Navigator.pop(context,expandedFoodReturnTemp);
              },
            ),
          ),
          SizedBox(
            width: displayWidth(context) / 12,
          ),
          Container(
            width: displayWidth(context) / 4,
            height: displayHeight(context) / 24,
            child: RaisedButton(
              color: Colors.green,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Container(
//              alignment: Alignment.center,

                //    cancel Pay Select Unobscured Delivery Phone
                child: Text(
                  /*'maksaa */ 'pay'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              onPressed: () async {
                // Delivery Phone Recite Print.

                final shoppingCartBloc =
                BlocProvider.of<ShoppingCartBloc>(context);

                print(
                    'cancelPaySelect.paymentTypeIndex Delivery Phone Recite Print..: '
                        '${cancelPaySelectUnobscuredDeliveryPhone.paymentTypeIndex}');

                // let's not use this order returned use the one from the bloc:
                // Order tempOrderWithdocId
                Order tempOrderWithdocId =
                await shoppingCartBloc.paymentButtonPressed(
                    cancelPaySelectUnobscuredDeliveryPhone);

                if ((cancelPaySelectUnobscuredDeliveryPhone
                    .paymentButtonPressed ==
                    true) &&
                    (cancelPaySelectUnobscuredDeliveryPhone.orderdocId == '')) {
                  _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
                      SnackBar(content: Text("someThing went wrong")));
                  print('something went wrong');
                } else {
                  logger.i(
                      'tempOrderWithdocId.orderdocId: ${cancelPaySelectUnobscuredDeliveryPhone.orderdocId}');

                  List<PrinterBluetooth> blueToothDevicesState =
                      shoppingCartBloc.getDevices;

                  print(
                      'blueToothDevicesState.length: ${blueToothDevicesState.length}');

                  if (blueToothDevicesState.length == 0) {
                    logger.i('___________ blueTooth device not found _____');

                    await _showMyDialog2(
                        '___________ blueTooth device not found _____ delivery phone pay button');

                    print(
                        'at here... __________ blueTooth device not found _____ delivery phone pay button');

                    shoppingCartBloc.clearSubscription();
                    return Navigator.pop(
                        context, cancelPaySelectUnobscuredDeliveryPhone);
                  } else {
                    bool found = false;
                    int index = -1;
                    for (int i = 0; i < blueToothDevicesState.length; i++) {
                      ++index;

                      print(
                          'blueToothDevicesState[$i].name: ${blueToothDevicesState[i].name}');
                      print(
                          'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i].address}');

                      if ((blueToothDevicesState[i].name ==
                          'Restaurant Printer') ||
                          (blueToothDevicesState[i].address ==
                              '0F:02:18:51:23:46')) {
                        found = true;
                        break;

                        // _testPrint(oneBlueToothDevice);

                      }
                    }
                    ;

                    logger.w('check device listed or not');
                    print('index: $index');
                    print('found == true ${found == true}');

                    if (found == true) {
                      print('found == true');
                      bool printResult =
                      await _testPrint(blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);

                      if (printResult == true) {
                        logger.i('printResult==true i.e. print successfull');
                        shoppingCartBloc.clearSubscription();
                        return Navigator.pop(
                            context, cancelPaySelectUnobscuredDeliveryPhone);
                      } else {
                        logger.i('printResult!=true i.e. print UN successfull');
                        shoppingCartBloc.clearSubscription();
                        return Navigator.pop(
                            context, cancelPaySelectUnobscuredDeliveryPhone);
                      }
                    } else {
                      logger.i(
                          '___________ Restaurant Printer,  not listed ... _____ printing wasn\'t successfull');

                      await _showMyDialog2(
                          '___________ Restaurant Printer... not listed ...  printing wasn\'t successfull _____');

                      shoppingCartBloc.clearSubscription();
                      print(
                          'going to food Gallery page  Restaurant Printer not found');
                      return Navigator.pop(
                          context, cancelPaySelectUnobscuredDeliveryPhone);
                    }
                  }
                }
              },

              // ---
            ),
          ),
        ],
      ),
    );
  }

  // work 4
  Widget animatedWidgetShowSelectedPaymentTypeDeliveryPhone(
      Order unObsecuredInputandPayment) {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    // work -3
    return Container(
//      color:Colors.deepOrange,
      height: displayHeight(context) / 8.2,
      child: StreamBuilder(
          stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
          initialData: shoppingCartbloc.getCurrentPaymentType,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
              return Container(child: Text('Null'));
            } else {
              List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect =
                  snapshot.data;

              PaymentTypeSingleSelect selectedOne =
              allPaymentTypesSingleSelect.firstWhere(
                      (onePaymentType) => onePaymentType.isSelected == true);

              _currentPaymentTypeIndex = selectedOne.index;
//              logger.e('selectedOne.index',selectedOne.index);
              String paymentTypeName = selectedOne.paymentTypeName;
              String paymentIconName = selectedOne.paymentIconName;
              String borderColor = selectedOne.borderColor;
              const Color OrderTypeIconColor = Color(0xff070707);

              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
//                      width: displayWidth(context) / 1.03-60 /* for example*/,
                      width: ((displayWidth(context) / 1.03) - 40),
//                      height: displayHeight(context) / 10,
                      height: displayHeight(context) / 11.2,

//                      color: Colors.red,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        shape: BoxShape.rectangle,
                      ),
//                      color: Color(0xffffffff),
                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
//                            color:Colors.greenAccent,
                            width: displayWidth(context) / 2.5,
                            height: displayHeight(context) / 20,

//                            color: Color(0xffffffff),

                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    alignment: Alignment.center,
                                    child: Text(/*'maksu tapa' */ 'payment method'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                          color: Color(0xff000000),
                                        )),
                                  ),
                                ]),
                          ),
                          // THE ABOVE PART DEALS WITH LINES AND TEXT,
                          // BELOW PART HANDLES RAISED BUTTON WITH SELECTED DELIVERY TYPE ICON:
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Text('TOTAL : ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFC0000),
                                    )),
                                Text(
                                    '${(unObsecuredInputandPayment.totalPrice
                                        /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
                                        '\u20AC',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFC0000),
                                    ))
                              ],
                            ),
                          ),

                          Container(
//                            width: 100,
                            width: displayWidth(context) / 8,
                            height: displayHeight(context) / 11,

                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      width: 100,
                                      height: displayHeight(context) / 15,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF4F6CE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        getIconForName(paymentTypeName),
                                        color: Colors.black,
                                        size: displayHeight(context) / 30,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showFullPaymentType = !showFullPaymentType;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelectedTakeAway(
      Order unObsecuredInputandPayment) {
    //XYZ
    return Container(
//        color: Colors.blueGrey,
      color: Colors.white,
      height: displayHeight(context) /
          20 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
          displayHeight(context) / 7 /* HEIGHT OF MULTI SELECT PORTION */,
      child: Column(
        children: <Widget>[
          Container(
            width: displayWidth(context) / 1.03,
            height: displayHeight(context) / 20,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: displayWidth(context) / 1.5,
                  height: displayHeight(context) / 20,
                  color: Color(0xffffffff),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          alignment: Alignment.center,
                          child: Text('Payment Method',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff000000),
                              )),
                        ),
                        CustomPaint(
                          size: Size(0, 19),
                          painter: LongPainterForPaymentUnSelected(context),
                        ),
                      ]),
                ),
              ],
            ),
          ),

//            GYG
          // 2ND CONTAINER HOLDS THE total price BEGINS HERE..
          Container(
            padding: EdgeInsets.fromLTRB(300, 0, 10, 0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Text('TOTAL : ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                      color: Color(0xffFC0000),
                    )),
                Text(
                    '${(unObsecuredInputandPayment.totalPrice
                        /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
                        '\u20AC',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,

//                    fontStyle: FontStyle.italic,
                      color: Color(0xffFC0000),
                    ))
              ],
            ),
          ),

          Container(
            color: Colors.white,
//              color:Colors.white,
//                                            height: 200,
            height: displayHeight(context) / 9,
            width: displayWidth(context) - displayWidth(context) / 5,
//                                            width: displayWidth(context) * 0.57,
            child: _buildPaymentTypeSingleSelectOption(),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
      Order unObsecuredInputandPayment) {
    return Container(
      height: displayHeight(context) /
          11 /* HEIGHT OF CHOOSE ORDER TYPE TEXT PORTION */ +
          displayHeight(context) / 7 /* HEIGHT OF MULTI SELECT PORTION */,
      child: Column(
        children: <Widget>[
          Container(
            width: ((displayWidth(context) / 1.03) - 40),
            height: displayHeight(context) / 18,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: displayWidth(context) / 2.5,
                  height: displayHeight(context) / 20,
                  color: Color(0xffffffff),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.center,
                          child: Text(/*'maksu tapa' */ 'payment method'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                                color: Color(0xff000000),
                              )),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Text(/*'Summa : '*/ 'TOTAL'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color(0xffFC0000),
                          )),
                      Text(
                          '${(unObsecuredInputandPayment.totalPrice
                              /* * unObsecuredInputandPayment.totalPrice */).toStringAsFixed(2)} '
                              '\u20AC',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
//                                                        fontFamily: 'GreatVibes-Regular',

//                    fontStyle: FontStyle.italic,
                            color: Color(0xffFC0000),
                          ))
                    ],
                  ),
                ),

                /* Total Text ends here...*/
              ],
            ),
          ),
          Container(
            color: Colors.white,
//                                            height: 200,
            height: displayHeight(context) / 9,
            width: displayWidth(context) / 1.03,
            child: _buildPaymentTypeSingleSelectOption(),
          ),
        ],
      ),
    );
  }

  int getNumberOfInputsFilledUpDinningRoom(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }

    print('-----  ||  ** **  **TOTAL : $total');
    return total;

//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }
  }

  int getNumberOfInputsFilledUpTakeAway(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }

    print('-----  ||  ** **  **TOTAL : $total');
    return total;

//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }
  }

  int getNumberOfInputsFilledUpPhoneOrder(
      CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    /*
    switch (customerInfoFieldsCheck.address
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber
        .trim()
        .length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    */
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }

    print('-----  ||  ** **  **TOTAL : $total');
    return total;

//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }
  }

  int getNumberOfInputsFilledUp(CustomerInformation customerInfoFieldsCheck) {
    print(' U   U    U  ?   U   ? getNumberOfInputsFilledUp');
    int total = 0;
    switch (customerInfoFieldsCheck.address.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.flatOrHouseNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.phoneNumber.trim().length) {
      case 0:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }
    switch (customerInfoFieldsCheck.etaTimeInMinutes) {
      case -1:
        total = total + 0;
        break;
      default:
        total = total + 1;
    }

    print('-----  ||  ** **  **TOTAL : $total');
    return total;

//    else{
//      return false;
//      // empty; 3 inputs are not filled.
//    }
  }

  IconData getIconForName(String iconName) {
    print('iconName at getIconForName: $iconName');
    switch (iconName) {
      case 'facebook':
        {
//        return FontAwesomeIcons.facebook;
          return FontAwesomeIcons.facebook;
        }
        break;

      case 'twitter':
        {
          return FontAwesomeIcons.twitter;
        }
        break;
      case 'TakeAway':
        {
          return Icons.work;
        }
        break;
      case 'Delivery':
        {
          return Icons.local_shipping;
        }
        break;
      case 'Phone':
        {
          return Icons.phone_in_talk;
        }
        break;
      case 'DinningRoom':
        {
          return Icons.fastfood;
        }

      case 'Card':
        {
          return FontAwesomeIcons.solidCreditCard;
        }
        break;
      case 'Cash':
        {
          return FontAwesomeIcons.moneyBill;
        }
        break;
      case 'Later':
        {
          return FontAwesomeIcons.bookmark;
        }
        break;

      default:
        {
          return FontAwesomeIcons.home;
        }
    }
  }

//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSingleDeliveryType(OrderTypeSingleSelect x, int index) {
    String orderTypeName = x.orderType;
//    String orderIconName = x.orderIconName;
    String orderTyepImage = x.orderTyepImage;
    String borderColor = x.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(
//      color:Colors.blue,
//        width:  displayWidth(context) /6,
//        height: displayWidth(context) /6,
      width: displayWidth(context) / 5,
      height: displayHeight(context) / 11,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: index == _currentOrderTypeIndex
          ? InkWell(
        splashColor: Colors.deepOrangeAccent,
        highlightColor: Colors.indigo,
        child: Column(
          children: <Widget>[
            new Container(
              width: displayWidth(context) / 5,
              height: displayHeight(context) / 10.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                child: Image.asset(
                  orderTyepImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: Text(
                orderTypeName.toUpperCase(),
                style: TextStyle(
                    color: Color(0xffFC0000),
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
            ),
          ],
        ),
        onTap: () {
          logger.i(
              'on tap preesed on unselected order list_ orderTypeName: $orderTypeName ');
          final shoppingCartBloc =
          BlocProvider.of<ShoppingCartBloc>(context);

          shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(
              x, index, _currentOrderTypeIndex);

          setState(() {
            showFullOrderDeliveryType = !showFullOrderDeliveryType;

            showEditingCompleteCustomerAddressInformation = false;
            showEditingCompleteCustomerHouseFlatIformation = false;
            showEditingCompleteCustomerPhoneIformation = false;
            showEditingCompleteCustomerReachoutIformation = false;
          });
        },
      )
          : InkWell(
        splashColor: Colors.deepOrangeAccent,
        highlightColor: Colors.indigo,
        child: Column(
          children: <Widget>[
            new Container(
              width: displayWidth(context) / 5,
              height: displayHeight(context) / 10.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 2.0,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
                child: Image.asset(
                  orderTyepImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: Text(
                orderTypeName,
                style: TextStyle(
                    color: Color(0xffFC0000),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ],
        ),
        onTap: () {
          logger.i(
              'on tap preesed on unselected order list_ orderTypeName: $orderTypeName ');
          final shoppingCartBloc =
          BlocProvider.of<ShoppingCartBloc>(context);

          shoppingCartBloc.setOrderTypeSingleSelectOptionForOrder(
              x, index, _currentOrderTypeIndex);

          setState(() {
            showFullOrderDeliveryType = !showFullOrderDeliveryType;
            showCustomerInformationHeader = true;
            showUserInputOptionsLikeFirstTime = true;
            // MAKEING THEM AS THEY ARE IN THE FIRST TIME:

            showEditingCompleteCustomerAddressInformation = false;
            showEditingCompleteCustomerHouseFlatIformation = false;
            showEditingCompleteCustomerPhoneIformation = false;
            showEditingCompleteCustomerReachoutIformation = false;

            // WE ARE oneSingleDeliveryType;
//            showFullPaymentType = false;  = true; // default.// NOTHING TO DO WITH INPUT FIELDS.
          });
        },
      ),
//      ),
//      ),
    );
  }

  Widget animatedObscuredPaymentSelectContainerTakeAwayDinning(
      Order priceandselectedCardFunctionality) {
//  Widget animatedObscuredTextInputContainer(){
//    child:  AbsorbPointer(
//        child: _buildShoppingCartInputFields()
//    ),

    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return Container(
      height: displayWidth(context) / 2.5,
      child: AbsorbPointer(
        child: Opacity(
          opacity: 0.2,
          child: Container(
              color: Colors.greenAccent,
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              width: displayWidth(context) / 1.03,
              child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                  priceandselectedCardFunctionality)),
        ),
      ),
    );
  }

  Widget animatedObscuredPaymentSelectContainer(
      Order priceandselectedCardFunctionality) {
    print(' < >  <   >    << TT       >>  \\    '
        ' Widget name: '
        'animated Obscured Card Select Container()');
    return Container(
      height: displayWidth(context) / 2.5,
      child: AbsorbPointer(
        child: Opacity(
          opacity: 0.2,
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: displayWidth(context) / 1.03,
              child: _buildShoppingCartPaymentMethodsUNObscuredUnSelected(
                  priceandselectedCardFunctionality)),
        ),
      ),
    );
  }

  bool zeroORMoreInputsEmptyDinningRoom(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1) {
      print('WILL RETURN FALSE');
      return false;
    } else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }

  bool zeroORMoreInputsEmptyTakeAway(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if
//    (customerInfoFieldsCheck.address.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0)
//        &&
//        (customerInfoFieldsCheck.phoneNumber.trim().length >0)
//        &&
    (customerInfoFieldsCheck.etaTimeInMinutes != -1) {
      print('WILL RETURN FALSE');
      return false;
    } else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }

  bool zeroORMoreInputsEmptyPhone(CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber}'
        ' A :${customerInfoFieldsCheck.address} '
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if ((customerInfoFieldsCheck.phoneNumber.trim().length > 0) &&
        (customerInfoFieldsCheck.etaTimeInMinutes != -1)) {
      print('WILL RETURN FALSE');
      return false;
    } else {
      print('WILL RETURN TRUE');
      return true; // empty; one or more of the user inputs are.
    }
  }

  // bool allCustomerInputsCompleted(CustomerInformation customerInfoFieldsCheck) {
  bool takeAwayDinningTimeInputCompleted(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber} ,\n'
        ' A :${customerInfoFieldsCheck.address}  ,\n'
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}  ,\n'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}  ,\n'
        'Hour : ${customerInfoFieldsCheck.etaTimeOfDay.hour}  ,\n');

    if ((customerInfoFieldsCheck.etaTimeInMinutes != -1) ||
        ((customerInfoFieldsCheck.etaTimeOfDay.hour != 0) ||
            (customerInfoFieldsCheck.etaTimeOfDay.minute != 0))) {
      print('WILL RETURN FALSE');
      return true;
    } else {
      print('WILL RETURN TRUE');
      return false; // empty; one or more of the user inputs are.
    }
  }

//  bool allCustomerInputsCompleted(CustomerInformation customerInfoFieldsCheck) {
  bool inputsForPhoneOrderTypeCompleted(
      CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber} ,\n'
        ' A :${customerInfoFieldsCheck.address}  ,\n'
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}  ,\n'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}  ,\n'
        'Hour : ${customerInfoFieldsCheck.etaTimeOfDay.hour}  ,\n');

    if ((customerInfoFieldsCheck.phoneNumber.trim().length > 0) &&
        ((customerInfoFieldsCheck.etaTimeInMinutes != -1) ||
            ((customerInfoFieldsCheck.etaTimeOfDay.hour != 0) ||
                (customerInfoFieldsCheck.etaTimeOfDay.minute != 0)))) {
      print('WILL RETURN FALSE');
      return true;
    } else {
      print('WILL RETURN TRUE');
      return false; // empty; one or more of the user inputs are.
    }
  }

  bool allCustomerInputsCompleted(CustomerInformation customerInfoFieldsCheck) {
    print(
        ' ??? ??? ||| at zeroORMoreInputsEmpty check for Card Opacity effect and untouchable effect: ');
    print('customerInfoFieldsCheck '
        ' FH :${customerInfoFieldsCheck.flatOrHouseNumber} ,\n'
        ' A :${customerInfoFieldsCheck.address}  ,\n'
        ' ETA : ${customerInfoFieldsCheck.etaTimeInMinutes}  ,\n'
        ' PH : ${customerInfoFieldsCheck.phoneNumber}  ,\n'
        'Hour : ${customerInfoFieldsCheck.etaTimeOfDay.hour}  ,\n');

//    assert(customerInfoFieldsCheck.address.trim().length >0);
//    assert(customerInfoFieldsCheck.flatOrHouseNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.phoneNumber.trim().length >0);
//    assert(customerInfoFieldsCheck.etaTimeInMinutes != -1);
    if ((customerInfoFieldsCheck.address.trim().length > 0) &&
        (customerInfoFieldsCheck.flatOrHouseNumber.trim().length > 0) &&
        (customerInfoFieldsCheck.phoneNumber.trim().length > 0) &&
        (customerInfoFieldsCheck.etaTimeInMinutes != -1) ||
        ((customerInfoFieldsCheck.etaTimeOfDay.hour != 0) ||
            (customerInfoFieldsCheck.etaTimeOfDay.minute != 0))) {
      print('WILL RETURN FALSE');
      return true;
    } else {
      print('WILL RETURN TRUE');
      return false; // empty; one or more of the user inputs are.
    }
  }

  Widget _buildPaymentTypeSingleSelectOption() {
    final shoppingCartbloc = BlocProvider.of<ShoppingCartBloc>(context);

    return StreamBuilder(
        stream: shoppingCartbloc.getCurrentPaymentTypeSingleSelectStream,
        initialData: shoppingCartbloc.getCurrentPaymentType,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(child: Text('Null'));
          } else {
            List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect =
                snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('paymentTypes: $allPaymentTypesSingleSelect');

            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: allPaymentTypesSingleSelect.length,
                itemBuilder: (_, int index) {
                  return oneSinglePaymentType(
                      allPaymentTypesSingleSelect[index], index);
                },
              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }

//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSinglePaymentType(
      PaymentTypeSingleSelect onePaymentType, int index) {
    String paymentTypeName = onePaymentType.paymentTypeName;
    String paymentIconName = onePaymentType.paymentTypeName;
    String borderColor = onePaymentType.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(
      child: index == _currentPaymentTypeIndex
          ? Container(
//        color: Colors.purple,
        width: displayWidth(context) / 6.5,
        height: displayHeight(context) / 11,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[
                new Container(
                  width: displayWidth(context) / 4.5,
                  height: displayHeight(context) / 12.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    getIconForName(paymentTypeName),
                    color: Color(0xffFC0000),
                    size: displayWidth(context) / 18,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName,
                    style: TextStyle(
                        color: Color(0xffFC0000),
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {
            final shoppingCartBloc =
            BlocProvider.of<ShoppingCartBloc>(context);

            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(
                onePaymentType, index, _currentPaymentTypeIndex);

            // work 0 august 20...
            logger.e('index: $index');
            print('YY YY  $index  YY   YY    ');
            if (index == 0) {
//              0 means later option...

              print(' 0 means later option...');

              // TAkEAWAY AND DINNING  Recite Print. ....
              final shoppingCartBloc =
              BlocProvider.of<ShoppingCartBloc>(context);
              print('later button pressed....:');

              Order tempOrderWithdocId =
              await shoppingCartBloc.paymentButtonPressedLater();

              if (tempOrderWithdocId.orderdocId == '') {
                _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
                    SnackBar(content: Text("someThing went wrong")));
                print('something went wrong');
              } else {
                logger.i(
                    'tempOrderWithdocId.orderdocId: ${tempOrderWithdocId.orderdocId}');

                shoppingCartBloc.clearSubscription();
                print(
                    'going to food \" cancelPaySelectUNObscuredTakeAwayDinning \" Gallery page   Restaurant Printer not found');

                return Navigator.pop(context, tempOrderWithdocId);
              }
            } else {
              setState(() {
                showFullPaymentType = false;
              });
            }
          },
        ),
      )
          : Container(
        width: displayWidth(context) / 6.5,
        height: displayHeight(context) / 10,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: <Widget>[
                new Container(
                  width: displayWidth(context) / 4.5,
                  height: displayHeight(context) / 12.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    getIconForName(paymentTypeName),
                    color: Colors.grey,
                    size: displayWidth(context) / 18,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName,
                    style: TextStyle(
                        color: Color(0xffFC0000),
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {
            final shoppingCartBloc =
            BlocProvider.of<ShoppingCartBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            shoppingCartBloc.setPaymentTypeSingleSelectOptionForOrder(
                onePaymentType, index, _currentPaymentTypeIndex);

            // work 0 august 20...
            logger.e('index: $index');
            print('YY YY  $index  YY   YY    ');
            if (index == 0) {
//              0 means later option...

              print(' 0 means later option...');

              // TAkEAWAY AND DINNING  Recite Print. ....
              final shoppingCartBloc =
              BlocProvider.of<ShoppingCartBloc>(context);
              print('later button pressed....:');

              Order tempOrderWithdocId =
              await shoppingCartBloc.paymentButtonPressedLater();

              if (tempOrderWithdocId.orderdocId == '') {
                _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                    .showSnackBar(
                    SnackBar(content: Text("someThing went wrong")));
                print('something went wrong');
              } else {
                logger.i(
                    'tempOrderWithdocId.orderdocId: ${tempOrderWithdocId.orderdocId}');

                shoppingCartBloc.clearSubscription();
                print(
                    'going to food \" cancelPaySelectUNObscuredTakeAwayDinning \" Gallery page   Restaurant Printer not found');

                return Navigator.pop(context, tempOrderWithdocId);
              }
            } else {
              setState(() {
                showFullPaymentType = false;
              });
            }
          },
        ),
      ),
    );
  }

  Widget showMultiSelectStrings(List<String> multiSelectStrings) {
//    if(multiSelectStrings.length==)

    print('multiSelectStrings: $multiSelectStrings');

    print('multiSelectStrings == null: ${multiSelectStrings == null}');

    if (multiSelectStrings == null)
      return Text('');
    else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        reverse: false,
        shrinkWrap: false,
        itemCount: multiSelectStrings.length,
        itemBuilder: (_, int index) {
          return displayOneMultiSelectString(multiSelectStrings[index], index);
        },
      );
    }
  }

// DUMMY RECITE RELATED PRINT CODES ARE HERE ==> LINE # 11264 ==>

//  showExtraIngredients(oneFood.selectedIngredients)
//  showExtraCheeseItems(oneFood.selectedCheeses)
//  showExtraSauces(oneFood.defaultSauces)

  Widget showExtraIngredients(
      List<NewIngredient> reciteIngrdients, int quantity) {
    print('reciteIngrdients.length: ${reciteIngrdients.length}');
    return ListView.builder(
      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteIngrdients.length,
      itemBuilder: (_, int index) {
        return displayOneExtraIngredientInRecite(
            reciteIngrdients[index], index, quantity);
      },
    );
  }

  Widget showExtraCheeseItems(
      List<CheeseItem> reciteCheeseItems, int quantity) {
    print('reciteCheeseItems.length: ${reciteCheeseItems.length}');
    return ListView.builder(
      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteCheeseItems.length,
      itemBuilder: (_, int index) {
        return displayOneExtraCheeseItemInRecite(
            reciteCheeseItems[index], index, quantity);
      },
    );
  }

  Widget showExtraSauces(List<SauceItem> reciteSauceItems, int quantity) {
    print('reciteSauceItems.length: ${reciteSauceItems.length}');
    return ListView.builder(
      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: reciteSauceItems.length,
      itemBuilder: (_, int index) {
        return displayOneExtraSauceItemInRecite(
            reciteSauceItems[index], index, quantity);
      },
    );
  }

  Widget displayOneMultiSelectString(String oneMultiSelectString, int index) {
    print('oneMultiSelectString:_____ _____ ______  ${oneMultiSelectString}');

    if (oneMultiSelectString != "") {
      return Text(
        '$oneMultiSelectString',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 17,
          fontFamily: 'Itim-Regular',
        ),
      );
    } else
      return Text('');
  }

  Widget displayOneExtraIngredientInRecite(
      NewIngredient oneIngredientForRecite, int index, int quantity) {
    print(
        'oneIngredientForRecite.ingredientName: ${oneIngredientForRecite.ingredientName}');

    if (oneIngredientForRecite.isDefault == false) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
//              '+SauceItem: $quantity'+'X',
              '+: $quantity' + 'X',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',
              ),
            ),
            Text(
              ' ##: ${((oneIngredientForRecite.ingredientName == null) || (oneIngredientForRecite.ingredientName.length == 0)) ? '----' : oneIngredientForRecite.ingredientName.length > 18 ? oneIngredientForRecite.ingredientName.substring(0, 15) + '...' : oneIngredientForRecite.ingredientName}',
              /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 17, fontFamily: 'Itim-Regular',
              ),
            ),
            Text(
              '  +${(oneIngredientForRecite.price * quantity).toStringAsFixed(2)}',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
          ],
        ),
      );
    } else if (oneIngredientForRecite.isDeleted == true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${((oneIngredientForRecite.ingredientName == null) || (oneIngredientForRecite.ingredientName.length == 0)) ? '----' : oneIngredientForRecite.ingredientName.length > 18 ? oneIngredientForRecite.ingredientName.substring(0, 15) + '...' : oneIngredientForRecite.ingredientName}',
              /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.lineThrough,
                fontSize: 25,
                fontFamily: 'Itim-Regular',
              ),
            ),
          ],
        ),
      );
    } else
      return Container(height: 0, width: 0);
  }

  Widget displayOneExtraSauceItemInRecite(
      SauceItem oneSauceItemForRecite, int index, int quantity) {
    print(
        'oneSauceItemForRecite.ingredientName: ${oneSauceItemForRecite.sauceItemName}');

    if (oneSauceItemForRecite.isDefaultSelected != true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              ' ** : $quantity' + 'X',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
            Text(
              '${((oneSauceItemForRecite.sauceItemName == null) || (oneSauceItemForRecite.sauceItemName.length == 0)) ? '---' : oneSauceItemForRecite.sauceItemName.length > 18 ? oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' : oneSauceItemForRecite.sauceItemName}',
              /*
          Text(
              '${oneSauceItemForRecite.sauceItemName} ',
              */

              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
            Text(
              '  +${(oneSauceItemForRecite.price * quantity).toStringAsFixed(2)}',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
          ],
        ),
      );
    } else if (oneSauceItemForRecite.isDeleted == true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${((oneSauceItemForRecite.sauceItemName == null) || (oneSauceItemForRecite.sauceItemName.length == 0)) ? '---' : oneSauceItemForRecite.sauceItemName.length > 18 ? oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' : oneSauceItemForRecite.sauceItemName}',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.lineThrough,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
          ],
        ),
      );
    } else
      return Container(height: 0, width: 0);
  }

  Widget displayOneExtraCheeseItemInRecite(
      CheeseItem oneCheeseItemForRecite, int index, int quantity) {
    print(
        'oneCheeseItemForRecite.ingredientName: ${oneCheeseItemForRecite.cheeseItemName}');
    if (oneCheeseItemForRecite.isDefaultSelected != true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              ' ++ : $quantity' + 'X',
//              '+Ingre.: $quantity'+'X',

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',
              ),
            ),
            Text(
              '${((oneCheeseItemForRecite.cheeseItemName == null) || (oneCheeseItemForRecite.cheeseItemName.length == 0)) ? '---' : oneCheeseItemForRecite.cheeseItemName.length > 18 ? oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' : oneCheeseItemForRecite.cheeseItemName}',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),

            /*

            Text('${((oneIngredientForRecite.ingredientName == null) ||
      (oneIngredientForRecite.ingredientName.length == 0)) ?
      '----' : oneIngredientForRecite.ingredientName.length > 18 ?
      oneIngredientForRecite.ingredientName.substring(0, 15) + '...' :
      oneIngredientForRecite.ingredientName}',
            /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 17, fontFamily: 'Itim-Regular',),
            ),

            */
            Text(
              '  +${(oneCheeseItemForRecite.price * quantity).toStringAsFixed(2)}',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
          ],
        ),
      );
    } else if (oneCheeseItemForRecite.isDeleted == true) {
      return Container(
        height: 40,
        width: 220,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${((oneCheeseItemForRecite.cheeseItemName == null) || (oneCheeseItemForRecite.cheeseItemName.length == 0)) ? '---' : oneCheeseItemForRecite.cheeseItemName.length > 18 ? oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' : oneCheeseItemForRecite.cheeseItemName}',
              textAlign: TextAlign.left,
              style: TextStyle(
//                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.lineThrough,
//                        color: Color(0xffF50303),
                fontSize: 25, fontFamily: 'Itim-Regular',
              ),
            ),
          ],
        ),
      );
    } else
      return Container(height: 0, width: 0);
  }

  Widget displayOneFoodInformation(OrderedItem oneFood, int index) {
    print('index: : : : $index');

    List<NewIngredient> extraIngredient = oneFood.selectedIngredients;
    List<SauceItem> extraSauces = oneFood.selectedSauces;
    List<CheeseItem> extraCheeseItems = oneFood.selectedCheeses;

    List<String> multiSelectStrings2 = oneFood.multiSelectString;

    print('multiSelectStrings2: $multiSelectStrings2');

    print('extraIngredient: $extraIngredient');
    print('extraSauces: $extraSauces');
    print('extraCheeseItems: $extraCheeseItems');

    List<NewIngredient> onlyExtraIngredient = extraIngredient
        .where((e) => ((e.isDefault != true) || (e.isDeleted == true)))
        .toList();
    List<SauceItem> onlyExtraSauces = extraSauces
        .where((e) => ((e.isDefaultSelected != true) || (e.isDeleted == true)))
        .toList();
    List<CheeseItem> onlyExtraCheeseItems = extraCheeseItems
        .where((e) => ((e.isDefaultSelected != true) || (e.isDeleted == true)))
        .toList();

    print('onlyExtraIngredient: $onlyExtraIngredient');

    print('onlyExtraSauces: $onlyExtraSauces');

    print('onlyExtraCheeseItems: $onlyExtraCheeseItems');

    /*
    List<NewIngredient> defaultIngredientsLaterAdded
    = defaultIngredients.where((oneDefaultIngredient) =>
    oneDefaultIngredient.isDefault!=true).toList();

    */

//    List<String> categories = [];
//    orderedItems.forEach((oneFood) {
//
//
//      if((categories==null) || (categories.length==0) || (categories.contains(oneFood.category)==false) ) {
//        ticket.text('${oneFood.category.toString()}',
//            styles: PosStyles(
//              height: PosTextSize.size1,
//              width: PosTextSize.size1,
//              bold: true,
//              align: PosAlign.center,
//            )
//        );
//      }
//
//      categories.add(oneFood.category);

//    List<String> categories = [];

    return Container(
      height: 940,
      width: 350,
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            width: 350,
            alignment: Alignment.center,
            child: Text(
              '${oneFood.category.toString()}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
//                        color: Color(0xffF50303),
                fontSize: 20, fontFamily: 'Itim-Regular',
              ),
            ),
          ),
          Container(
            height: 50,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${oneFood.name.toString()}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  'X${oneFood.quantity}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${oneFood.foodItemSize}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  '${(oneFood.unitPriceWithoutCheeseIngredientSauces * oneFood.quantity).toStringAsFixed(2)}',
                  // '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 700,
//              color:Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        'multi Select Strings...............',
                        /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                          decoration: TextDecoration.lineThrough,
                          fontSize: 27,
                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Container(
                          width: 350,
                          height: 210,
                          child: showMultiSelectStrings(multiSelectStrings2)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Ingredient.........',
                        /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                          decoration: TextDecoration.lineThrough,
                          fontSize: 27,
                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Container(
                          width: 350,
                          height: 210,
//                      color:Colors.blue,
                          child: showExtraIngredients(
                              onlyExtraIngredient, oneFood.quantity)),
                    ],
                  ),
                  Divider(
                    height: 10,
//            width: 220,
                    thickness: 5,
                    color: Colors.black,
                  ),
                  Column(
                    children: [
                      Text(
                        'Cheeses.........',
                        /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                          decoration: TextDecoration.lineThrough,
                          fontSize: 27,
                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Container(
                          width: 350,
                          height: 210,
                          color: Colors.orange,
                          child: showExtraCheeseItems(
                              onlyExtraCheeseItems, oneFood.quantity)),
                    ],
                  ),
                  Divider(
                    height: 10,
//            width: 220,
                    thickness: 5,
                    color: Colors.black,
                  ),
                  Column(
                    children: [
                      Text(
                        'Sauces.........',
                        /*
            Text(
              '${oneIngredientForRecite.ingredientName}', */

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                          decoration: TextDecoration.lineThrough,
                          fontSize: 27,
                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Container(
                          width: 350,
                          height: 210,
                          color: Colors.deepPurpleAccent,
                          child: showExtraSauces(
                              onlyExtraSauces, oneFood.quantity)),
                    ],
                  ),
                ],
              )),
          Divider(
            height: 20,
//            width: 220,
            thickness: 5,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget processFoodForRecite(List<OrderedItem> orderedItems) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: orderedItems.length,
      itemBuilder: (_, int index) {
        return displayOneFoodInformation(orderedItems[index], index);
      },
    );
  }

  Future<void> dummyPrintDialog(
      OneOrderFirebase oneOrderForReceipt,
      Uint8List restaurantNameImageByte2,
      ) async {
    print('restaurantNameImageByte2: $restaurantNameImageByte2');

    CustomerInformation customerForReciteGeneration =
        oneOrderForReceipt.oneCustomer;

    List<OrderedItem> orderedItems = oneOrderForReceipt.orderedItems;

    print('oneOrderForReceipt.timeOfDay: ${oneOrderForReceipt.timeOfDay}');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
//                    color:Colors.green,
                    width: 200,
                    height: 40,
                    child: Image.memory(restaurantNameImageByte2)),

                Divider(
                  height: 10,
                  thickness: 5,
                  color: Colors.black,
                ),

                Container(
                  child:

                  // 2 ends here.
                  Text(
                    'Order No: from F.S. Cloud Function',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',
                    ),
                  ),
                ),

                Divider(
                  height: 10,
                  thickness: 5,
                  color: Colors.black,
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${oneOrderForReceipt.formattedOrderPlacementDatesTimeOnly}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),

                      // 2 ends here.

                      // 911_1
                      Container(
                        child:
                        oneOrderForReceipt.orderProductionTimeFromNow != -1
                            ? Text(
                          '${oneOrderForReceipt.orderProductionTimeFromNow} min',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
//                        color: Color(0xffF50303),
                            fontSize: 20, fontFamily: 'Itim-Regular',
                          ),
                        )
                            : Text(
                          '${oneOrderForReceipt.timeOfDay.toString()}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
//                        color: Color(0xffF50303),
                            fontSize: 20, fontFamily: 'Itim-Regular',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child:

                  // 2 ends here.
                  Text(
                    '${oneOrderForReceipt.formattedOrderPlacementDate}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
//                        color: Color(0xffF50303),
                      fontSize: 20, fontFamily: 'Itim-Regular',
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // ADDRESS: BEGINS HERE.

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'address: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${((customerForReciteGeneration.address == null) || (customerForReciteGeneration.address.length == 0)) ? '----' : customerForReciteGeneration.address.length > 21 ? customerForReciteGeneration.address.substring(0, 18) + '_ _' : customerForReciteGeneration.address}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),

                      // 2 ends here.
                      Text(
                        '${customerForReciteGeneration.flatOrHouseNumber}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                // ADDRESS: ENDS HERE.

                // PHONE: BEGINS HERE.

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'phone: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${customerForReciteGeneration.phoneNumber}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                // PHONE: ENDS HERE.

                Divider(
                  height: 30,
                  thickness: 10,
                  color: Colors.black,
                ),

                //  ORDEREDITEMS BEGINS HERE..

//                orderedItems.map((e) => null)

                Container(
                    width: 350,
                    height: 580,
                    child: processFoodForRecite(orderedItems)),

                //  ORDEREDITEMS endS HERE..

                Divider(
                  height: 30,
                  thickness: 8,
                  color: Colors.black,
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'SUBTOTAL: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${oneOrderForReceipt.totalPrice.toStringAsFixed(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'DELIVERY: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${oneOrderForReceipt.deliveryCost.toStringAsFixed(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ALV: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 26, fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${oneOrderForReceipt.tax.toStringAsFixed(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'TOTAL: ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 30, fontFamily: 'Itim-Regular',
                        ),
                      ),

                      // TODO: PROBLEM CODE NEEDS CHECKING....
                      Text(
                        '${(oneOrderForReceipt.priceWithDelivery).toStringAsFixed(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 20, fontFamily: 'Itim-Regular',
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 70,
                  width: 400,
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        //sss
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          oneOrderForReceipt.paidType.toLowerCase() == 'card'
                              ? 'assets/unpaid_cash_card/card.png'
                              : oneOrderForReceipt.paidType.toLowerCase() ==
                              'cash'
                              ? 'assets/unpaid_cash_card/cash.png'
                              : 'assets/unpaid_cash_card/unpaid.png',

//                color: Colors.black,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            oneOrderForReceipt.paidType.toLowerCase() == 'card'
                                ? 'card'
                                : oneOrderForReceipt.paidType.toLowerCase() ==
                                'cash'
                                ? 'cash'
                                : 'unpaid',

//                            oneOrderForReceipt.paidType.toLowerCase() == 'paid' ?
//                            'paid' : 'unpaid',

                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
//                          color: Color(0xffF50303),
                              fontSize: 20, fontFamily: 'Itim-Regular',
                            ),
                          ),
                          SizedBox(width: 50),
                          Text(
                            (oneOrderForReceipt.orderBy.toLowerCase() ==
                                'delivery')
                                ? 'Delivery'
                                : (oneOrderForReceipt.orderBy.toLowerCase() ==
                                'phone')
                                ? 'Phone'
                                : (oneOrderForReceipt.orderBy
                                .toLowerCase() ==
                                'takeaway')
                                ? 'TakeAway'
                                : 'DinningRoom',
//                    oneOrderForReceipt.orderBy
//                    'dinningRoom',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
//                        color: Color(0xffF50303),
                              fontSize: 20, fontFamily: 'Itim-Regular',
                            ),
                          ),
                        ],
                      ),
                      Container(
//                      color: Colors.black,
                        width: 70,
                        height: 70,

                        child: (oneOrderForReceipt.orderBy.toLowerCase() ==
                            'delivery')
                            ? Image.asset(
                          'assets/orderBYicons/delivery.png',
                          color: Colors.black,
                          width: 50,
                          height: 50,
                        )
                            : (oneOrderForReceipt.orderBy.toLowerCase() ==
                            'phone')
                            ? Image.asset('assets/phone.png',
                            color: Colors.black, width: 50, height: 50)
                            : (oneOrderForReceipt.orderBy.toLowerCase() ==
                            'takeaway')
                            ? Image.asset(
                          'assets/orderBYicons/takeaway.png',
                          color: Colors.black,
                          width: 50,
                          height: 50,
                        )
                            : Image.asset(
                          'assets/orderBYicons/diningroom.png',
                          color: Colors.black,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),

//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/* invoker -->

              printTicketDummy2(
              /*paper, */
                thisRestaurant,
                oneOrderData,
                imageRestaurant,
                restaurantNameBytesNotFuture,
                // orderInformationAndUserInformationTopInBytes,
                Uint8List orderInformationForReciteWidgetBytes2,
                Uint8List customerInformationOnlyBytes2,
                totalCostDeliveryBytes,
                paidUnpaidDeliveryTypeInBytes);
          }).catchError((onError) {

  * */
  void printTicketDummy2(
      /*PaperSize paper, */
      Restaurant currentRestaurant,
      OneOrderFirebase oneOrderdocument,
      ImageAliasAnotherSource.Image imageResource,
//      Uint8List orderInformationAndUserInformationTopInBytes,
      /*
      Uint8List orderInformationForReciteWidgetBytes2,
      Uint8List customerInformationOnlyBytes2, */
      Uint8List restaurantNameImageBytes,
      /* Uint8List totalCostDeliveryBytes2,*/
      /*Uint8List paidUnpaidDeliveryTypeWidgetBytes2 */
      ) async {
    print(' came here: printTicketDummy');

//    final PosPrintResult res =
//    await printerManager.printTicket(await demoReceipt(paper,currentRestaurant, oneOrderdocument));

//    showToast('res.msg  res.msg   res.msg');

    dummyPrintDialog(
      oneOrderdocument,
      restaurantNameImageBytes,
//        orderInformationAndUserInformationTopInBytes,
      /*
      orderInformationForReciteWidgetBytes2,
      customerInformationOnlyBytes2,

      totalCostDeliveryBytes2,

     */
      /*paidUnpaidDeliveryTypeWidgetBytes2 */
    );
  }

  String sanitize(String nameInput) {
//    String nameInput2 = nameInput.replaceAll(new RegExp(r'e'), 'Ã©');
//
//    print(nameInput2);

    String nameInput3 = nameInput.replaceAll(new RegExp(r"'"), "\'");

    print(nameInput3);

    return nameInput3;
  }

/*
    Future<Ticket> demoReceiptOrderTypeDelivery(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {

  */
// # number 1: demoReceipt Order Type TakeAway begins here...

  Future<Ticket> demoReceiptOrderTypeTakeAway(
      PaperSize paper,
      Restaurant thisRestaurant3, // not required but just for printing...
      OneOrderFirebase
      oneOrderData3, // oneOrderData3.orderedItems --> for loop print..
      Uint8List restaurantNameBytesNotFuture3,
      ) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');

    CustomerInformation customerForReciteGeneration = oneOrderData3.oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print(
        'customerForReciteGeneration.address: ${customerForReciteGeneration.address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration.flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration.phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration.etaTimeInMinutes}');
    print(
        'restaurantNameBytesNotFuture3---takeAway---> : $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print(
        'oneOrderListdocument.orderProductionTimeFromNow: ${oneOrderData3.orderProductionTimeFromNow}');

    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata =
    await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes =
    faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage =
    ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);

    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata =
    await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage =
    ImageAliasAnotherSource.decodeImage(handsdataBytes);

    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData =
    await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage =
    ImageAliasAnotherSource.decodeImage(deliveryDataBytes);

    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage =
    ImageAliasAnotherSource.decodeImage(phonedataBytes);

    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData =
    await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage =
    ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);

    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData =
    await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage =
    ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);

    //0.... printing codes starts here..

    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource.Image oneImageRestaurant =
    ImageAliasAnotherSource.decodeImage(restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch: '=', len: null, linesAfter: 1);

    if (oneOrderData3.orderProductionTimeFromNow == -1) {
      ticket.text(
          '${oneOrderData3.formattedOrderPlacementDatesTimeOnly}' +
              '     ' +
              '${oneOrderData3.timeOfDay.toString()}',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          ));
    } else {
      ticket.text(
          '${oneOrderData3.formattedOrderPlacementDatesTimeOnly}' +
              '     ' +
              '${oneOrderData3.orderProductionTimeFromNow} min',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          ));
    }

    //    ticket.feed(2);

    // 3 ... address: .... + flat

    /*

    ticket.text('address: ${((customerForReciteGeneration.address == null) ||
        (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    // 4 ... phone: phone
    ticket.text('phone: ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));


    ticket.feed(1);

    */
    ticket.hr(ch: '.', len: null, linesAfter: 0);

    // 5... processFoodForRecite

    Set<String> categories = {};

//    List<String> categories = [];
    orderedItems.forEach((oneFood) {
      if ((categories == null) ||
          (categories.length == 0) ||
          (categories.contains(oneFood.category) == false)) {
        ticket.text('${oneFood.category.toString()}',
            styles: PosStyles(
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              bold: true,
              align: PosAlign.center,
            ));
      }

      categories.add(oneFood.category);

      ticket.feed(1);

      List<NewIngredient> extraIngredient = oneFood.selectedIngredients;
      List<SauceItem> extraSauces = oneFood.selectedSauces;
      List<CheeseItem> extraCheeseItems = oneFood.selectedCheeses;

      List<String> multiSelectStrings2 = oneFood.multiSelectString;

//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

//      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<NewIngredient> onlyExtraIngredient = extraIngredient
          .where((e) => ((e.isDefault != true) || (e.isDeleted == true)))
          .toList();

      List<SauceItem> onlyExtraSauces = extraSauces
          .where(
              (e) => ((e.isDefaultSelected != true) || (e.isDeleted == true)))
          .toList();

      List<CheeseItem> onlyExtraCheeseItems = extraCheeseItems
          .where(
              (e) => ((e.isDefaultSelected != true) || (e.isDeleted == true)))
          .toList();

//      List<SauceItem> onlyExtraSauces       =
//      extraSauces.where((e) => e.isDefaultSelected != true).toList();

//      List<CheeseItem>    onlyExtraCheeseItems  =
//      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');

      // 5.... (name and quantity) + (size and price )
      ticket.row([
        PosColumn(
            text: '${sanitize(oneFood.name)}',
            width: 5,
            styles: PosStyles(
              align: PosAlign.left,
            )),
        PosColumn(
          text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */
        ),
        PosColumn(
            text: 'X${oneFood.quantity}',
            width: 5,
            styles: PosStyles(
              align: PosAlign.right,
            )),
      ]);

      ticket.row([
        PosColumn(
            text: '${oneFood.foodItemSize}',
            width: 5,
            styles: PosStyles(align: PosAlign.left)),
        PosColumn(
          text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */
        ),
        PosColumn(
            text:
            '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',
            width: 5,
            styles: PosStyles(
              align: PosAlign.right,
            )),
      ]);



      if (multiSelectStrings2.length > 0) {
        multiSelectStrings2.forEach((oneMultiSelectString) {

          ticket.row([
            PosColumn(
                text:'# $oneMultiSelectString',
                width: 9,
                styles: PosStyles(
                  align: PosAlign.left,
                )),

            PosColumn(
                text:'',
                width: 3, styles: PosStyles(align: PosAlign.right)),


          ]);
        });
      }

// 5.2 --- extra ingredients...
      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {

          if(oneIngredientForRecite.isDeleted==false) {
            ticket.row([
              PosColumn(
                  text:'+ ${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' :oneIngredientForRecite.ingredientName.length > 18
                      ?oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text:'${oneIngredientForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text:'- ${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '', width: 3, styles: PosStyles(align: PosAlign.right)),
            ]);
          }
        });
      }

      // extra cheeseItems...
      if (onlyExtraSauces.length > 0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {
          if (oneSauceItemForRecite.isDeleted == false) {
            ticket.row([
              PosColumn(
                  text:'+ ${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([
              PosColumn(
                  text:'- ${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18
                      ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...'
                      :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text:'',
                  width: 3, styles: PosStyles(align: PosAlign.right)),
            ]);

          }
          ;
        });
      }

      // extra sauceItems...
      if (onlyExtraCheeseItems.length > 0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {
          if (oneCheeseItemForRecite.isDeleted == false) {
            ticket.row([


              PosColumn(text: '+ ${((oneCheeseItemForRecite.cheeseItemName == null) ||
                  (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
              '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
              oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
              oneCheeseItemForRecite.cheeseItemName}',
                  width: 9,styles: PosStyles(

                    align: PosAlign.left,
                  )),

              PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                  width: 3,styles: PosStyles(align: PosAlign.right)),


            ]);}
          else{
            ticket.row([
              PosColumn(
                  text:'- ${((oneCheeseItemForRecite.cheeseItemName == null) ||
                      (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
                  '----' : oneCheeseItemForRecite.cheeseItemName.length > 18
                      ?
                  oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...'
                      :
                  oneCheeseItemForRecite.cheeseItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '', width: 3, styles: PosStyles(align: PosAlign.right)),
            ]);
          }
          ;
        });
      }

      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch: '_', len: null, linesAfter: 1);
//      ticket.feed(1);
    });

    // Price 1 subtotal
    ticket.row([
      PosColumn(
        text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */
      ),
      PosColumn(
        text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */
      ),
      PosColumn(
          text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,
          styles: PosStyles(
              align: PosAlign.right, codeTable: PosCodeTable.westEur)),
    ]);

    /*

    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${00.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);
    */

//    ticket.hr();

    ticket.hr(ch: '_', len: null, linesAfter: 0);

    // Price 3  Total
    ticket.row([
      PosColumn(
        text: 'TOTAL',
        styles: PosStyles(bold: true),
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */
      ),
      PosColumn(
        text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */
      ),
      PosColumn(
        text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles: PosStyles(
            bold: true, align: PosAlign.right, codeTable: PosCodeTable.westEur),
        width: 5,
      ),
    ]);

    ticket.feed(1);

    oneOrderData3.paidStatus.toLowerCase() == 'paid'
        ? ticket.image(faceBookLikedataBytesImage, align: PosAlign.center)
        : ticket.image(handsdataBytesImage, align: PosAlign.center);

    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([
      PosColumn(
        text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */
      ),
      PosColumn(
        text:
        '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ? 'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */
      ),
      PosColumn(
        text:
        '${(oneOrderData3.orderBy.toLowerCase() == 'delivery') ? 'Delivery' : (oneOrderData3.orderBy.toLowerCase() == 'phone') ? 'Phone' : (oneOrderData3.orderBy.toLowerCase() == 'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,
      ),
      PosColumn(
        text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */
      ),
    ]);

    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'
        ? ticket.image(deliveryDataBytesImage, align: PosAlign.center)
        : oneOrderData3.orderBy.toLowerCase() == 'phone'
        ? ticket.image(phonedataBytesImage, align: PosAlign.center)
        : oneOrderData3.orderBy.toLowerCase() == 'takeaway'
        ? ticket.image(takeAwayDataBytesImage, align: PosAlign.center)
        : ticket.image(dinningRoomDataBytesImage,
        align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;
  }

// # number 2: demoReceipt Order Type Delivery begins here...

//  restaurantNameImageBytes,totalCostDeliveryBytes2
  Future<Ticket> demoReceiptOrderTypeDelivery(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {
    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');

    CustomerInformation customerForReciteGeneration = oneOrderData3.oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print(
        'customerForReciteGeneration.address: ${customerForReciteGeneration.address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration.flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration.phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration.etaTimeInMinutes}');
    print(
        'restaurantNameBytesNotFuture3 line # 10760: $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print(
        'oneOrderListdocument.orderProductionTimeFromNow: ${oneOrderData3.orderProductionTimeFromNow}');

    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata =
    await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes =
    faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage =
    ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);

    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata =
    await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage =
    ImageAliasAnotherSource.decodeImage(handsdataBytes);

    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData =
    await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage =
    ImageAliasAnotherSource.decodeImage(deliveryDataBytes);

    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage =
    ImageAliasAnotherSource.decodeImage(phonedataBytes);

    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData =
    await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage =
    ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);

    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData =
    await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage =
    ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);

    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource.Image oneImageRestaurant =
    ImageAliasAnotherSource.decodeImage(restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);
    ticket.feed(1);
    ticket.hr(ch: '=', len: null, linesAfter: 0);

    ticket.text('Order No: from F.S. Cloud Function',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true,
          align: PosAlign.center,
        ));

    ticket.hr(ch: '=', len: null, linesAfter: 1);

//    Order No: Cloud Function generated..

    if (oneOrderData3.orderProductionTimeFromNow == -1) {
      ticket.text(
          '${oneOrderData3.formattedOrderPlacementDatesTimeOnly}' +
              '     ' +
              '${oneOrderData3.timeOfDay.toString()}',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          ));
    } else {
      ticket.text(
          '${oneOrderData3.formattedOrderPlacementDatesTimeOnly}' +
              '     ' +
              '${oneOrderData3.orderProductionTimeFromNow} min',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          ));
    }

    ticket.text('${oneOrderData3.formattedOrderPlacementDate}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true,
          align: PosAlign.left,
        ));

//    ticket.feed(1);
    ticket.feed(1);
    ticket.hr(ch: '.', len: null, linesAfter: 0);

//    ticket.feed(1);
    // 3 ... address: .... + flat

    ticket.text(
        '${((customerForReciteGeneration.address == null) || (customerForReciteGeneration.address.length == 0)) ? '----' : customerForReciteGeneration.address.length > 21 ? customerForReciteGeneration.address.substring(0, 18) + '...' : customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true,
          align: PosAlign.left,
        ));

    // 4 ... phone: phone
    ticket.text(
        '${((customerForReciteGeneration.phoneNumber == null) || (customerForReciteGeneration.phoneNumber.length == 0)) ? '----' : customerForReciteGeneration.phoneNumber.length > 21 ? customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' : customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true,
          align: PosAlign.left,
        ));

    ticket.feed(1);
    ticket.hr(ch: '.', len: null, linesAfter: 0);

    // 5... processFoodForRecite

    Set<String> categories = {};

//    List<String> categories = [];
    orderedItems.forEach((oneFood) {
      if ((categories == null) ||
          (categories.length == 0) ||
          (categories.contains(oneFood.category) == false)) {
        ticket.text('${oneFood.category.toString()}',
            styles: PosStyles(
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              bold: true,
              align: PosAlign.center,
            ));
      }

      categories.add(oneFood.category);

      ticket.feed(1);

      List<NewIngredient> extraIngredient = oneFood.selectedIngredients;
      List<SauceItem> extraSauces = oneFood.selectedSauces;
      List<CheeseItem> extraCheeseItems = oneFood.selectedCheeses;
      List<String> multiSelectStrings2 = oneFood.multiSelectString;
//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

//      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<NewIngredient> onlyExtraIngredient = extraIngredient
          .where((e) => ((e.isDefault != true) || (e.isDeleted == true)))
          .toList();

      List<SauceItem> onlyExtraSauces = extraSauces
          .where(
              (e) => ((e.isDefaultSelected != true) || (e.isDeleted == true)))
          .toList();

      List<CheeseItem> onlyExtraCheeseItems = extraCheeseItems
          .where(
              (e) => ((e.isDefaultSelected != true) || (e.isDeleted == true)))
          .toList();

//      List<SauceItem> onlyExtraSauces       =
//      extraSauces.where((e) => e.isDefaultSelected != true).toList();

//      List<CheeseItem>    onlyExtraCheeseItems  =
//      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');

      // 5.... (name and quantity) + (size and price )
      ticket.row([
        PosColumn(
            text: '${sanitize(oneFood.name)}',
            width: 5,
            styles: PosStyles(
              align: PosAlign.left,
            )),
        PosColumn(
          text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */
        ),
        PosColumn(
            text: 'X${oneFood.quantity}',
            width: 5,
            styles: PosStyles(
              align: PosAlign.right,
            )),
      ]);

      ticket.row([
        PosColumn(
            text: '${oneFood.foodItemSize}',
            width: 5,
            styles: PosStyles(align: PosAlign.left)),
        PosColumn(
          text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */
        ),
        PosColumn(
            text:
            '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',
            width: 5,
            styles: PosStyles(
              align: PosAlign.right,
            )),
      ]);


      // multiSelect ...
      if(multiSelectStrings2.length > 0)
      {
        multiSelectStrings2.forEach((oneMultiSelectString) {

          ticket.row([
            PosColumn(
                text:'# $oneMultiSelectString',
                width: 9,
                styles: PosStyles(
                  align: PosAlign.left,
                )),

            PosColumn(
                text:'',
                width: 3, styles: PosStyles(align: PosAlign.right)),


          ]);
        });
      }


      // 5.2 --- extra ingredients...


      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {

          if(oneIngredientForRecite.isDeleted==false) {
            ticket.row([


              PosColumn(
                  text: '+${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text: '- ${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);

          }
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {

          if(oneSauceItemForRecite.isDeleted==false) {
            ticket.row([


              PosColumn(
                  text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text: '- ${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18
                      ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...'
                      :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          ;
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {

          if(oneCheeseItemForRecite.isDeleted==false){
            ticket.row([


              PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                  (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
              '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
              oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
              oneCheeseItemForRecite.cheeseItemName}',
                  width: 9,styles: PosStyles(

                    align: PosAlign.left,
                  )),

              PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                  width: 3,styles: PosStyles(align: PosAlign.right)),


            ]);}
          else{
            ticket.row([


              PosColumn(
                  text: '- ${((oneCheeseItemForRecite.cheeseItemName == null) ||
                      (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
                  '----' : oneCheeseItemForRecite.cheeseItemName.length > 18
                      ?
                  oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...'
                      :
                  oneCheeseItemForRecite.cheeseItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          };
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);


    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.deliveryCost.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);


    ticket.row([


      PosColumn(text: 'ALV',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '14%',
          width: 5,styles:PosStyles(align: PosAlign.right)),

    ]);



//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '${oneOrderData3.priceWithDelivery.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right,codeTable: PosCodeTable.westEur),
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space.

    ticket.cut();
    return ticket;

  }


// demoReceipt Order Type Delivery ends here...

// # number 3: demoReceipt Order Type phone begins here...

// demoReceipt Order Type Phone begins here...
  Future<Ticket> demoReceiptOrderTypePhone(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {


    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderData3
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameBytesNotFuture3 line# 11159: $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print('oneOrderListdocument.orderProductionTimeFromNow: ${oneOrderData3
        .orderProductionTimeFromNow}');




    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata = await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes = faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage
    = ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);


    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata = await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage
    = ImageAliasAnotherSource.decodeImage(handsdataBytes);






    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData = await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage
    = ImageAliasAnotherSource.decodeImage(deliveryDataBytes);


    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage
    = ImageAliasAnotherSource.decodeImage(phonedataBytes);


    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData = await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage
    = ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);


    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData = await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage
    = ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);



    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch:'=',len:null,linesAfter:1);

    if(oneOrderData3.orderProductionTimeFromNow==-1){
      ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}'+'     '
          +'${oneOrderData3.timeOfDay.toString()}',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold:true,
            align: PosAlign.left,
          )
      );
    }else {
      ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}' +
          '     '
          + '${oneOrderData3.orderProductionTimeFromNow} min',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          )
      );
    }

    //    ticket.feed(2);


    // 3 ... address: .... + flat


    /*
    ticket.text('address: ${((customerForReciteGeneration.address == null) ||
        (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );
    */

    // 4 ... phone: phone
    ticket.text('phone: ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));


    ticket.feed(1);
    ticket.hr(ch:'.',len:null,linesAfter:0);

    // 5... processFoodForRecite


    Set<String> categories ={};

//    List<String> categories = [];
    orderedItems.forEach((oneFood) {


      if((categories==null) || (categories.length==0) || (categories.contains(oneFood.category)==false) ) {
        ticket.text('${oneFood.category.toString()}',
            styles: PosStyles(
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              bold: true,
              align: PosAlign.center,
            )
        );
      }

      categories.add(oneFood.category);

      ticket.feed(1);

      List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
      List<SauceItem>     extraSauces       = oneFood.selectedSauces;
      List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;
      List<String> multiSelectStrings2 = oneFood.multiSelectString;
//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

//      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => ((e.isDefault != true)
          ||(e.isDeleted == true)
      )).toList();

      List<SauceItem> onlyExtraSauces       = extraSauces.where((e) => ((e.isDefaultSelected != true)
          ||(e.isDeleted == true))).toList();

      List<CheeseItem>    onlyExtraCheeseItems  = extraCheeseItems.where((e) => ((e.isDefaultSelected != true)
          ||(e.isDeleted == true))).toList();

//      List<SauceItem> onlyExtraSauces       =
//      extraSauces.where((e) => e.isDefaultSelected != true).toList();

//      List<CheeseItem>    onlyExtraCheeseItems  =
//      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');





      // 5.... (name and quantity) + (size and price )
      ticket.row([


        PosColumn(text: '${sanitize(oneFood.name)}',
            width: 5, styles: PosStyles(align: PosAlign.left,
            ) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),

        PosColumn(text: 'X${oneFood.quantity}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),


      ]);

      ticket.row([
        PosColumn(text: '${oneFood.foodItemSize}',
            width: 5,  styles: PosStyles(align: PosAlign.left) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),
      ]);

      // multiselect ...
      if(multiSelectStrings2.length > 0)
      {
        multiSelectStrings2.forEach((oneMultiSelectString) {

          ticket.row([
            PosColumn(
                text:'# $oneMultiSelectString',
                width: 9,
                styles: PosStyles(
                  align: PosAlign.left,
                )),

            PosColumn(
                text:'',
                width: 3, styles: PosStyles(align: PosAlign.right)),


          ]);
        });
      }
      // 5.2 --- extra ingredients...



      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {

          if(oneIngredientForRecite.isDeleted==false) {
            ticket.row([


              PosColumn(
                  text: '+${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),

            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text: '- ${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);

          }
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {

          if(oneSauceItemForRecite.isDeleted==false) {
            ticket.row([


              PosColumn(
                  text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text: '- ${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18
                      ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...'
                      :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);

          }
          ;
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {

          if(oneCheeseItemForRecite.isDeleted==false){
            ticket.row([


              PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                  (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
              '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
              oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
              oneCheeseItemForRecite.cheeseItemName}',
                  width: 9,styles: PosStyles(

                    align: PosAlign.left,
                  )),

              PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                  width: 3,styles: PosStyles(align: PosAlign.right)),


            ]);}
          else{
            ticket.row([


              PosColumn(
                  text: '- ${((oneCheeseItemForRecite.cheeseItemName == null) ||
                      (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
                  '----' : oneCheeseItemForRecite.cheeseItemName.length > 18
                      ?
                  oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...'
                      :
                  oneCheeseItemForRecite.cheeseItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          };
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);


    /*
    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${00.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);

    */

//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right,codeTable: PosCodeTable.westEur),
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;

  }

// demoReceipt Order Type Phone ends here...


// # number 4: demoReceipt Order Type Dinning begins here...

  Future<Ticket> demoReceiptOrderTypeDinning(
      PaperSize paper,
      Restaurant thisRestaurant3,
      OneOrderFirebase oneOrderData3,
      Uint8List restaurantNameBytesNotFuture3,
      ) async {

    //--4

    print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


    CustomerInformation customerForReciteGeneration = oneOrderData3
        .oneCustomer;

    List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

    final Ticket ticket = Ticket(PaperSize.mm58);

    // print('paper.value: ${paper.value}');
    print('currentRestaurant: ${thisRestaurant3.name}');
    print('oneOrderListdocument: $oneOrderData3');
    print('orderedItems: $orderedItems');
    print('customerForReciteGeneration.address: ${customerForReciteGeneration
        .address}');
    print(
        'customerForReciteGeneration.flatOrHouseNumber: ${customerForReciteGeneration
            .flatOrHouseNumber}');
    print(
        'customerForReciteGeneration.phoneNumber: ${customerForReciteGeneration
            .phoneNumber}');
    print(
        'customerForReciteGeneration.etaTimeInMinutes: ${customerForReciteGeneration
            .etaTimeInMinutes}');
    print('restaurantNameImageBytes2 line # 11509: $restaurantNameBytesNotFuture3');
//    print('totalCostDeliveryBytes2______: $totalCostDeliveryBytes3');
    print('oneOrderListdocument.orderProductionTimeFromNow: ${oneOrderData3
        .orderProductionTimeFromNow}');




    //differentImages 1  ==>   faceBookLikedataBytesImage
    final ByteData faceBookLikedata = await rootBundle.load('assets/icons8-facebook-like-64.png');
    final Uint8List faceBookLikedataBytes = faceBookLikedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image faceBookLikedataBytesImage
    = ImageAliasAnotherSource.decodeImage(faceBookLikedataBytes);


    //differentImages 2  ==> handsdataBytesImage
    final ByteData handsdata = await rootBundle.load('assets/icons8-hand-64.png');
    final Uint8List handsdataBytes = handsdata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image handsdataBytesImage
    = ImageAliasAnotherSource.decodeImage(handsdataBytes);






    //differentImages 3 =>  deliveryDataBytesImage
    final ByteData deliveryData = await rootBundle.load('assets/orderBYicons/delivery.png');
    final Uint8List deliveryDataBytes = deliveryData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image deliveryDataBytesImage
    = ImageAliasAnotherSource.decodeImage(deliveryDataBytes);


    //differentImages 4 => phonedataBytesImage
    final ByteData phonedata = await rootBundle.load('assets/phone.png');
    final Uint8List phonedataBytes = phonedata.buffer.asUint8List();

    final ImageAliasAnotherSource.Image phonedataBytesImage
    = ImageAliasAnotherSource.decodeImage(phonedataBytes);


    //differentImages 5  ==> takeAwayDataBytesImage
    final ByteData takeAwayData = await rootBundle.load('assets/orderBYicons/takeaway.png');
    final Uint8List takeAwayDataBytes = takeAwayData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image takeAwayDataBytesImage
    = ImageAliasAnotherSource.decodeImage(takeAwayDataBytes);


    //differentImages 6  ==>  dinningRoomDataBytesImage
    final ByteData dinningRoomData = await rootBundle.load('assets/orderBYicons/diningroom.png');
    final Uint8List dinningRoomDataBytes = dinningRoomData.buffer.asUint8List();

    final ImageAliasAnotherSource.Image dinningRoomDataBytesImage
    = ImageAliasAnotherSource.decodeImage(dinningRoomDataBytes);







    //  printing begins::: //1.... starts...

    //1... RESTAURANT NAME DONE...
    final ImageAliasAnotherSource
        .Image oneImageRestaurant = ImageAliasAnotherSource.decodeImage(
        restaurantNameBytesNotFuture3);

    //    final ImageAliasAnotherSource
    //        .Image oneImageRestaurant = Image.memory(restaurantNameBytesNotFuture3);

    ticket.image(oneImageRestaurant);

    ticket.feed(1);
    ticket.hr(ch:'=',len:null,linesAfter:1);

    if(oneOrderData3.orderProductionTimeFromNow==-1){
      ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}'+'     '
          +'${oneOrderData3.timeOfDay.toString()}',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          )
      );
    }else {
      ticket.text('${oneOrderData3.formattedOrderPlacementDatesTimeOnly}' +
          '     '
          + '${oneOrderData3.orderProductionTimeFromNow} min',
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            bold: true,
            align: PosAlign.left,
          )
      );
    }

    //    ticket.feed(2);


    // 3 ... address: .... + flat

    /*

    ticket.text('address: ${((customerForReciteGeneration.address == null) ||
        (customerForReciteGeneration.address.length == 0)) ?
    '----' : customerForReciteGeneration.address.length > 21 ?
    customerForReciteGeneration.address.substring(0, 18) + '...' :
    customerForReciteGeneration.address}   ${customerForReciteGeneration.flatOrHouseNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        )
    );

    // 4 ... phone: phone
    ticket.text('phone: ${((customerForReciteGeneration.phoneNumber == null) ||
        (customerForReciteGeneration.phoneNumber.length == 0)) ?
    '----' : customerForReciteGeneration.phoneNumber.length > 21 ?
    customerForReciteGeneration.phoneNumber.substring(0, 18) + '...' :
    customerForReciteGeneration.phoneNumber}',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold:true,
          align: PosAlign.left,
        ));


    ticket.feed(1);

    */
    ticket.hr(ch: '.', len: null, linesAfter: 0);

    // 5... processFoodForRecite


    Set<String> categories ={};
    orderedItems.forEach((oneFood) {


      if((categories==null) || (categories.length==0) || (categories.contains(oneFood.category)==false) ) {
        ticket.text('${oneFood.category.toString()}',
            styles: PosStyles(
              height: PosTextSize.size1,
              width: PosTextSize.size1,
              bold: true,
              align: PosAlign.center,
            )
        );
      }

      categories.add(oneFood.category);

      ticket.feed(1);

      List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
      List<SauceItem>     extraSauces       = oneFood.selectedSauces;
      List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;
      List<String> multiSelectStrings2 = oneFood.multiSelectString;
//      print('extraIngredient: $extraIngredient');

//      print('extraSauces: $extraSauces');
//      print('extraCheeseItems: $extraCheeseItems');

//      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();

      List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => ((e.isDefault != true)
          ||(e.isDeleted == true)
      )).toList();

      List<SauceItem> onlyExtraSauces       = extraSauces.where((e) => ((e.isDefaultSelected != true)
          ||(e.isDeleted == true))).toList();

      List<CheeseItem>    onlyExtraCheeseItems  = extraCheeseItems.where((e) => ((e.isDefaultSelected != true)
          ||(e.isDeleted == true))).toList();

//      List<SauceItem> onlyExtraSauces       =
//      extraSauces.where((e) => e.isDefaultSelected != true).toList();

//      List<CheeseItem>    onlyExtraCheeseItems  =
//      extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();

      print('onlyExtraIngredient: $onlyExtraIngredient');

      print('onlyExtraSauces: $onlyExtraSauces');
      print('onlyExtraCheeseItems: $onlyExtraCheeseItems');





      // 5.... (name and quantity) + (size and price )
      ticket.row([


        PosColumn(text: '${sanitize(oneFood.name)}',
            width: 5, styles: PosStyles(align: PosAlign.left,
            ) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),

        PosColumn(text: 'X${oneFood.quantity}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),


      ]);

      ticket.row([
        PosColumn(text: '${oneFood.foodItemSize}',
            width: 5,  styles: PosStyles(align: PosAlign.left) ),
        PosColumn(text: '',
          width: 2, /*,styles: PosStyles(align: PosAlign.left) */),
        PosColumn(text: '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',
            width: 5,styles: PosStyles(

              align: PosAlign.right,
            )),
      ]);

      // multiSelect..
      if(multiSelectStrings2.length > 0)
      {
        multiSelectStrings2.forEach((oneMultiSelectString) {

          ticket.row([
            PosColumn(
                text:'# $oneMultiSelectString',
                width: 9,
                styles: PosStyles(
                  align: PosAlign.left,
                )),

            PosColumn(
                text:'',
                width: 3, styles: PosStyles(align: PosAlign.right)),


          ]);
        });
      }
      // 5.2 --- extra ingredients...



      if(onlyExtraIngredient.length>0) {
        onlyExtraIngredient.forEach((oneIngredientForRecite) {

          if(oneIngredientForRecite.isDeleted==false) {
            ticket.row([


              PosColumn(
                  text: '+${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneIngredientForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text: '- ${((oneIngredientForRecite.ingredientName == null) ||
                      (oneIngredientForRecite.ingredientName.length == 0)) ?
                  '----' : oneIngredientForRecite.ingredientName.length > 18
                      ?
                  oneIngredientForRecite.ingredientName.substring(0, 15) + '...'
                      :
                  oneIngredientForRecite.ingredientName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);

          }
        });
      }

      // extra cheeseItems...
      if(onlyExtraSauces.length>0) {
        onlyExtraSauces.forEach((oneSauceItemForRecite) {

          if(oneSauceItemForRecite.isDeleted==false) {
            ticket.row([


              PosColumn(
                  text: '+${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18 ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...' :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
              )),

              PosColumn(
                  text: ' ${oneSauceItemForRecite.price.toStringAsFixed(2)}',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          }
          else{

            ticket.row([


              PosColumn(
                  text: '- ${((oneSauceItemForRecite.sauceItemName == null) ||
                      (oneSauceItemForRecite.sauceItemName.length == 0)) ?
                  '----' : oneSauceItemForRecite.sauceItemName.length > 18
                      ?
                  oneSauceItemForRecite.sauceItemName.substring(0, 15) + '...'
                      :
                  oneSauceItemForRecite.sauceItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);

          }
          ;
        });
      }

      // extra sauceItems...
      if(onlyExtraCheeseItems.length>0) {
        onlyExtraCheeseItems.forEach((oneCheeseItemForRecite) {

          if(oneCheeseItemForRecite.isDeleted==false){
            ticket.row([


              PosColumn(text: '${((oneCheeseItemForRecite.cheeseItemName == null) ||
                  (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
              '----' : oneCheeseItemForRecite.cheeseItemName.length > 18 ?
              oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...' :
              oneCheeseItemForRecite.cheeseItemName}',
                  width: 9,styles: PosStyles(

                    align: PosAlign.left,
                  )),

              PosColumn(text: ' ${oneCheeseItemForRecite.price.toStringAsFixed(2)}',
                  width: 3,styles: PosStyles(align: PosAlign.right)),


            ]);}
          else{
            ticket.row([


              PosColumn(
                  text: '- ${((oneCheeseItemForRecite.cheeseItemName == null) ||
                      (oneCheeseItemForRecite.cheeseItemName.length == 0)) ?
                  '----' : oneCheeseItemForRecite.cheeseItemName.length > 18
                      ?
                  oneCheeseItemForRecite.cheeseItemName.substring(0, 15) + '...'
                      :
                  oneCheeseItemForRecite.cheeseItemName}',
                  width: 9, styles: PosStyles(

                align: PosAlign.left,
//                reverse: true,
                underline: true,

              )),

              PosColumn(
                  text: '',
                  width: 3, styles: PosStyles(align: PosAlign.right)),


            ]);
          };
        });
      }


      // needed. as per design. when one food Item is printed then an hr added.
      ticket.feed(1);
      ticket.hr(ch:'_',len:null,linesAfter:1);
//      ticket.feed(1);
    });




    // Price 1 subtotal
    ticket.row([
      PosColumn(text: 'SUBTOTAL',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);

    /*

    ticket.row([


      PosColumn(text: 'DELIVERY',
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${00.toStringAsFixed(2)}',
          width: 5,styles:PosStyles(align: PosAlign.right,codeTable: PosCodeTable.westEur)),

    ]);
    */

//    ticket.hr();

    ticket.hr(ch:'_',len:null,linesAfter:0);


    // Price 3  Total
    ticket.row([


      PosColumn(text: 'TOTAL', styles:PosStyles(bold: true)  ,
        width: 5, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),


      PosColumn(text: '${oneOrderData3.totalPrice.toStringAsFixed(2)}',
        styles:PosStyles(bold: true,align: PosAlign.right,codeTable: PosCodeTable.westEur),
        width: 5,),

    ]);

    ticket.feed(1);


    oneOrderData3.paidStatus.toLowerCase() == 'paid'?
    ticket.image(faceBookLikedataBytesImage,align: PosAlign.center):
    ticket.image(handsdataBytesImage,align: PosAlign.center);




    //6 Text "paid || Unpaid && Space "OrderBY"
    //    void image(Image imgSrc, {PosAlign align = PosAlign.center}) {
    ticket.row([


      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),
      PosColumn(text: '${oneOrderData3.paidStatus.toLowerCase() == 'paid' ?
      'paid' : 'unpaid'}',
        width: 4, /*,styles: PosStyles(align: PosAlign.left) */),

      PosColumn(text: '${(oneOrderData3.orderBy.toLowerCase() == 'delivery')
          ? 'Delivery'
          :
      (oneOrderData3.orderBy.toLowerCase() == 'phone') ?
      'Phone' : (oneOrderData3.orderBy.toLowerCase() ==
          'takeaway') ? 'TakeAway' : 'DinningRoom'}',
        width: 4,),
      PosColumn(text: '',
        width: 2, /*, styles: PosStyles(align: PosAlign.center) */),

    ]);



    // 7 image::
    // orderBy: 'Delivery: TakeAway: DinningRoom: phone
    oneOrderData3.orderBy.toLowerCase() == 'delivery'?
    ticket.image(deliveryDataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'phone'?
    ticket.image(phonedataBytesImage,align: PosAlign.center):
    oneOrderData3.orderBy.toLowerCase() == 'takeaway' ?
    ticket.image(takeAwayDataBytesImage,align: PosAlign.center):
    ticket.image(dinningRoomDataBytesImage,align: PosAlign.center);

//    ticket.hr();
    // needed. as per design.

    ticket.feed(1); // for holding or touching the recite by finger... space..

    ticket.cut();
    return ticket;



  }

// # number 4: demoReceipt Order Type Dinning ends here...



  Future <bool> printTicket2(
      PaperSize paper,
      Restaurant thisRestaurant2,
      OneOrderFirebase oneOrderData2,
      Uint8List restaurantNameBytesNotFuture2,
      ) async {
    // pqr


    print('restaurantNameBytesNotFuture2:: $restaurantNameBytesNotFuture2');

    print('oneOrderdocument.orderBy: ${oneOrderData2.orderBy}');

    final PosPrintResult res = (oneOrderData2.orderBy.toLowerCase() ==
        'delivery') ?
    await printerManager.printTicket(
        await demoReceiptOrderTypeDelivery(
          paper,
          thisRestaurant2,
          oneOrderData2,
          restaurantNameBytesNotFuture2,
        )) :
    (oneOrderData2.orderBy.toLowerCase() == 'phone') ?
    await printerManager.printTicket(await demoReceiptOrderTypePhone(
      paper,
      thisRestaurant2,
      oneOrderData2,
      restaurantNameBytesNotFuture2,
    )) :
    (oneOrderData2.orderBy.toLowerCase() == 'takeaway') ?
    await printerManager.printTicket(await demoReceiptOrderTypeTakeAway(
      paper,
      thisRestaurant2,
      oneOrderData2,
      restaurantNameBytesNotFuture2,
    )) :
    await printerManager.printTicket(
        await demoReceiptOrderTypeDinning(
          paper,
          thisRestaurant2,
          oneOrderData2,
          restaurantNameBytesNotFuture2,
        ));


    logger.i('----- res : $res');
    print('res.msg: ${res.msg}');
    String response2 = res.msg;


    // showToast(res.msg);

    logger.i('this never executes .. TODO...');
    if (response2== 'Success') {
      print('at Success');
      print('-----check above condition\'s.... -----');
      return true;
    }



    else {
      print('before returning false from Future <bool> printTicket ');
      return false;
    }

//    TODO: NEED TO check the res.msg
    // true means printed.


  }


  Future<bool> _testPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    print(" at _testPrint");


    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');


    Future<OneOrderFirebase> testFirebaseOrderFetch =
    shoppingCartBloc.fetchOrderDataFromFirebase(
        oneOrderForReceipt.orderdocId.trim());





//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(()
    {
      print("called when future completes");
    }
    ).then((oneOrderData) {

      Widget restaurantName2 = restaurantName(thisRestaurant.name);

      final Future<Uint8List> restaurantNameBytesFuture = createImageFromWidget(restaurantName2);

      Uint8List restaurantNameBytesNotFuture;

      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


      ImageAliasAnotherSource.Image imageRestaurant;

      /* await */
      restaurantNameBytesFuture.whenComplete(() {
        print("restaurantNameBytes.whenComplete called when future completes");
      }
      ).then((oneImageInBytes) {
//      ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
        print('calling ticket.image(imageRestaurant); ');
        restaurantNameBytesNotFuture = oneImageInBytes;

        print('oneImageInBytes: $oneImageInBytes');
//      ticket.image(imageRestaurant);


        print('reached here: $oneOrderData');






        Future<bool> isPrint =
        printTicket2(
          paper,
          thisRestaurant,
          oneOrderData /*,imageRestaurant */,

          restaurantNameBytesNotFuture,

        );

//        Future<OneOrderFirebase> testFirebaseOrderFetch=

        isPrint.whenComplete(() {
          print("called when future completes");
//          return true;
        }
        ).then((printResult) async {
          if (printResult == true) {
            print("printResult: $printResult");
            Future<String> docID = shoppingCartBloc
                .recitePrinted(oneOrderForReceipt.orderdocId, 'Done');


//              --


            docID.whenComplete(() => print('printing completed..')).then((
                value) {
              print(
                  'docID in [Future<bool> isPrin] await shoppingCartBloc.recitePrintedt: $docID');
              return true;
            }).catchError((onError) {
              return false;
            });
//            --
            return false;
          }
          else {
            return false;
          }

        }).catchError((onError) {
          print('printing not successful: $onError');
          return false;
        });

      }).catchError((onError) {
        print(' error in getting restaurant name as image---1');
        print('false: means something wrong not printed');
        //means something wrong not printed
        return false;
      });




    }).catchError((onError) {
      print('Order data fetch Error $onError ***');
      _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(duration: new Duration(seconds: 6), content: Container(
          child:
          new Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("Error: ${onError.message.substring(0, 40)}", style:
              TextStyle(/*fontSize: 10,*/ fontWeight: FontWeight.w500,
                  color: Colors.white)),
            ],
          ),
        )),);

      return false;
    });


    // final return false if true is not return from the above conditioned.
    return false;
//    });
  }

  void _testPrintDummyDevices(PrinterBluetooth printer) async {
    // NOT REQUIRED SINCE DUMMY...

    print("_testPrintDummyDevices");

    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');



    TODO: // something wrong maybe here. docID needs to be processed...

    Future<String> docID = shoppingCartBloc.recitePrinted(
        oneOrderForReceipt.orderdocId, 'dummyPrint');

//                    recitePrinted

    print('docID1 in dummy Print: $docID');

    Future<OneOrderFirebase> testFirebaseOrderFetch = shoppingCartBloc
        .fetchOrderDataFromFirebase(oneOrderForReceipt.orderdocId.trim());

    Widget restaurantName2 = restaurantName(thisRestaurant.name);
    final Future<Uint8List> restaurantNameBytesFuture =
    createImageFromWidget(restaurantName2);
    Uint8List restaurantNameBytesNotFuture;

    print('restaurantNameBytes: $restaurantNameBytesNotFuture');

    ImageAliasAnotherSource.Image imageRestaurant;

    /* await */
    restaurantNameBytesFuture.whenComplete(() {
      print("restaurantNameBytes.whenComplete called when future completes");
    }).then((oneImageInBytes) {
      ImageAliasAnotherSource.Image imageRestaurant =
      ImageAliasAnotherSource.decodeImage(oneImageInBytes);
      print('calling ticket.image(imageRestaurant); ');
      restaurantNameBytesNotFuture = oneImageInBytes;

      print('restaurantNameBytesNotFuture: $restaurantNameBytesNotFuture');
//      ticket.image(imageRestaurant);
    }).catchError((onError) {
      print(' error in getting restaurant name as image--22');
    });

//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(() {
      print("called when future completes");
    }).then((oneOrderData) {





      printTicketDummy2(
        /*paper, */
        thisRestaurant,
        oneOrderData,
        imageRestaurant,

        restaurantNameBytesNotFuture,

      );


    }).catchError((onError) {
      print('Order data fetch Error $onError ***');
      _scaffoldKeyShoppingCartPage.currentState.showSnackBar(
        new SnackBar(
            duration: new Duration(seconds: 6),
            content: Container(
              child: new Row(
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("Error: $onError",
                      style: TextStyle(
                        /*fontSize: 10,*/ fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ],
              ),
            )),
      );
    });
  }




  Future<void> _showMyDialog3(Uint8List x) async {
    print('x: $x');
//    print('totalCostDeliveryBytes3: $totalCostDeliveryBytes3');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('you are using dummy bluetooth devices.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'please use real blueTooth devices and also change functions in '
                        'shopping cart page.'),
                Container
                  (child: Image.memory(x)
                ),

//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('return shopping Cart page.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

/* PRINTING REcite related codes resides here: */


}




class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale}) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
//    return "|";
    return "";
  }

  @override
  List<int> layoutProportions() {
    return [2, 2, 0];
//    return [1, 2, 1];

//    return [2, 2];

  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
      this.currentLeftIndex(), this.currentMiddleIndex(), /*this.currentRightIndex() */)
        : DateTime(currentTime.year, currentTime.month, currentTime.day, this.currentLeftIndex(),
      this.currentMiddleIndex(),

      /*this.currentRightIndex()*/

    );
  }
}

