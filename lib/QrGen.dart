import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class QrGen extends StatefulWidget {
  String _id;
  QrGen(String id){
    _id = id;
  }

  @override
  State<StatefulWidget> createState() => _QrGen(_id);
}

class _QrGen extends State<QrGen> {

  _QrGen(String id){
    _id = id;
    getApps(id);
  }

  GlobalKey globalKey = new GlobalKey();
  String _id;
  String _dataString = 'jh';
  String _desc;
  String _name;
  String _phone;
  String _passport;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

  Future getApps(String id) async {
    var response = await http.get(
        'http://167.172.188.11:8081/server-1.0-SNAPSHOT/get_application?id=' +
            id);
    print(response.body);
    List<dynamic> data = jsonDecode('[' + response.body + ']');
    print(data);
    _desc = data[0]['description'];
    _name = data[0]['name'];
    _passport = data[0]['passport'];
    _phone = data[0]['phone'];
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[
          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.4 * bodyHeight
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}