import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrScan extends StatefulWidget {
  @override
  _QrScan createState() => _QrScan();
}

class _QrScan extends State<QrScan> {
  String scanResult = '';

  //function that launches the scanner
  Future scanQRCode() async {
    String cameraScanResult = await scanner.scan();
    setState(() {
      scanResult = cameraScanResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scan Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            scanResult == '' ? Text('Result will be displayed here') : Text(scanResult),
            SizedBox(height: 20),
            RaisedButton(
              color: Colors.blue,
              child: Text('Click To Scan', style: TextStyle(color: Colors.white),),
              onPressed: scanQRCode,
            )
          ],
        ),
      ),
    );
  }
}