/*
* pRINTING RELATED IMPORTS BEGINS HERE..*/

import 'package:image/image.dart' as ImageAliasAnotherSource;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';

//import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'dart:typed_data';
import 'package:flutter/services.dart'; // InputFormatters.
import 'package:flutter/material.dart' hide Image;
import 'package:image/image.dart' as ImageAliasAnotherSource;
import 'package:flutter/rendering.dart'; // render...

import 'dart:ui' as ui; // ui
// import 'dart:async';
/*
* pRINTING RELATED IMPORTS ENDS HERE..*/

// dependency files
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:foodgallery/src/BLoC/HistoryDetailsBloc.dart';
import 'package:foodgallery/src/BLoC/UnPaidDetailsBloc.dart';
import 'package:foodgallery/src/BLoC/foodGallery_bloc.dart';
import 'package:foodgallery/src/DataLayer/models/CheeseItem.dart';
import 'package:foodgallery/src/DataLayer/models/CustomerInformation.dart';
import 'package:foodgallery/src/DataLayer/models/PaymentTypeSingleSelect.dart';
import 'package:foodgallery/src/screens/foodGallery/foodgallery2.dart';
import 'package:foodgallery/src/screens/unPaid/UnPaidDetailImage.dart';
import 'package:qr_flutter/qr_flutter.dart';


//import 'package:foodgallery/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';

import 'package:foodgallery/src/DataLayer/models/NewIngredient.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:foodgallery/src/DataLayer/models/OneOrderFirebase.dart';
import 'package:foodgallery/src/DataLayer/models/OrderedItem.dart';
import 'package:foodgallery/src/DataLayer/models/SauceItem.dart';
import 'package:foodgallery/src/screens/history/HistoryDetailImage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.

import 'package:foodgallery/src/utilities/screen_size_reducers.dart';
//import 'package:foodgallery/src/screens/foodItemDetailsPage/Widgets/FoodDetailImage.dart';
import 'package:foodgallery/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:foodgallery/src/DataLayer/models/SelectedFood.dart';

import 'package:logger/logger.dart';

// Blocks

import 'package:foodgallery/src/BLoC/bloc_provider.dart';
import 'package:foodgallery/src/BLoC/foodItemDetails_bloc.dart';





class UnpaidDetailsPage extends StatefulWidget {

  final Widget child;
  UnpaidDetailsPage({Key key, this.child}) : super(key: key);
  @override
  _UnPaidDetailsState createState() => new _UnPaidDetailsState();

}


class _UnPaidDetailsState extends State<UnpaidDetailsPage> {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final GlobalKey<ScaffoldState> _scaffoldKeyUnPaidDetailsPage =
  new GlobalKey<ScaffoldState>();

  String _currentSize;
  bool showCancelPayButtonFirstTime = true;
  bool showFullPaymentType =true;
  int _currentPaymentTypeIndex ; // PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)

  double tryCast<num>(dynamic x, {num fallback }) {

    bool status = x is num;
    if(status) {
      return x.toDouble() ;
    }
    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}
    else return 0.0;
  }

  bool showUnSelectedIngredients = false;
  bool showPressWhenFinishButton = false;
  bool tempPayButtonPressed = false;
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

  @override
  void dispose() {

    print('.....at void dispose()  2222...');
    // Clean up the controller when the widget is disposed.
    super.dispose();
    // addressController.dispose();
    // houseFlatNumberController.dispose();
    // phoneNumberController.dispose();
    // etaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);
    return Container(

        child: StreamBuilder<OneOrderFirebase>(

            stream:       blocUD.getCurrentUnPaidOrderStream,
            initialData:  blocUD.getCurrentUnPaidFireBaseOrder,

            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new LinearProgressIndicator());
              }
              else {

                final OneOrderFirebase oneFireBaseOrderDetail = snapshot.data;
                _currentPaymentTypeIndex = oneFireBaseOrderDetail.tempPaymentIndex;


                logger.i('_currentPaymentTypeIndex: $_currentPaymentTypeIndex');

                /*
                if (tempPayButtonPressed == true) {
                  print('....payment button pressed.....');
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
                                'updating, please wait.',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                            ),
                          ),


                          Center(
                            child: Container(
                                alignment: Alignment.center,
                                child: new CircularProgressIndicator(
                                  backgroundColor: Color(
                                      0xffFC0000),

                                )
                            ),
                          ),
                        ],
                      ),
                    ),

                  );
                  // .....
                }
                else {
                  //......

                  */

                return GestureDetector(
                  onTap: () {
                    print('s');
                    print('navigating to FoodGallery 2 again with block');

                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    blocUD.clearSubscription();
                    print(
                        'CLEAR SUBSCRIPTION ... before going to food gallery page..');

                    return Navigator.pop(context);
                  },
                  child:
                  Scaffold(
                    // key: _scaffoldKeyShoppingCartPage,
                    //   _scaffoldKeyUnPaidDetailsPage


                    key: _scaffoldKeyUnPaidDetailsPage,

                    backgroundColor: Colors.white.withOpacity(0.05),


                    body: WillPopScope(
                      onWillPop: () {
                        Navigator.pop(context);
                        return new Future(() => false);
                      }, child: SafeArea(

// smaller container containing all modal FoodItem Details things.
                      child: Container(
                          height: displayHeight(context) -
                              MediaQuery
                                  .of(context)
                                  .padding
                                  .top -
                              MediaQuery
                                  .of(context)
                                  .padding
                                  .bottom,
//                            kToolbarHeight

                          child: GestureDetector(
                            onTap: () {
                              print('GestureDetector for Stack working');
                              print('no navigation now');
                            },
                            child:

                            Container(

// FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
                                width: displayWidth(context) / 1.03,

                                child:
                                initialView(oneFireBaseOrderDetail)
                            ),


                          )


                      ),
                    ),
                    ),
                  ),
                );

              }
            }

        )
    );
