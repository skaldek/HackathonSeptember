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
    data = await jsonDecode('[' + response.body + ']');
    setState(() {
      scanResult = data[0]['user_id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Контроллер'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            scanResult == ''
                ? Text('Информация будет здесь.')
                : Container(
              alignment: Alignment.center,
                    width: 300,
                    child: Text(
                      "ФИО: " +
                          data[0]['name'] +
                          "\nТелефон: " +
                          data[0]['phone'] +
                          "\nПаспорт: " +
                          data[0]['passport'] +
                          "\nОписание: " +
                          data[0]['description'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
            SizedBox(height: 20),
            FlatButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.blueAccent,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                scanQRCode();
              },
              child: Text('Начать процесс!',
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
            ),
          ],
        ),
      ),
    );
  }
}
