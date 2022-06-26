import 'dart:async';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:convert';

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
  var url = "https://www.google.com/search?q=";

  void _handleURLButtonPress(
      BuildContext context, String url, String title) async {
    String urlImageApi = "";

    //await function get token
    await getLogoClient().then((String result) {
      urlImageApi = result.toString(); //use toString to convert as String
    });

    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(urlImageApi, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print("decrypt : $decrypted");
    print(encrypted.base64);

    url = url + encrypted.base64;
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
  var urlImage = "1234";
  // print("image from function : $urlImage");
  return urlImage;
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