//    }
  }


  Widget updateCompleteGoToPreviousPage(BuildContext context){

    print(' < >  <   >  at updateCompleteGoToPreviousPage      >>  \\   ');

    return
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: new CircularProgressIndicator(
                  backgroundColor: Colors.lightGreenAccent,
                )
            ),


            Container(
              child: Text(
                'updating, please wait.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

              ),),

            Container(

                child: new CircularProgressIndicator(
                  backgroundColor: Color(0xffFC0000),

                )
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



  // paper,
  // oneFirebaseOrderDetail
  // restaurantNameBytesNotFuture,

      Future <bool> printTicket2(
      PaperSize paper,
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
          // thisRestaurant2,
          oneOrderData2,
          restaurantNameBytesNotFuture2,
        )) :
    (oneOrderData2.orderBy.toLowerCase() == 'phone') ?
    await printerManager.printTicket(await demoReceiptOrderTypePhone(
      paper,
      // thisRestaurant2,
      oneOrderData2,
      restaurantNameBytesNotFuture2,
    )) :
    (oneOrderData2.orderBy.toLowerCase() == 'takeaway') ?
    await printerManager.printTicket(await demoReceiptOrderTypeTakeAway(
      paper,
      // thisRestaurant2,
      oneOrderData2,
      restaurantNameBytesNotFuture2,
    )) :
    await printerManager.printTicket(
        await demoReceiptOrderTypeDinning(
          paper,
          // thisRestaurant2,
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



  Future<bool> _testPrint(PrinterBluetooth printer,OneOrderFirebase oneFirebaseOrderDetail) async {

    // oneFirebaseOrderDetail
    final blocUD = BlocProvider.of<UnPaidDetailsBloc>(
        context);


    printerManager.selectPrinter(printer);



    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    print(" at _testPrint");



    print('oneFirebaseOrderDetail.documentId: ${oneFirebaseOrderDetail.documentId}');



      Widget restaurantName2 = restaurantName(oneFirebaseOrderDetail.restaurantName);

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


        // print('reached here: $oneOrderData');






        Future<bool> isPrint =
        printTicket2(
          paper,
          oneFirebaseOrderDetail,
          restaurantNameBytesNotFuture
        );

//        Future<OneOrderFirebase> testFirebaseOrderFetch=

        isPrint.whenComplete(() {
          print("called when future completes");
//          return true;
        }
        ).then((printResult) async {
          if (printResult == true) {
            print("printResult: $printResult");
            Future<String> docID = blocUD
                .recitePrinted(oneFirebaseOrderDetail.documentId, 'Done');


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


    return false;

  }


  Widget animatedCancelPayButtonUnpaidDetailsPage(OneOrderFirebase oneFireBaseOrderDetail){

    // final
    // oneFireBaseOrder
    print(' at animatedCancelPayButtonUnpaidDetailsPage... << TT       >>  \\   ');

    final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);
    return Container(

      height: displayHeight(context) / 8.2,
      child: StreamBuilder(
        stream: blocUD.getCurrentPaymentTypeSingleSelectStream,
        initialData: blocUD.getCurrentPaymentType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return Container(child: Text('Null'));
          }
          else {
            List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot.data;

            PaymentTypeSingleSelect selectedOne = allPaymentTypesSingleSelect
                .firstWhere((onePaymentType) =>
            onePaymentType.isSelected == true);

            _currentPaymentTypeIndex = selectedOne.index;
//              logger.e('selectedOne.index',selectedOne.index);
            String paymentTypeName = selectedOne.paymentTypeName;
            String paymentIconName = selectedOne.paymentIconName;
            String borderColor = selectedOne.borderColor;
            const Color OrderTypeIconColor = Color(0xff070707);


            return
              Container(
//                color: Colors.deepOrange,
//                 margin: EdgeInsets.fromLTRB(0, 9, 0, 9),

                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[


                    Container(

//                            width: 100,
                      width: displayWidth(context) / 8,
                      height: displayHeight(context) / 10,

                      child:
                      InkWell(
                        child: Container(

                          padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[
                              new Container(
                                width: 100,
                                height: displayHeight(context) / 15,
                                decoration: BoxDecoration(

                                  color: Color(0xffF4F6CE),
//                                  color:Color(0xffFFE18E),

                                  shape: BoxShape.circle,

                                ),

                                child: Icon(
                                  getIconForName(paymentTypeName),
                                  color: Colors.black,
                                  size: displayHeight(context) / 30,

                                ),
                              ),

                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  paymentTypeName, style:
                                TextStyle(
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

                            showCancelPayButtonFirstTime = true;
                            showFullPaymentType = !showFullPaymentType;
                          });
                        },
                      ),

                    ),




                    SizedBox(width:20),


                    Container(
                      width: displayWidth(context) / 4,
                      height: displayHeight(context) / 24,
                      child: OutlineButton(
                        color: Color(0xffFC0000),

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
                          child: Text('Cancel',
                            style: TextStyle(color: Color(0xffFC0000),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,),),

                        ),

                        onPressed: () {
                          print(
                              'on Pressed of Cancel of animatedUnObscuredCancelPayButtonTakeAway');


                          setState(() {
                            showCancelPayButtonFirstTime = true;
                          });
                        },
                      ),
                    ),


                    SizedBox(width:40),


//                    SizedBox(width: displayWidth(context) / 12,),

                    Container(
                      width: displayWidth(context) / 4,
                      height: displayHeight(context) / 24,
                      child: OutlineButton(
                        color: Colors.green,

                        borderSide: BorderSide(
                          color: Colors.green, // 0xff54463E
                          style: BorderStyle.solid,
                          width: 7.6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Container(
                          child: Text('Pay', style: TextStyle(color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,),
                          ),
                        ),

                        onPressed: () async {

                          print(
                              'pay button pressed need to update paid Status and redirect to another page...'
                                  ' Print..: ');

                          final blocUD = BlocProvider.of<UnPaidDetailsBloc>(
                              context);

                          // OneOrderFirebase
                          OneOrderFirebase resultingOneOrderFB = await blocUD
                              .paymentButtonPressedUnPaidDetailsPage();

                          print('test: $resultingOneOrderFB');

                          logger.i('tempPayButtonPressed: > > > > > $tempPayButtonPressed');
                          // oneFireBaseOrderDetail

                          if (resultingOneOrderFB.updateSuccess == false) {
                            _scaffoldKeyUnPaidDetailsPage.currentState.showSnackBar(SnackBar(
                                content: Text("someThing went wrong")));
                            print('something went wrong');
                          } else {


                            // success test ==1..
                            // 911_1
                            // work_1

                            print('orderDocumentId finally: >> ${oneFireBaseOrderDetail.documentId}');


                            List<PrinterBluetooth> blueToothDevicesState =
                                blocUD.getDevices;
                            // ...

                            // List<PrinterBluetooth> blueToothDevicesState =
                            // shoppingCartBloc.getDevices;

                            print(
                                'blueToothDevicesState.length: ${blueToothDevicesState.length}');

                            if (blueToothDevicesState.length == 0) {
                              logger.i('___________ blueTooth device not found _____');

                              await _showMyDialog2(
                                  '___________ blueTooth device not found _____ delivery phone pay button');

                              print(
                                  'at here... __________ blueTooth device not found _____ delivery phone pay button');

                              blocUD.clearSubscription();

                              return Navigator.pop(context);
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
                                await _testPrint(blueToothDevicesState[index],resultingOneOrderFB);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);

                                if (printResult == true) {
                                  logger.i('printResult==true i.e. print successfull');

                                  blocUD.clearSubscription();
                                  // shoppingCartBloc.clearSubscription();

                                  return Navigator.of(context).pushAndRemoveUntil(

                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return BlocProvider<FoodGalleryBloc>(
                                                bloc: FoodGalleryBloc(),
                                                child: FoodGallery2()
                                            );
                                          }), (Route<dynamic> route) => false);
                                  /*
          return Navigator.pop(
          context, cancelPaySelectUnobscuredDeliveryPhone);

          */


                                } else {
                                  logger.i('printResult!=true i.e. print UN successfull');
                                  blocUD.clearSubscription();

                                  return Navigator.of(context).pushAndRemoveUntil(

                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return BlocProvider<FoodGalleryBloc>(
                                                bloc: FoodGalleryBloc(),
                                                child: FoodGallery2()
                                            );
                                          }), (Route<dynamic> route) => false);
                                  /*
          return Navigator.pop(
          context, cancelPaySelectUnobscuredDeliveryPhone);

          */
                                }
                              } else {
                                logger.i(
                                    '___________ Restaurant Printer,  not listed ... _____ printing wasn\'t successfull');

                                await _showMyDialog2(
                                    '___________ Restaurant Printer... not listed ...  printing wasn\'t successfull _____');


                                // ....


                                blocUD.clearSubscription();


                                /*
                              return Navigator.pop(
                                  context);
                              */


//                              pushNamedAndRemoveUntil
                                return Navigator.of(context).pushAndRemoveUntil(

                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return BlocProvider<FoodGalleryBloc>(
                                              bloc: FoodGalleryBloc(),
                                              child: FoodGallery2()
                                          );
                                        }), (Route<dynamic> route) => false);


                              }
                            }

                          }
                        },

                      ),
                    ),
                    SizedBox(width:40),

                  ],
                ),
              );
          }
        },
      ),
    );
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
  Widget oneSinglePaymentType(PaymentTypeSingleSelect onePaymentType,
      int index) {

    print('at oneSinglePaymentType(\'\'\'   ');
    print('_currentPaymentTypeIndex: $_currentPaymentTypeIndex');


    String paymentTypeName = onePaymentType.paymentTypeName;
    String paymentIconName = onePaymentType.paymentTypeName;
    String borderColor = onePaymentType.borderColor;
    const Color OrderTypeIconColor = Color(0xff070707);
    return Container(

      child: index == _currentPaymentTypeIndex ?

      Container(

        // color: Colors.purple,
        width: displayWidth(context) / 6.5,
        height: displayHeight(context) / 11,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child:
        InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    size: displayWidth(context) / 13,
                  ),

                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName, style:
                  TextStyle(color: Color(0xffFC0000),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {


            logger.i('index: $index');
            print('YY YY  $index  YY   YY    ');


            /*
            if(index==0){

              print(' 0 means later option...');

              final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);
              // blocUD.setPaymentTypeSingleSelectOptionForOrderUnPaidDetailsPage(
              //     onePaymentType, index, _currentPaymentTypeIndex);

              print('later button pressed....:');


            }
            else {

            }*/

            final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);

            blocUD.setPaymentTypeSingleSelectOptionForOrderUnPaidDetailsPage(
                onePaymentType, index, _currentPaymentTypeIndex);

            setState(() {
              showFullPaymentType = false;
              showCancelPayButtonFirstTime = false;
            });






          },
        ),
      ) :

      Container(
        width: displayWidth(context) / 6.5,
        height: displayHeight(context) / 10,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child:
        InkWell(

          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    size: displayWidth(context) / 13,
                  ),

                ),
                Container(

                  alignment: Alignment.center,
                  child: Text(
                    paymentTypeName, style:
                  TextStyle(
                      color: Color(0xffFC0000),

                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          onTap: () async {






            logger.i('index: $index');
            print('YY YY  $index  YY   YY    ');
            /*
            if(index==0){

              print(' 0 means later option...');

              final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);

              print('later button pressed....:');


            }
            else {
*/
            final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);

            blocUD.setPaymentTypeSingleSelectOptionForOrderUnPaidDetailsPage(
                onePaymentType, index, _currentPaymentTypeIndex);

            setState(() {
              showFullPaymentType = false;
              showCancelPayButtonFirstTime = false;
            });


            // setState(() {
            //   showCancelPayButtonFirstTime = false;
            // });

          },
        ),

      ),
    );
  }




  Widget _buildPaymentTypeSingleSelectOption() {

    print('at _buildPaymentTypeSingleSelectOption of UnPaid Details page... ');
    final blocUD = BlocProvider.of<UnPaidDetailsBloc>(context);

    return StreamBuilder(
        stream: blocUD.getCurrentPaymentTypeSingleSelectStream,
        initialData: blocUD.getCurrentPaymentType,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('!snapshot.hasData');

            return Container(child: Text('Null'));
          }
          else {
            List<PaymentTypeSingleSelect> allPaymentTypesSingleSelect = snapshot
                .data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

            print('paymentTypes: $allPaymentTypesSingleSelect');


            return Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

//              reverse: true,

                shrinkWrap: true,
                itemCount: allPaymentTypesSingleSelect.length,

                itemBuilder: (_, int index) {
                  return oneSinglePaymentType(
                      allPaymentTypesSingleSelect[index],
                      index);
                },

              ),
            );
          }
        }

      // M VSM ORG VS TODO. ENDS HERE.
    );
  }


  _navigateAndDisplaySelection(BuildContext context,String updatedDocumentID) async {



    return Navigator.pop(
        context, updatedDocumentID);


  }


  Widget initialView(OneOrderFirebase oneFireBaseOrderDetail){

    logger.e('oneFireBaseOrder.paidType > > > ${oneFireBaseOrderDetail.paidType} ???');

    List<OrderedItem> orderedItems = oneFireBaseOrderDetail.orderedItems;




    return Container(

      height: displayHeight(context) -
          MediaQuery
              .of(context)
              .padding
              .top - MediaQuery
          .of(context)
          .padding
          .bottom,


// FROM 2.3 ON JULY 3 AFTER CHANGE INTRODUCTION OF CHEESE AND SAUCES.
      width: displayWidth(context) / 1.03,

      margin: EdgeInsets.fromLTRB(0, displayHeight(context) / 16, 0, 5),

      decoration:
      new BoxDecoration(
        borderRadius: new BorderRadius.circular(
            10.0),
//                                    color: Colors.purple,
        color: Colors.white,
      ),


      child:
      Neumorphic(
        curve: Neumorphic.DEFAULT_CURVE,
        style: NeumorphicStyle(
          shape: NeumorphicShape
              .concave,
          depth: 8,
          lightSource: LightSource
              .topLeft,
          color: Colors.white,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.all(Radius.circular(5)),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .start,
          crossAxisAlignment: CrossAxisAlignment
              .start,
          children: <Widget>[

            Container(
//              color: Colors.blue,
              height: displayHeight(context) / 11,
              width: displayWidth(context) / 1.07,

              child:
// YELLOW NAME AND PRICE BEGINS HERE.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context) /
                        2.8 /*+  displayWidth(context)/8 */, /*3.9 */


                    decoration: BoxDecoration(
                      color: Color(0xffFFE18E),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(60)),
//
                    ),


                    height: displayHeight(context) / 18,
//                                          height: displayHeight(context)/40,

                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: <Widget>[
                        Container(
                          width: displayWidth(context) / 3.9,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child:

                          Text(
                              '${oneFireBaseOrderDetail.orderBy.toLowerCase()}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                              )
                          ),
                        ),


                      ],
                    ),


                  ),


                  Container(

//                    color:Colors.green,
                    width: displayWidth(context) / 2.5,
                    height: displayHeight(context) / 11,
                    child: displayCustomerInformationWidget(
                        oneFireBaseOrderDetail.oneCustomer),
//                    height: displayHeight(context)/20,

                  )

                ],
              ),

            ),

            Divider(
              height: 10,
              thickness: 1,
              color: Colors.grey,
            ),


            SizedBox(height: 10),

            Container(

                width: displayWidth(context) / 2.49 +
                    displayWidth(context) / 1.91,

                height: displayHeight(context) / 1.6,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
//                                                    width: displayWidth(context)/4,
                      width: displayWidth(context) / 3,
//                                                    width: displayWidth(context)/3.29,
//                      color:Colors.blue,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,


                        children: [
                          Container(
                            height: displayHeight(context) / 6.5,
                            width: displayWidth(context) / 3.59,
//                        color: Colors.red,
//                            color:Colors.blue,


                            padding: EdgeInsets
                                .fromLTRB(
                                0, 0, 0,
                                0),


                            child:
                            UnPaidDetailImage(
                              oneFireBaseOrderDetail
                                  .formattedOrderPlacementDatesTimeOnly,
                              oneFireBaseOrderDetail.orderBy,
                              oneFireBaseOrderDetail.startDate,
                              oneFireBaseOrderDetail.totalPrice,

//
                            ),

                          ),


                          Container(
                            height: displayHeight(context) / 4,
                            width: displayWidth(context) / 2.99,
//                        color: Colors.red,


                            padding: EdgeInsets
                                .fromLTRB(
                                20, 0, 20,
                                0),

//                          child: Text('FoodImageURL')

                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Text(
                                    '${oneFireBaseOrderDetail
                                        .formattedOrderPlacementDatesTimeOnly}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                      color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                    )
                                ),


                                Container(
                                  child: oneFireBaseOrderDetail
                                      .orderProductionTimeFromNow != -1 ?

                                  Text('${oneFireBaseOrderDetail
                                      .orderProductionTimeFromNow} min',
                                    maxLines: 1,

                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
//                        color: Color(0xffF50303),
                                      fontSize: 20,
                                      fontFamily: 'Itim-Regular',),
                                  ) : Text('${oneFireBaseOrderDetail.timeOfDay
                                      .toString()}',

                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
