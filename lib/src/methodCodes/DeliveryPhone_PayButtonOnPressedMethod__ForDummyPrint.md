

## onPressed method for TakeAwayDinningRomm_Method For Dummy Print Only:


### July 26:

```dart


 onPressed: () async {
                  
                  // DUMMY PRINT DELIVERY PHONE ......

                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);

                  print(
                      'debug print before invoking _startScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button ');



                  print(
                      'debug print after invoking _startScanDevices(); in cancelPaySelectUnobscuredDeliveryPhone cancel button');

                  print(
                      'cancelPaySelect.paymentTypeIndex: ${cancelPaySelectUnobscuredDeliveryPhone
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
                    logger.i('tempOrderWithdocId.orderdocId: ${cancelPaySelectUnobscuredDeliveryPhone
                        .orderdocId}');

                    List<
                        PrinterBluetooth> blueToothDevicesState = shoppingCartBloc
                        .getDevices;

                    print('blueToothDevicesState.length: ${blueToothDevicesState
                        .length}');



                    BluetoothDevice _x = new BluetoothDevice();
                    _x.name = 'Restaurant Printer';
                    _x.address = '0F:02:18:51:23:46';
                    _x.type = 3;
                    _x.connected = null;


                    PrinterBluetooth x = new PrinterBluetooth(_x);


                    _testPrintDummyDevices(x);

                    shoppingCartBloc.clearSubscription();

                    print('shopping Cart : shoppingCartBloc.clearSubscription() called... delivery Phone ');

                    return Navigator.pop(
                        context, cancelPaySelectUnobscuredDeliveryPhone);

                  }
                  
                },


```