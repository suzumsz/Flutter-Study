import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'QRCode Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _qrcode;
  Uint8List bytes = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _qrcode != null ? _qrcode : 'QRCode 스캐너',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20,),

            //카메라를 이용한 스캔 버튼
            FlatButton(
              child: Text(
                  '카메라를 이용해서 읽어들이기',
                  style: TextStyle(fontSize: 20)
              ),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _fromCamera,
            ),

            //사진을 이용한 스캔 버튼
            SizedBox(height: 20,),
            FlatButton(
              child: Text(
                  '사진으로부터 읽어들이기',
                  style: TextStyle(fontSize: 20)
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: _fromPhoto,
            ),
          ],
        ),
      ),
    );
  }

  // 카메라를 이용해서 읽어들이기
  Future<void> _fromCamera() async {
    String qrcode = await scanner.scan();

    if (qrcode != null) {
      setState(() {
        _qrcode = qrcode;
      });
    } else {
      setState(() {
        _qrcode = 'QRCode 정보를 읽을 수 없습니다.';
      });
    }
  }

  // 사진으로부터 읽어들이기
  Future<void> _fromPhoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    Uint8List bytes = file.readAsBytesSync();
    String qrcode = await scanner.scanBytes(bytes);

    if (qrcode != null) {
      setState(() {
        _qrcode = qrcode;
      });
    } else {
      setState(() {
        _qrcode = 'QRCode 정보를 읽을 수 없습니다.';
      });
    }
  }
}