//                        color: Color(0xffF50303),
                                      fontSize: 20,
                                      fontFamily: 'Itim-Regular',),
                                  ),
                                ),

                                /*
                                Text(
                                    '${oneFireBaseOrder.orderProductionTimeFromNow}:00 min',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                      color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                    )
                                ),

                                */

                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Text(
                                          'SUBTOTAL',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,

                                            color: Colors.grey,


                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrderDetail.totalPrice
                                              .toStringAsFixed(2)}' +
                                              '\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.grey,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),


                                Container(
                                  child: oneFireBaseOrderDetail.orderBy ==
                                      'Delivery' ?

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Text(
                                          'DELIVERY',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,


                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrderDetail.deliveryCost
                                              .toStringAsFixed(2)}' +
                                              '\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,

                                            color: Colors.grey,

                                          )
                                      ),
                                    ],
                                  ) : Container(width: 0, height: 0),
                                ),


                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Text(
                                          'ALV',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '14%',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
//                                fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                Divider(
                                  height: 5,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),


                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Text(
                                          'TOTAL',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrderDetail
                                              .priceWithDelivery
                                              .toStringAsFixed(2)}' +
                                              '\u20AC',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Text(
                                          '${oneFireBaseOrderDetail.paidStatus}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),


                                      Text(
                                          '${oneFireBaseOrderDetail.paidType}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
//                                                      color: Colors.white
                                            color: Colors.black,
//                                fontFamily: 'Itim-Regular',

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),


                        ],
                      ),
                    ),

                    VerticalDivider(
//                      height:10,
                      width: 10,
                      thickness: 1,
                      color: Colors.grey,
                    ),

                    Container(

                      height: displayHeight(context) / 1.7,
                      width: displayWidth(context) / 1.91,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          Container(
                              width: 550,
                              height: displayHeight(context) / 1.7,
                              child: processFoodForUnPaidDetailsPage(
                                  orderedItems)
                          ),

//                          FFFFF
                        ],
                      ),
                    ),

                  ],
                )

            ),


            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),


              child:
              AnimatedSwitcher(
                duration: Duration(
                    milliseconds: 1000),
                child: tempPayButtonPressed == false ?

                AnimatedSwitcher(
                  duration: Duration(
                      milliseconds: 1000),
                  child:
                  showCancelPayButtonFirstTime == true ?

                  Container(

                    // color:Colors.limeAccent,
//                    color:Colors.white,
//                                            height: 200,
                    height: displayHeight(context) / 8,
                    width: displayWidth(context) / 1.03,
                    child: _buildPaymentTypeSingleSelectOption(),

                  ) :
                  Container(
                      height: displayHeight(context) / 9,
                      width: displayWidth(context) / 1.03,
                      child: animatedCancelPayButtonUnpaidDetailsPage(
                          oneFireBaseOrderDetail)
                  ),
                )

                    : updateCompleteGoToPreviousPage(
                    context /*oneFireBaseOrderDetail.documentId*/),

              ),

            ),


          ],
        ),

      ),
    );


  }


  Widget displayOneFoodInformation(OrderedItem oneFood, int index){
    print('index: : : : $index');

    List<NewIngredient> extraIngredient   = oneFood.selectedIngredients;
    List<SauceItem>     extraSauces       = oneFood.selectedSauces;
    List<CheeseItem>    extraCheeseItems  = oneFood.selectedCheeses;


    print('extraIngredient: $extraIngredient');

    print('extraSauces: $extraSauces');

    print('extraCheeseItems: $extraCheeseItems');

    List<NewIngredient> onlyExtraIngredient   = extraIngredient.where((e) => e.isDefault != true).toList();
    List<SauceItem> onlyExtraSauces       = extraSauces.where((e) => e.isDefaultSelected != true).toList();
    List<CheeseItem>    onlyExtraCheeseItems  = extraCheeseItems.where((e) => e.isDefaultSelected != true).toList();


    print('onlyExtraIngredient: $onlyExtraIngredient');

    print('onlyExtraSauces: $onlyExtraSauces');

    print('onlyExtraCheeseItems: $onlyExtraCheeseItems');


    return Container(

      height:145,
      width: 550,
      padding:EdgeInsets.symmetric(vertical:8,horizontal: 6),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            color:Colors.amber,
            height: 30,
            width: 550,
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
                    fontSize: 20,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  'X${oneFood.quantity}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),
                /*
        Text(
                  '${oneFood.foodItemSize}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

                */
                Text(
                  '${oneFood.oneFoodTypeTotalPrice.toStringAsFixed(2)}',
                  // '${oneFood.unitPriceWithoutCheeseIngredientSauces.toStringAsFixed(2)}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 20, fontFamily: 'Itim-Regular',),
                ),

              ],
            ),
          ),

          Container(
              height: 30,
              width: 550,
              child: showExtraIngredients(onlyExtraIngredient,oneFood.quantity)
          ),

