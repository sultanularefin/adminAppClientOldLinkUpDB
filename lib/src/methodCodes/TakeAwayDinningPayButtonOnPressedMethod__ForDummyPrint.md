

## onPressed method for TakeAwayDinningRomm_Method For Dummy Print Only:


### July 26:

```dart

 onPressed: () async {

                  // TAkEAWAY AND DINNING DUMMY PRINT ....
                  final shoppingCartBloc = BlocProvider.of<
                      ShoppingCartBloc>(context);


                  print(
                      'cancelPaySelect.paymentTypeIndex: ${cancelPaySelectUNObscuredTakeAwayDinning
                          .paymentTypeIndex}');


                  // PRINTING CODES WILL BE PUTTED HERE.

                  print(
                      'debug print before invoking _startScanDevices(); in cancelPaySelectUNObscuredTakeAway || pay button');

                  Order tempOrderWithdocId = await shoppingCartBloc
                      .paymentButtonPressed(cancelPaySelectUNObscuredTakeAwayDinning);





                  if ((cancelPaySelectUNObscuredTakeAwayDinning.paymentButtonPressed == true) &&
                      (cancelPaySelectUNObscuredTakeAwayDinning.orderdocId == '')) {
                    _scaffoldKeyShoppingCartPage.currentState
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
                        .showSnackBar(
                        SnackBar(content: Text("someThing went wrong")));
                    print('something went wrong');
                  }
                  else {
                    print('tempOrderWithdocId.orderdocId: ${cancelPaySelectUNObscuredTakeAwayDinning
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


                    print('Unboscured takeAway || '
                        'DinningRoom Dummy print--- returning to FoodGallery Page');
                    return Navigator.pop(
                        context, cancelPaySelectUNObscuredTakeAwayDinning);


                  }

                },

```