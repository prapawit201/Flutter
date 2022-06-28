import 'dart:async';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:convert';

class Address {
  String province;
  String district;
  Address(this.province, this.district);
  Map toJson() => {
        'province': province,
        'district': district,
      };
}

class User {
  String name;
  int age;
  Address adress;
  User(this.name, this.age, this.adress);
  Map toJson() => {
        'name': name,
        'age': age,
        'adress': adress,
      };
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  var url =
      "https://restgo-assistants-p2jtvpwdta-df.a.run.app/app-loading?auth=";

  void _handleURLButtonPress(
      BuildContext context, String url, String title) async {
    String urlImageApi = "";

    //await function get token
    await getLogoClient().then((String result) {
      urlImageApi = result.toString(); //use toString to convert as String
    });

    // urlImageApi = jsonUser;

    final key = encrypt.Key.fromUtf8('KEY_ACCESS');
    final iv = encrypt.IV.fromLength(256);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));
    final encrypted = encrypter.encrypt(urlImageApi, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print("decrypt : $decrypted");
    print(encrypted.base64);

    url = url + encrypted.base64 + "&returnUrl=/dashboard";
    print("url final : $url");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView Flutter Example"),
      ),
      body: Center(
          child: Column(
        children: [
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Open Google.com :)",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(context, url, "Google.com");
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Open Medium.com",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(
                  context, "https://medium.com", "Medium.com");
            },
          ),
        ],
      )),
    );
  }
}

Future<String> getLogoClient() async {
  // var urlImage = "1234";
  Address address = Address('chonburi', 'sriracha');
  User user = User('babe', 22, address);
  String jsonUser = jsonEncode(user);

  // print("image from function : $urlImage");
  return jsonUser;
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() => WebViewPageState(this.url, this.title);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;
  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Column(children: [
          Expanded(
              child: WebView(
            initialUrl: this.url,
            javascriptMode: JavascriptMode.unrestricted,
            debuggingEnabled: true,
          ))
        ]));
  }
}
