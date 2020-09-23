
## July_27_testPrint_dummy : dummy

```dart

void _testPrintDummyDevices(PrinterBluetooth printer) async {
    // NOT REQUIRED SINCE DUMMY...

    /*
    printerManager.selectPrinter(printer);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    */


    print("_testPrintDummyDevices");

    final shoppingCartBloc = BlocProvider.of<ShoppingCartBloc>(context);

    Restaurant thisRestaurant = shoppingCartBloc.getCurrentRestaurant;

    Order oneOrderForReceipt = shoppingCartBloc.getCurrentOrder;

    print('oneOrderForReceipt.orderdocId: ${oneOrderForReceipt.orderdocId}');


//    Future<OneOrderFirebase> testFirebaseOrderFetch =
//    shoppingCartBloc.fetchOrderDataFromFirebase(
//        oneOrderForReceipt.orderdocId.trim());


    TODO: // something wrong maybe here. docID needs to be processed...

    Future<String> docID = shoppingCartBloc
        .recitePrinted(oneOrderForReceipt.orderdocId,'dummyPrint');

//                    recitePrinted

    print('docID1 in dummy Print: $docID');

    Future<OneOrderFirebase> testFirebaseOrderFetch =
    shoppingCartBloc.fetchOrderDataFromFirebase(
        oneOrderForReceipt.orderdocId.trim());


    Widget restaurantName2 = restaurantName(thisRestaurant.name);
    final Future<Uint8List> restaurantNameBytesFuture = createImageFromWidget(
        restaurantName2);
    Uint8List restaurantNameBytesNotFuture;

    print('restaurantNameBytes: $restaurantNameBytesNotFuture');


    ImageAliasAnotherSource.Image imageRestaurant;


    /* await */
    restaurantNameBytesFuture.whenComplete(() {
      print("restaurantNameBytes.whenComplete called when future completes");
    }
    ).then((oneImageInBytes) {
      ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource
          .decodeImage(oneImageInBytes);
      print('calling ticket.image(imageRestaurant); ');
      restaurantNameBytesNotFuture = oneImageInBytes;
//      ticket.image(imageRestaurant);

    }).catchError((onError) {
      print(' error in getting restaurant name as image');
    });

    // Print image
    Widget totalDeliveryWidget2 = subTotalTotalDeliveryCost(
        oneOrderForReceipt.totalPrice);
    Uint8List totalCostDeliveryBytes;

    final Future<Uint8List> totalDeliveryWidgetBytes = createImageFromWidget(
        totalDeliveryWidget2);

    /* await */
    totalDeliveryWidgetBytes.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneImageInBytes) {
//      final ImageAliasAnotherSource.Image image = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
      totalCostDeliveryBytes = oneImageInBytes;
      print('before printing total cose for recite of delivery type order');
//      ticket.image(image);

    }).catchError((onError) {
      print(' error in getting restaurant name as image');
    });


//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneOrderData) {
      Widget paidUnpaidDeliveryType2 = paidUnpaidDeliveryType(oneOrderData);

      final Future<Uint8List> paidUnpaidDeliveryTypeFutureWidget1 = createImageFromWidget(
          paidUnpaidDeliveryType2);

      Uint8List paidUnpaidDeliveryTypeWidgetBytes;

//      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


//      ImageAliasAnotherSource.Image imageRestaurant;


      /* await */
      paidUnpaidDeliveryTypeFutureWidget1.whenComplete(() {
        print(
            "restaurantNameBytes.whenComplete called when future completes");
      }
      ).then((paidUnpaidDeliveryTypeInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
        print(
            'paidUnpaidDeliveryTypeInBytes: $paidUnpaidDeliveryTypeInBytes ');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
//        print('paidUnpaidDeliveryTypeWidgetBytes: $paidUnpaidDeliveryTypeWidgetBytes');
//      ticket.image(imageRestaurant);





//        DDD
//        Widget orderInformationAndCustomerInformationWidget2 = paidUnpaidDeliveryType(
//            oneOrderData);

        Widget orderInformationAndCustomerInformationWidget2 = orderInformationAndCustomerInformationWidget(
            oneOrderData);

//        Uint8List> paidUnpaidDeliveryTypeFutureWidget1
        final Future<Uint8List> orderInformationAndUserInformationTop = createImageFromWidget(
            orderInformationAndCustomerInformationWidget2);

        Uint8List paidUnpaidDeliveryTypeWidgetBytes;








        /* await */
        orderInformationAndUserInformationTop.whenComplete(() {
          print("paidUnpaidDeliveryTypeFutureWidget1.whenComplete");
        }
        ).then((orderInformationAndUserInformationTopInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
          print('calling ticket.image(orderInformationAndUserInformationTopInBytes);');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
          print(
              'orderInformationAndUserInformationTopInBytes: $orderInformationAndUserInformationTopInBytes');


//        oneOrderData  ssss ssss
//      ticket.image(imageRestaurant);






          printTicketDummy(/*paper, */
              thisRestaurant, oneOrderData, imageRestaurant,
              restaurantNameBytesNotFuture,orderInformationAndUserInformationTopInBytes,
              totalCostDeliveryBytes, paidUnpaidDeliveryTypeInBytes);
        }).catchError((onError) {
          print(' error in getting restaurant name as image');
          print('false: means something wrong not printed');
          //means something wrong not printed
          return false;
        });
      }).catchError((onError) {
        print(' error in getting restaurant name as image');
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
    });
  }


```