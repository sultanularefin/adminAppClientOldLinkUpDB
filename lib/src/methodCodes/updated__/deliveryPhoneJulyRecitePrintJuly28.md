

### 'pay' Button delivery Phone july Recite Print:

```dart

 onPressed: () async {

                  // Delivery Phone Recite Print.

                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);


                  print(
                      'cancelPaySelect.paymentTypeIndex Delivery Phone Recite Print..: '
                          '${cancelPaySelectUnobscuredDeliveryPhone
                          .paymentTypeIndex}');

                  // let's not use this order returned use the one from the bloc:
                  // Order tempOrderWithdocId
                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(
                      cancelPaySelectUnobscuredDeliveryPhone);


                  if ((cancelPaySelectUnobscuredDeliveryPhone.paymentButtonPressed == true) &&
                      (cancelPaySelectUnobscuredDeliveryPhone.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    logger.i(
                        'tempOrderWithdocId.orderdocId: ${cancelPaySelectUnobscuredDeliveryPhone
                            .orderdocId}');

                    List<PrinterBluetooth> blueToothDevicesState
                    = shoppingCartBloc.getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');

                    if (blueToothDevicesState.length == 0) {
                      logger.i('___________ blueTooth device not found _____');

//                      _showMyDialog2(
//                          '___________ blueTooth device not found _____ delivery phone pay button');

                      print(
                          'at here... __________ blueTooth device not found _____ delivery phone pay button');

                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(
                          context, cancelPaySelectUnobscuredDeliveryPhone);

                    }

                    else {
                      bool found = false;
                      int index = -1;
                      for (int i = 0; i < blueToothDevicesState.length; i++) {
                        ++index;

                        print(
                            'blueToothDevicesState[$i].name: ${blueToothDevicesState[i]
                                .name}');
                        print(
                            'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i]
                                .address}');

                        if ((blueToothDevicesState[i].name ==
                            'Restaurant Printer') ||
                            (blueToothDevicesState[i].address ==
                                '0F:02:18:51:23:46')) {
                          found = true;
                          break;

                          // _testPrint(oneBlueToothDevice);

                        }
                      };



                      logger.w('check device listed or not');
                      print('index: $index');
                      print('found == true ${found == true}');

                      if (found == true) {
                        print('found == true');
                        bool printResult = await _testPrint(
                            blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);


                        if (printResult == true) {
                          logger.i('printResult==true i.e. print successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUnobscuredDeliveryPhone);
                        }
                        else {
                          logger.i('printResult!=true i.e. print UN successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUnobscuredDeliveryPhone);
                        }
                      }
                      else {


                        logger.i(
                            '___________ Restaurant Printer,  not listed ... _____ printing wasn\'t successfull');

//                        _showMyDialog2(
//                            '___________ Restaurant Printer... not listed ...  printing wasn\'t successfull _____');


                        shoppingCartBloc.clearSubscription();
                        print('going to food Gallery page  Restaurant Printer not found');
                        return Navigator.pop(
                            context, cancelPaySelectUnobscuredDeliveryPhone);
                      }
                    }
                  }

                },
```


### updated: july 28, --- if printing isn't successful message/alert poped up.....

```dart


                onPressed: () async {

                  // Delivery Phone Recite Print.

                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);


                  print(
                      'cancelPaySelect.paymentTypeIndex Delivery Phone Recite Print..: '
                          '${cancelPaySelectUnobscuredDeliveryPhone
                          .paymentTypeIndex}');

                  // let's not use this order returned use the one from the bloc:
                  // Order tempOrderWithdocId
                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(
                      cancelPaySelectUnobscuredDeliveryPhone);


                  if ((cancelPaySelectUnobscuredDeliveryPhone.paymentButtonPressed == true) &&
                      (cancelPaySelectUnobscuredDeliveryPhone.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    logger.i(
                        'tempOrderWithdocId.orderdocId: ${cancelPaySelectUnobscuredDeliveryPhone
                            .orderdocId}');

                    List<PrinterBluetooth> blueToothDevicesState
                    = shoppingCartBloc.getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');

                    if (blueToothDevicesState.length == 0) {
                      logger.i('___________ blueTooth device not found _____');

                      await _showMyDialog2(
                          '___________ blueTooth device not found _____ delivery phone pay button');

                      print(
                          'at here... __________ blueTooth device not found _____ delivery phone pay button');

                      shoppingCartBloc.clearSubscription();
                      return Navigator.pop(
                          context, cancelPaySelectUnobscuredDeliveryPhone);

                    }

                    else {
                      bool found = false;
                      int index = -1;
                      for (int i = 0; i < blueToothDevicesState.length; i++) {
                        ++index;

                        print(
                            'blueToothDevicesState[$i].name: ${blueToothDevicesState[i]
                                .name}');
                        print(
                            'oneBlueToothDevice[$i].address: ${blueToothDevicesState[i]
                                .address}');

                        if ((blueToothDevicesState[i].name ==
                            'Restaurant Printer') ||
                            (blueToothDevicesState[i].address ==
                                '0F:02:18:51:23:46')) {
                          found = true;
                          break;

                          // _testPrint(oneBlueToothDevice);

                        }
                      };



                      logger.w('check device listed or not');
                      print('index: $index');
                      print('found == true ${found == true}');

                      if (found == true) {
                        print('found == true');
                        bool printResult = await _testPrint(
                            blueToothDevicesState[index]);

//                      _testPrintDummyDevices(blueToothDevicesState[index]);


                        if (printResult == true) {
                          logger.i('printResult==true i.e. print successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUnobscuredDeliveryPhone);
                        }
                        else {
                          logger.i('printResult!=true i.e. print UN successfull');
                          shoppingCartBloc.clearSubscription();
                          return Navigator.pop(
                              context, cancelPaySelectUnobscuredDeliveryPhone);
                        }
                      }
                      else {


                        logger.i(
                            '___________ Restaurant Printer,  not listed ... _____ printing wasn\'t successfull');

                       await
                       _showMyDialog2('___________ Restaurant Printer... not listed ...  printing wasn\'t successfull _____');


                        shoppingCartBloc.clearSubscription();
                        print('going to food Gallery page  Restaurant Printer not found');
                        return Navigator.pop(
                            context, cancelPaySelectUnobscuredDeliveryPhone);
                      }
                    }
                  }

                },

```