import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class webview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return view();
  }
}
class view extends State<webview> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "الإرشادات المرجعية",
        ),
        backgroundColor: Colors.orangeAccent,
      ),

      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          controller.loadUrl('website/index.html');
        },
      ),
    );
  }
}