//                Text('||'),
          Container(
              height: 30,
              width: 550,
              child: showExtraCheeseItems(onlyExtraCheeseItems,oneFood.quantity)
          ),

//                Text('||'),
          Container(
              height: 30,
              width: 550,
              child: showExtraSauces(onlyExtraSauces,oneFood.quantity)
          ),

          Divider(
            height:5,
            thickness:1,
            color:Colors.grey,
          ),

        ],
      ),
    );
  }



  Widget processFoodForUnPaidDetailsPage(List<OrderedItem> orderedItems){

    return ListView.builder(

      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: orderedItems.length,

      itemBuilder: (_,int index) {
        return displayOneFoodInformation(orderedItems[index], index);
      },
    );
  }



  Widget displayOneExtraIngredientInRecite(NewIngredient oneIngredientForHistoryDetailsPage, int index,int quantity){

    print('oneIngredientForRecite.ingredientName: ${oneIngredientForHistoryDetailsPage.ingredientName}');

    if(oneIngredientForHistoryDetailsPage.isDefault==false) {

      print(' oneIngredientForHistoryDetailsPage.isDefault==false  : ${oneIngredientForHistoryDetailsPage.isDefault==false} ==> '
          'oneIngredientForHistoryDetailsPage.ingredientName => ${oneIngredientForHistoryDetailsPage.ingredientName}');
      return

        Container(
          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneIngredientForHistoryDetailsPage.ingredientName == null) ||
              (oneIngredientForHistoryDetailsPage.ingredientName.length == 0)) ?
          '----' : oneIngredientForHistoryDetailsPage.ingredientName.length > 18 ?
          oneIngredientForHistoryDetailsPage.ingredientName.substring(0, 15) + '...' :
          oneIngredientForHistoryDetailsPage.ingredientName}, ',
            /*
              Text(
                '${oneIngredientForRecite.ingredientName}', */

            textAlign: TextAlign.left,
            style: TextStyle(
//                fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 17,
//                fontFamily: 'Itim-Regular',
            ),



          ),
        );
    }
    else return Text('Null');
  }

  Widget displayOneExtraSauceItemInRecite(SauceItem oneSauceItemForHistoryDetailsPage, int index,int quantity){

    print('oneSauceItemForRecite.ingredientName: ${oneSauceItemForHistoryDetailsPage.sauceItemName}');

    if(oneSauceItemForHistoryDetailsPage.isDefaultSelected !=true) {
      return

        Container(
          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneSauceItemForHistoryDetailsPage.sauceItemName == null) ||
              (oneSauceItemForHistoryDetailsPage.sauceItemName.length == 0)) ?
          '---' : oneSauceItemForHistoryDetailsPage.sauceItemName.length > 18 ?
          oneSauceItemForHistoryDetailsPage.sauceItemName.substring(0, 15) + '...' :
          oneSauceItemForHistoryDetailsPage.sauceItemName}, ',
            /*
            Text(
                '${oneSauceItemForRecite.sauceItemName} ',
                */

            textAlign: TextAlign.left,
            style: TextStyle(
//              fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 20,
//              fontFamily: 'Itim-Regular',
            ),

          ),
        );
    }
    else return Text('Null');
  }


  Widget displayOneExtraCheeseItemInRecite(CheeseItem oneCheeseItemForHistoryDetailsPage, int index,int quantity){

    print('oneCheeseItemForRecite.ingredientName: ${oneCheeseItemForHistoryDetailsPage.cheeseItemName}');
    if(oneCheeseItemForHistoryDetailsPage.isDefaultSelected !=true) {
      return
        Container(

          padding:EdgeInsets.symmetric(vertical:0,horizontal: 6),
          child: Text('${((oneCheeseItemForHistoryDetailsPage.cheeseItemName == null) ||
              (oneCheeseItemForHistoryDetailsPage.cheeseItemName.length == 0)) ?
          '---' : oneCheeseItemForHistoryDetailsPage.cheeseItemName.length > 18 ?
          oneCheeseItemForHistoryDetailsPage.cheeseItemName.substring(0, 15) + '...' :
          oneCheeseItemForHistoryDetailsPage.cheeseItemName}, ',
            textAlign: TextAlign.left,
            style: TextStyle(
//              fontWeight: FontWeight.bold,
              color: Colors.black,
//                        color: Color(0xffF50303),
              fontSize: 20,
//              fontFamily: 'Itim-Regular',
            ),

          ),
        );
    }
    else return Text('Null');
  }

