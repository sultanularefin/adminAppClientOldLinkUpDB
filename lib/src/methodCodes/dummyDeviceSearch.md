

## dummy device search:

## august29::

```dart

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
```