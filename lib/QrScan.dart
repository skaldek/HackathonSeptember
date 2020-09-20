import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;

class QrScan extends StatefulWidget {
  @override
  _QrScan createState() => _QrScan();
}

class _QrScan extends State<QrScan> {
  String scanResult = '';
  List<dynamic> data = new List<dynamic>();

  //function that launches the scanner
  Future scanQRCode() async {
    String cameraScanResult = await scanner.scan();
    var response = await http.get(
        'http://167.172.188.11:8081/server-1.0-SNAPSHOT/user_get?token=' +
            cameraScanResult);
    print(response.body);
    List<dynamic> data1 = jsonDecode(response.body);
    print(data1);
    response = await http.get(
        'http://167.172.188.11:8081/server-1.0-SNAPSHOT/get_application?id=' +
            data1[0]['id']);
    data = await jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Охранник'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            scanResult == ''
                ? Text('Информация будет здесь.')
                : Text(scanResult),
            SizedBox(height: 20),
            FlatButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.blueAccent,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {},
              child: Text('Начать процесс!',
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