// DUMMY RECITE RELATED PRINT CODES ARE HERE ==> LINE # 11264 ==>

//  showExtraIngredients(oneFood.selectedIngredients)
//  showExtraCheeseItems(oneFood.selectedCheeses)
//  showExtraSauces(oneFood.defaultSauces)

  Widget showExtraIngredients(List <NewIngredient> historyDetailPageIngrdients,int quantity){

    print('reciteIngrdients.length: ${historyDetailPageIngrdients.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
//      scrollDirection: Axis.vertical,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageIngrdients.length,


      itemBuilder: (_,int index) {
        return displayOneExtraIngredientInRecite(historyDetailPageIngrdients[index], index,quantity);
      },

    );

  }


  Widget showExtraCheeseItems(List<CheeseItem> historyDetailPageCheeseItems,int quantity){
    print('reciteCheeseItems.length: ${historyDetailPageCheeseItems.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageCheeseItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraCheeseItemInRecite(historyDetailPageCheeseItems[index], index,quantity);
      },
    );
  }

  Widget showExtraSauces(List<SauceItem> historyDetailPageSauceItems,int quantity){
    print('reciteSauceItems.length: ${historyDetailPageSauceItems.length}');
    return ListView.builder(

      scrollDirection: Axis.horizontal,
      reverse: false,
      shrinkWrap: false,
      itemCount: historyDetailPageSauceItems.length,

      itemBuilder: (_,int index) {
        return displayOneExtraSauceItemInRecite(historyDetailPageSauceItems[index], index,quantity);
      },
    );
  }





  Widget displayCustomerInformationWidget(CustomerInformation customerForHistoryDetailsPage){



    print('customerForHistoryDetailsPage.address:  ===  ===>  ${customerForHistoryDetailsPage.address} |  |  |  |  |  |  |  |');

    return



// ADDRESS: BEGINS HERE.

      Column(
        children: [

          ((customerForHistoryDetailsPage.address!='')) ?

          Container(
            margin:EdgeInsets.fromLTRB(15,15,5,10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Row(
                  children: [
                    Text('address: ',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                        fontFamily: 'Itim-Regular',
                      ),
                    ),

                    Text(
                      '${((customerForHistoryDetailsPage.address == null) ||
                          (customerForHistoryDetailsPage.address.length == 0)) ?
                      '----' : customerForHistoryDetailsPage.address.length > 21 ?
                      customerForHistoryDetailsPage.address.substring(0, 18) + '_ _' :
                      customerForHistoryDetailsPage.address}',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                        fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text('Flat: ',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//      fontFamily: 'Itim-Regular',
                      ),
                    ),

// 2 ends here.
                    Text('${customerForHistoryDetailsPage.flatOrHouseNumber}',

                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
//                        color: Color(0xffF50303),
                        fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                      ),
                    ),
                  ],
                ),


                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'phone: ',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 22,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),
                      Text(
                        '${customerForHistoryDetailsPage.phoneNumber}',

                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
//                        color: Color(0xffF50303),
                          fontSize: 22,
//                          fontFamily: 'Itim-Regular',
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

          ):
          Container(
//            alignment: Alignment.center,

            margin:EdgeInsets.fromLTRB(15,15,5,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  'phone: ',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),
                Text(
                  '${customerForHistoryDetailsPage.phoneNumber}',

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
//                        color: Color(0xffF50303),
                    fontSize: 22,
//                    fontFamily: 'Itim-Regular',
                  ),
                ),

              ],
            ),
          ),

