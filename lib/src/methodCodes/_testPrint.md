
## July_27_testPrint produces Recite:



```dart

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
//      ticket.image(imageRestaurant);

    }).catchError((onError) {
      print(' error in getting restaurant name as image');
      print('false: means something wrong not printed');
      //means something wrong not printed
      return false;
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


//      _showMyDialog3(totalCostDeliveryBytes);
      // ssss
      print('before printing total cost for recite of delivery type order');
//      ticket.image(image);

    }).catchError((onError) {
      print(' error in getting totalDeliveryWidgetBytes');
      return false;
    });


//                            _handleSignIn();

    /* await */
    testFirebaseOrderFetch.whenComplete(() {
      print("called when future completes");
    }
    ).then((oneOrderData) {
      // TODO: any oneOrderData data validation needs to be done in  corresponding block page.
//      if ((oneOrderData.orderType == null) ||((oneOrderData.totalPrice ==null))) {
//        return false;
//      }


      print('reached here: $oneOrderData');


      Widget paidUnpaidDeliveryType2 = paidUnpaidDeliveryType(oneOrderData);

      final Future<
          Uint8List> paidUnpaidDeliveryTypeFutureWidget1 = createImageFromWidget(
          paidUnpaidDeliveryType2);

      Uint8List paidUnpaidDeliveryTypeWidgetBytes;

//      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


//      ImageAliasAnotherSource.Image imageRestaurant;


      /* await */
      paidUnpaidDeliveryTypeFutureWidget1.whenComplete(() {
        print("paidUnpaidDeliveryTypeFutureWidget1.whenComplete");
      }
      ).then((paidUnpaidDeliveryTypeInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
        print('calling ticket.image(imageRestaurant); ');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
        print(
            'paidUnpaidDeliveryTypeWidgetBytes: $paidUnpaidDeliveryTypeInBytes');


//        DDD
//        Widget orderInformationAndCustomerInformationWidget2 = paidUnpaidDeliveryType(
//            oneOrderData);

        Widget orderInformationAndCustomerInformationWidget2 = orderInformationAndCustomerInformationWidget(
            oneOrderData);

//        Uint8List> paidUnpaidDeliveryTypeFutureWidget1
        final Future<
            Uint8List> orderInformationAndUserInformationTop = createImageFromWidget(
            orderInformationAndCustomerInformationWidget2);

        Uint8List paidUnpaidDeliveryTypeWidgetBytes;

//      print('restaurantNameBytes: $restaurantNameBytesNotFuture');


//      ImageAliasAnotherSource.Image imageRestaurant;


        /* await */
        orderInformationAndUserInformationTop.whenComplete(() {
          print("paidUnpaidDeliveryTypeFutureWidget1.whenComplete");
        }
        ).then((orderInformationAndUserInformationTopInBytes) {
//        ImageAliasAnotherSource.Image imageRestaurant = ImageAliasAnotherSource.decodeImage(oneImageInBytes);
          print(
              'calling ticket.image(orderInformationAndUserInformationTopInBytes);');
//        paidUnpaidDeliveryTypeWidgetBytes = paidUnpaidDeliveryTypeInBytes;
          print(
              'orderInformationAndUserInformationTopInBytes: $orderInformationAndUserInformationTopInBytes');


//        oneOrderData  ssss ssss
//      ticket.image(imageRestaurant);

          Future<bool> isPrint =
          printTicket(
              paper,
              thisRestaurant,
              oneOrderData /*,imageRestaurant */,
              orderInformationAndUserInformationTopInBytes,
              restaurantNameBytesNotFuture,
              totalCostDeliveryBytes,
              paidUnpaidDeliveryTypeInBytes);

//        Future<OneOrderFirebase> testFirebaseOrderFetch=

          isPrint.whenComplete(() {
            print("called when future completes");
//          return true;
          }
          ).then((printResult) async {
            if(printResult==true){
              print("printResult: $printResult");
              Future<String> docID= shoppingCartBloc
                  .recitePrinted(oneOrderForReceipt.orderdocId,'Done');


//              --


              docID.whenComplete(() => print('printing completed..')).then((value){
                print('docID in [Future<bool> isPrin] await shoppingCartBloc.recitePrintedt: $docID');
                return true;
              }).catchError((onError){
                return false;


              });
//            --
              return false;
            }
            else{
              return false;
            }

          }).catchError((onError) {
            print('printing not successful: $onError');
            return false;
          });
        }).catchError((onError) {
          print(' error handler for getting paidUnpaidDeliveryTypeFutureWidget1');
          print('false: means something wrong not printed');
          //means something wrong not printed
          return false;
        });


//      if ((oneOrderData.orderType != null) ||(oneOrderData.totalPrice !=null)) {
//      await Future.delayed(Duration(milliseconds: 1000));


        // }
        /*
      else{
        return false;
//        ALTERNATE FOR THIS:
//        if ((oneOrderData.orderType == null) || (oneOrderData.totalPrice ==null) || (oneOrderData.totalPrice ==0.0) ){
//          return false;
//        }
      }
      */

      }).catchError((onError) {
        print(' error in getting paidUnpaidDeliveryTypeInBytes');
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
```