// PHONE: ENDS HERE.
        ],
      );

  }


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
    // Restaurant thisRestaurant3,
    // not required but just for printing...
    OneOrderFirebase
    oneOrderData3, // oneOrderData3.orderedItems --> for loop print..
    Uint8List restaurantNameBytesNotFuture3,
    ) async {
  print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');

  CustomerInformation customerForReciteGeneration = oneOrderData3.oneCustomer;

  List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

  final Ticket ticket = Ticket(PaperSize.mm58);

  // print('paper.value: ${paper.value}');
  print('oneOrderData3.restaurantName: ${oneOrderData3.restaurantName}');
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
    // Restaurant thisRestaurant3,
    OneOrderFirebase oneOrderData3,
    Uint8List restaurantNameBytesNotFuture3,
    ) async {
  print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');

  CustomerInformation customerForReciteGeneration = oneOrderData3.oneCustomer;

  List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

  final Ticket ticket = Ticket(PaperSize.mm58);

  // print('paper.value: ${paper.value}');
  // print('currentRestaurant: ${thisRestaurant3.name}');
  print('oneOrderData3.restaurantName: ${oneOrderData3.restaurantName}');
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
    // Restaurant thisRestaurant3,
    OneOrderFirebase oneOrderData3,
    Uint8List restaurantNameBytesNotFuture3,
    ) async {


  print('at here: Future<Ticket> demoReceiptOrderTypeTakeAway');


  CustomerInformation customerForReciteGeneration = oneOrderData3
      .oneCustomer;

  List<OrderedItem> orderedItems = oneOrderData3.orderedItems;

  final Ticket ticket = Ticket(PaperSize.mm58);

  // print('paper.value: ${paper.value}');
  // print('currentRestaurant: ${thisRestaurant3.name}');
  print('oneOrderData3.restaurantName: ${oneOrderData3.restaurantName}');
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
    // Restaurant thisRestaurant3,
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
  // print('currentRestaurant: ${thisRestaurant3.name}');
  print('oneOrderData3.restaurantName: ${oneOrderData3.restaurantName}');

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




//  FoodDetailImage









//LongHeaderPainterAfterShoppingCartPage
class LongHeaderPainterAfterShoppingCartPage extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfterShoppingCartPage(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/1.6, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff707070)
//          Colors.white
      ..strokeWidth = 1.6;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}
